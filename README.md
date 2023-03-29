# AZFinder

Sequencing depth  method to call Copy Number Variants in the Human Y chromosome Palindromes and AZFc based on Teitz et al. 2018 procedure.

Detailed information about this method can be found in Ravasini, Hajiesmaeil et al...

## Software required:

```samtools``` (tested with samtools 1.16)

R package:```tidyverse```


## 1) Call depth for the ampliconic and normalization region 

   **Command:**

   ```samtools depth -ab AmpliconPositions_hg19.bed -f bamlist > amplicon_depth.txt```
   
   ```samtools depth -ab NormalizationRegion_hg19.bed -f bamlist > norm_region_depth.txt```
   
   **Files needed:**
   
   ```AmpliconPositions_hg19.bed``` is the file with the ampliconic positions in hg19 (if your genome is aligned against hg38 use  ```AmpliconPositions_hg38.bed```)
   
   ```NormalizationRegion_hg19.bed``` is the file with the normalization region positions in hg19 (if your genome is aligned against hg38 use  ```NormalizationRegion_hg38.bed```)
   
   ```bamlist``` is a file with the list of bamfiles you want to analyze.
   
## 2) Run R script

   **Important:**
   
   Before running the R script change the part ```Path to amplicon depth file``` with your ```amplicon_depth.txt``` file and ```Path to control region depth file``` with your ```norm_region_depth.txt``` file.
   
   You need a file called ```sample_list.txt``` with samples names, one per row, in the exact order of the ```bamlist``` file.
   
   **run R script:**

   ```GetCopyNumberCalls_hg19.R``` or ```GetCopyNumberCalls_hg38.R``` depending on which reference your genomes are aligned to. 
   
## 3) Results

   You will get a ```Normalized_depth_values.txt``` file with the normalized depth value for each amplicon and a ```Copy_number_calls.txt``` file with the corresponding copy number for each amplicon.
   
   
   
