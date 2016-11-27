################################################################################
# Script para crear script en lenguaje R que crea las gráficas de dispersión de
# variables CAPM de fondos de Renta Variable Mexicana, agrupadas de acuerdo al
# análisis CORT de agrupamiento.
################################################################################
# Descargar los paquetes de CRAN
#install.packages("ggplot2")  # versión: 2.1
# cargar paquetes a utilizar
#require(ggplot2) 
#library("ggplot2", lib.loc="~/R/x86_64-suse-linux-gnu-library/3.2")

# Carga de variables CAPM por fondo y clusters donde están agrupados los fondos
#df_capm_pclust <- read.csv("RVMexico.capm_pclust_20160525113854.csv")

# Datos de los grupos formados por nivel de significancia
l_significance <- c("0.05","0.10","0.15","0.25","0.35","0.50","0.65","0.75","0.85","0.95","1.00")
#l_significance <- c("0.05","0.10","0.15","0.25","0.35","0.50")
l_significance_cols <- c("pvalues.clust.w.sig..0.05","pvalues.clust.w.sig..0.10","pvalues.clust.w.sig..0.15","pvalues.clust.w.sig..0.25","pvalues.clust.w.sig..0.35","pvalues.clust.w.sig..0.50","pvalues.clust.w.sig..0.65","pvalues.clust.w.sig..0.75","pvalues.clust.w.sig..0.85","pvalues.clust.w.sig..0.95","pvalues.clust.w.sig..1.00")
#l_significance_cols <- c("pvalues.clust.w.sig..0.05","pvalues.clust.w.sig..0.10","pvalues.clust.w.sig..0.15","pvalues.clust.w.sig..0.25","pvalues.clust.w.sig..0.35","pvalues.clust.w.sig..0.50")
# Datos de las variables CAPM a graficar
l_capm_vars <- c("alpha.v.BMV...w..CETES.364D", "beta.v.BMV...w..CETES.364D", "r.squared", "standar.deviation", "Sharpe.Ratio...w..CETES.364D")
l_capm_names <- c("Alpha", "Beta", "R Cuadrada", "Desviación Estándar", "Razón de Sharpe")
n_capm_vars <- length(l_capm_vars)
n_capm_next <- 2

# Instrucciones para comenzar el script a generar
t_instructions <- paste('library("ggplot2", lib.loc="~/R/x86_64-suse-linux-gnu-library/3.2")\n')
#t_instructions <- paste(t_instructions, 'df_capm_pclust <- read.csv("RVMexico.capm_pclust_20160525113854.csv")')
t_instructions <- paste(t_instructions, 'df_capm_pclust <- read.csv("RVMexico.capm_pclust_20160908165248.csv")')

### Gráficas: CAPM - var1 X CAPM - var2 ###
for (i_capm_var in 1:(n_capm_vars - 1))
{
    for (i_capm_var2 in n_capm_next:n_capm_vars)
    {
        if (i_capm_var != i_capm_var2){
            for (i_significance in 1:length(l_significance)) {
            # Versión A: Con interpolación lineal sobre el rango de datos
                #ggplot(df_capm_pclust, aes(x=alpha.v.BMV...w..CETES.364D, y=beta.v.BMV...w..CETES.364D, color=factor(pvalues.clust.w.sig..0.05))) + labs(x="CAPM - Alpha", y="CAPM - Beta", title="Clusters con nivel de significancia: 0.05", color="Cluster") + theme(plot.title = element_text(lineheight=.8, face="bold")) + geom_point(shape=19, aes(colour=factor(pvalues.clust.w.sig..0.05))) + scale_colour_hue(l=40) + geom_smooth(method=lm, se=FALSE, aes(color=factor(pvalues.clust.w.sig..0.05)))
            # Versión B: Con interpolación lineal sobre toda la gráfica
                #ggplot(df_capm_pclust, aes(x=alpha.v.BMV...w..CETES.364D, y=beta.v.BMV...w..CETES.364D, color=factor(pvalues.clust.w.sig..0.05))) + labs(x="CAPM - Alpha", y="CAPM - Beta", title="Clusters con nivel de significancia: 0.05", color="Cluster") + theme(plot.title = element_text(lineheight=.8, face="bold")) + geom_point(shape=19, aes(colour=factor(pvalues.clust.w.sig..0.05))) + scale_colour_hue(l=40) + geom_smooth(method=lm, fullrange=TRUE, se=FALSE, aes(color=factor(pvalues.clust.w.sig..0.05)))
            # Versión C: Con interpolación lineal sobre el rango de datos y sombreado de cobertura
                #ggplot(df_capm_pclust, aes(x=alpha.v.BMV...w..CETES.364D, y=beta.v.BMV...w..CETES.364D, color=factor(pvalues.clust.w.sig..0.05))) + labs(x="CAPM - Alpha", y="CAPM - Beta", title="Clusters con nivel de significancia: 0.05", color="Cluster") + theme(plot.title = element_text(lineheight=.8, face="bold")) + geom_point(shape=19, aes(colour=factor(pvalues.clust.w.sig..0.05))) + scale_colour_hue(l=40) + geom_smooth(method=lm, level=0.75, aes(color=factor(pvalues.clust.w.sig..0.05)))
            
            # Versión D: Solo puntos de dispersión
                #print(paste('
                #    ggplot(df_capm_pclust, aes(x=',l_capm_vars[i_capm_var],', y=',l_capm_vars[i_capm_var2],', color=factor(',l_significance_cols[i_significance],'))) + labs(x="CAPM -',l_capm_names[i_capm_var],'", y="CAPM -',l_capm_names[i_capm_var2],'", title="Clusters con nivel de significancia: ', l_significance[i_significance],'", color="Cluster") + theme(plot.title = element_text(lineheight=.8, face="bold")) + geom_point(shape=19, aes(colour=factor(',l_significance_cols[i_significance],'))) + scale_colour_hue(l=40)
                #'))
                #print(paste('ggsave("RVMexico.capm_pclust_sig',l_significance[i_significance], '_capm_',l_capm_names[i_capm_var],'X',l_capm_names[i_capm_var2],'_ver_D.png", scale=5)'))
                t_instructions <- paste(t_instructions, '
                    ggplot(df_capm_pclust, aes(x=',l_capm_vars[i_capm_var],', y=',l_capm_vars[i_capm_var2],', color=factor(',l_significance_cols[i_significance],'))) + labs(x="CAPM -',l_capm_names[i_capm_var],'", y="CAPM -',l_capm_names[i_capm_var2],'", title="Clusters con nivel de significancia:', l_significance[i_significance],'", color="Cluster") + theme(plot.title = element_text(lineheight=.8, face="bold")) + geom_point(shape=19, aes(colour=factor(',l_significance_cols[i_significance],'))) + scale_colour_hue(l=40)
                ')
                t_instructions <- paste(t_instructions, 'ggsave("RVMexico.capm_pclust_sig',l_significance[i_significance],'_capm_',l_capm_names[i_capm_var],'X',l_capm_names[i_capm_var2],'_ver_D.png", scale=4, limitsize=FALSE)')
            } #for
        } #if
    } #for
    
    n_capm_next <- n_capm_next + 1
} #for
# Crear archivo a ejecutar
write(t_instructions, "ananov_tsclust_scatterplots_instructions.r")
print(t_instructions)

# Para crear las gráficas, ejecutar:
# R -f ananov_tsclust_scatterplots_instructions.r
