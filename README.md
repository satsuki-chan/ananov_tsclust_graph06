# Scatter plots graphs of the comparissions of the Modern Portfolio Theory (MPT) variables from Mexican equity funds (from 31-12-2010 to 31-12-2015), grouped by the CORT clustering analysis.

## R version 3.2.3 (2015-12-10) -- "Wooden Christmas-Tree"
Platform: x86_64-suse-linux-gnu (64-bit)
>**R Core Team (2015)**. *R: A language and environment for statistical computing*. Vienna, Austria: R Foundation for Statistical Computing.

>https://www.R-project.org/

##Aditional R packages:
###ggplot2 - Version == 2.1.
>**Hadley Wickham (2009)**. *ggplot2: Elegant Graphics for Data Analysis*. R package version 2.1. NY: Springer-Verlag.

>http://ggplot2.org


##Execution instructions
####Script file:
* `ananov_tsclust_scatterplots.r`

####Input file:
* `RVMexico.capm_pclust_<YYYYmmddHHMMSS>.csv`

####Output files:
* `Rplots.pdf`
* `RVMexico.capm_pclust_sig<significance_level>_capm_<MPT_var1>X<MPT_var2>.png`

####To execute the script:

1. Verify that you have installed R, version 3.2.3 or above
2. Check that all the files are in the same directory and that you have reading and writing permissions
3. Open a terminal window in the directory and execute:
  * `R -f ananov_tsclust_scatterplots.r`
4. Afterwards, execute to generate the scatter plots:
  * `R -f ananov_tsclust_scatterplots_instructions.r`
