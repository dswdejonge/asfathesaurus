setwd("data-raw")
library(pdftools)
library(tidyverse)

# Read pdf
full_thesaurus_text <- pdftools::pdf_text("thesaurus.pdf")
full_thesaurus_table <- pdftools::pdf_data("thesaurus.pdf")

# The thesaurus starts at heading '9. THESAURUS TERMS'
# Find first page
start_heading <- "9. THESAURUS TERMS"
thesaurus_start <- grep(start_heading, full_thesaurus_text)

# Check out first page, and decide on delineation columns
first_page <-  full_thesaurus_table[[thesaurus_start]]
hist(first_page$x)

start_col2 <- 200
start_col3 <- 390

extract_thesaurus <- function(){
  # Create empty list for storage
  digitized_thesaurus <- list()
  starti <- 1
  stopi <- 0
  for(page_number in thesaurus_start:length(full_thesaurus_table)){
    print(page_number)
    mypage <- full_thesaurus_table[[page_number]]

    v1 <- mypage %>%
      # Divide into columns
      dplyr::mutate(colnr = ifelse(x < start_col2, 1,
                                   ifelse(x < start_col3, 2, 3))) %>%
      # Per row in columns paste text
      dplyr::group_by(colnr, y) %>%
      dplyr::summarise(
        x_start = min(x),
        text = paste(text, collapse = " ")) %>%
      dplyr::ungroup() %>%
      # Remove header text
      dplyr::filter(text != start_heading) %>%
      # Remove first (header) and last (footer) row
      dplyr::filter(y != min(mypage$y) & y != max(mypage$y)) %>%
      # Add order and pagenumber
      dplyr::mutate(data_order = starti:(stopi+n()),
                    page_number = page_number)
    digitized_thesaurus[[page_number]] <- v1
    starti <- max(v1$data_order)+1
    stopi <- starti-1
  }
  digitized_thesaurus <- digitized_thesaurus %>% dplyr::bind_rows()
  return(digitized_thesaurus)
}

merge_multiple_rows <- function(df){
  # Find indent for each descriptor
  descriptors_i <- c(
    min(dplyr::pull(df[which(df$colnr == 1),],x_start)),
    min(dplyr::pull(df[which(df$colnr == 2),],x_start)),
    min(dplyr::pull(df[which(df$colnr == 3),],x_start)))

  result <- df %>%
    # Note if the row has a descriptor in it
    dplyr::mutate(isDescriptor = ifelse(x_start %in% descriptors_i, TRUE, FALSE),
                  term_group = ifelse(isDescriptor, 1, 0),
                  term_group = cumsum(term_group)) %>%
    # Identify relational new sections
    dplyr::mutate(text = ifelse(grepl(":", text), paste0("/",text),text)) %>%
    # Paste multiple rows together (all rows with description term, all rows with definitions)
    dplyr::group_by(term_group, isDescriptor) %>%
    dplyr::summarise(text = paste(text, collapse = ";"))
  return(result)
}

shape_table <- function(df){
  result <- df %>%
    # Split into descriptor and definition cols
    dplyr::mutate(newcolname = ifelse(isDescriptor, "Descriptor", "Definition")) %>%
    dplyr::select(-isDescriptor) %>%
    tidyr::pivot_wider(names_from = newcolname, values_from = text) %>%
    # remove first seperator /
    dplyr::mutate_at(vars(Definition), function(x){return(substring(x, first = 2))}) %>%
    tidyr::separate(Definition, c("a","b","c","d","e","f"), "/") %>%
    tidyr::separate(a, c("a.rel", "a.def"), ":") %>%
    tidyr::separate(b, c("b.rel", "b.def"), ":") %>%
    tidyr::separate(c, c("c.rel", "c.def"), ":") %>%
    tidyr::separate(d, c("d.rel", "d.def"), ":") %>%
    tidyr::separate(e, c("e.rel", "e.def"), ":") %>%
    tidyr::separate(f, c("f.rel", "f.def"), ":") %>%
    dplyr::ungroup()

  subdf <- list()
  for(i in 1:6){
    letter <- letters[i]
    var.rel <- paste0(letter,".rel")
    var.def <- paste0(letter,".def")
    subdf[[i]] <- result %>%
      dplyr::select(Descriptor,
                    sym(var.rel),
                    sym(var.def)) %>%
      dplyr::rename(Relation = sym(var.rel),
                    Definition = sym(var.def))
  }

  final <- subdf %>%
    dplyr::bind_rows() %>%
    dplyr::filter(!is.na(Relation)) %>%
    dplyr::mutate(Definition = ifelse(Relation == "SN",
                                      gsub(";", " ", Definition),
                                      Definition)) %>%
    # If multiple relational terms, spread over rows
    tidyr::separate_rows(Definition, sep = ";") %>%
    # Remove empty rows
    dplyr::filter(Definition != "") %>%
    # Remove leading and trailing whitespace
    dplyr::mutate(Definition = trimws(Definition))
  return(final)
}

asfathesaurus <- extract_thesaurus() %>%
  merge_multiple_rows() %>%
  shape_table

usethis::use_data(asfathesaurus)
