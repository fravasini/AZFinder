# AZFinder

Sequencing depth  method to call Copy Number Variants in the Human Y chromosome Palindromes and AZFc based on [Teitz et al. 2018](https://www.sciencedirect.com/science/article/pii/S0002929718302349?via%3Dihub) procedure and [Ravasini et al. 2021](https://www.frontiersin.org/articles/10.3389/fgene.2021.669405/full) EMA ratio method.

**Citation:**

Hajiesmaeil M, Ravasini F, Risi F, Magnarini G, Olivieri A, D’Atanasio E, Galehdari H, Trombetta B, Cruciani F (2023) High incidence of AZF duplications in clan-structured Iranian populations detected through Y chromosome sequencing read depth analysis. doi: [10.1038/s41598-023-39069-7](https://www.nature.com/articles/s41598-023-39069-7)


For issues, please email me: francesco.ravasini@uniroma1.it

## Software required:

```python3```

```samtools``` (tested with samtools 1.16)

R package:```tidyverse```


## Usage 

   **Download and installation:**

   ```wget https://github.com/fravasini/AZFinder/archive/refs/heads/main.zip```
   
   ```unzip main.zip```

   ```cd AZFinder-main```
   
   **Run:**
   
   ```python AZFinder.py {reference} --bamlist={your_bamlist}``` 
   
   ```{reference}``` is the reference your bam files are aligned to, use ```hg19``` or ```hg38```.

   ```{your_bamlist}``` is a file with the list of bamfiles you want to analyze, one file per row.

   Example for running AZFinder on a list of bam files (bamlist.txt) aligned to hg19 reference:

   ```python AZFinder.py hg19 --bamlist=bamlist.txt```
 
   
   
## Results

   After running you will get:
   
  - ```Normalized_depth_values.txt```: a file with the normalized depth value for each amplicon
    
  - ```Copy_number_calls.txt```: a file with the corresponding copy number for each amplicon.
    
  - The normalized EMA plots for the AZFc region in png format, for each sample.
   
   
   
   
  
