# asfathesaurus

Dataset with ASFA (Aquatic Sciences and Fisheries, FAO) thesaurus descriptors.

The ASFA thesaurus contains terms often used in ocean science and is publicly available as pdf file. In order to facilitate easy searching of terms and promote standardization of ocean science language, I converted the information from the PDF file to a dataframe and csv file. This rendition of the ASFA thesaurus was not created by the Food and Agriculture Organization of the United Nations (FAO). FAO is not responsible for the content or accuracy of this translation. The original edition shall be the authoritative edition.

For rules and conventions please refer to the original ASFA thesaurus PDF publication. I cannot guarantee the dataset does not contain any mistakes. If you find something fishy (pun intended) let me know.

Source:  
FAO. 2019. Aquatic Sciences and Fisheries Information System: Aquatic Sciences and Fisheries Thesaurus − Descriptors used in the Aquatic Sciences and Fisheries Information System. ASFIS-6 (Rev. 4). Rome, FAO. http://www.fao.org/3/k5032e/k5032e00.htm

License:
CC BY-NC-SA 3.0 IGO (https://creativecommons.org/licenses/by-nc-sa/3.0/igo/legalcode)

## Installation
``` r
devtools::install_github("dswdejonge/asfathesaurus")
```

## Usage
``` r
# Load
library(asfathesaurus)

# View documentation
?asfathesaurus

# View first entries
head(asfathesaurus)

# Write to CSV
write.csv(asfathesaurus, file = thesaurus.csv)
```

## Preview
![preview](https://raw.githubusercontent.com/dswdejonge/asfathesaurus/master/data-raw/preview.png)  

## Details
