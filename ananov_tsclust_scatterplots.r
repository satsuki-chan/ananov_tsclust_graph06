################################################################################
# Script to generate the code that creates the scatter plots graphs of the comparissions
# of the Modern Portfolio Theory (MPT) variables from Mexican equity funds,
# grouped by the CORT clustering analysis.
################################################################################
# Download and install of needed packages from CRAN Package archive website:
#install.packages("ggplot2")              # Version >=2.1

# Significance levels:
## Columns in data file
l_significance_cols <- c("pvalues.clust.w.sig..0.05","pvalues.clust.w.sig..0.10","pvalues.clust.w.sig..0.15","pvalues.clust.w.sig..0.25","pvalues.clust.w.sig..0.35","pvalues.clust.w.sig..0.50","pvalues.clust.w.sig..0.65","pvalues.clust.w.sig..0.75","pvalues.clust.w.sig..0.85","pvalues.clust.w.sig..0.95","pvalues.clust.w.sig..1.00")
## Labels
l_significance <- c("0.05","0.10","0.15","0.25","0.35","0.50","0.65","0.75","0.85","0.95","1.00")

# MPT variables to compare:
## Columns in data file
l_capm_vars <- c("alpha.v.BMV...w..CETES.364D", "beta.v.BMV...w..CETES.364D", "r.squared", "standar.deviation", "Sharpe.Ratio...w..CETES.364D")
## Labels
#l_capm_names <- c("Alpha", "Beta", "R Cuadrada", "Desviación Estándar", "Razón de Sharpe")
l_capm_names <- c("Alpha", "Beta", "R Squared", "Standard Deviation", "Sharpe Ratio")
n_capm_vars <- length(l_capm_vars)
n_capm_next <- 2

# Instruction to start the script
# Load required packages, besides base packages from R version 3.2.3 (2015-12-10) -- "Wooden Christmas-Tree"
t_instructions <- paste('require(ggplot2)\n')
t_instructions <- paste(t_instructions, 'df_capm_pclust <- read.csv("RVMexico.capm_pclust_20160908165248.csv")')

### Scatter plots: MPT - var1 X MPT - var2 ###
for (i_capm_var in 1:(n_capm_vars - 1))
{
    for (i_capm_var2 in n_capm_next:n_capm_vars)
    {
        if (i_capm_var != i_capm_var2){
            for (i_significance in 1:length(l_significance)) {
                t_instructions <- paste(t_instructions, '
                    ggplot(df_capm_pclust, aes(x=',l_capm_vars[i_capm_var],', y=',l_capm_vars[i_capm_var2],', color=factor(',l_significance_cols[i_significance],'))) + labs(x="MPT -',l_capm_names[i_capm_var],'", y="MPT -',l_capm_names[i_capm_var2],'", title="Clusters with significance level:', l_significance[i_significance],'", color="Cluster") + theme(plot.title = element_text(lineheight=.8, face="bold")) + geom_point(shape=19, aes(colour=factor(',l_significance_cols[i_significance],'))) + scale_colour_hue(l=40)
                ')
                t_instructions <- paste(t_instructions, 'ggsave("RVMexico.capm_pclust_sig',l_significance[i_significance],'_capm_',l_capm_names[i_capm_var],'X',l_capm_names[i_capm_var2],'.png", scale=4, limitsize=FALSE)')
            } #for
        } #if
    } #for

    n_capm_next <- n_capm_next + 1
} #for
# Print file with script to execute
write(t_instructions, "ananov_tsclust_scatterplots_instructions.r")
print(t_instructions)

# To create the scatter plots, execute:
# R -f ananov_tsclust_scatterplots_instructions.r
