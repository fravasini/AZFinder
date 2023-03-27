# package needed
library(tidyverse)

# read dataframe
df_amplicon<- read.table("Path to amplicon depth file",header=F)
df_norm_reg <- read.table("Path to control region depth file", header=F)

# read sample list
list<-scan("sample_list.txt",character())

# change column names and modify dataframe
colnames(df_amplicon) <- c("chr","pos", list)
colnames(df_norm_reg) <- c("chr","pos", list)
df_norm_reg <- df_norm_reg%>%select(-chr)
df_amplicon <- df_amplicon%>%select(-chr)

# define amplicons boundaries
b <- df_amplicon[c(464566:549874,722983:808613,984333:1070124,1727309:1813149),]
y <- df_amplicon[c(1070125:1308712,1488291:1727308),]
r <- df_amplicon[c(873005:898651,898652:924493,1371917:1397648,1397649:1423261),]
gr <- df_amplicon[c(924494:984332,1813150:1872683),]
g <- df_amplicon[c(808614:873004,1308713:1371916,1423262:1488290),]
t <- df_amplicon[c(549875:636544,636545:722982),]
P4 <- df_amplicon[c(280188:464565),]
P5 <- df_amplicon[c(117143:280187),]
P6 <- df_amplicon[c(43757:117142),]
P7 <- df_amplicon[c(33161:43756),]
P8 <- df_amplicon[c(1:33160),]

df_ <- list()

#calculating the normalized depth for each sample and each amplicon
for(i in list) {
  mean_norm <- mean(df_norm_reg[[i]])
  mean_b <- mean(b[[i]])
  mean_y <- mean(y[[i]])
  mean_r <- mean(r[[i]])
  mean_gr <- mean(gr[[i]])
  mean_g <- mean(g[[i]])
  mean_t <- mean(t[[i]])
  mean_P4 <- mean(P4[[i]])
  mean_P5 <- mean(P5[[i]])
  mean_P6 <- mean(P6[[i]])
  mean_P7 <- mean(P7[[i]])
  mean_P8 <- mean(P8[[i]])
  ratio_b <- as.data.frame(mean_b/mean_norm)
  colnames(ratio_b) <- c("blue")
  ratio_y <- as.data.frame(mean_y/mean_norm)
  colnames(ratio_y) <- c("yellow")
  ratio_r <- as.data.frame(mean_r/mean_norm)
  colnames(ratio_r) <- c("red")
  ratio_gr <- as.data.frame(mean_gr/mean_norm)
  colnames(ratio_gr) <- c("grey")
  ratio_g <- as.data.frame(mean_g/mean_norm)
  colnames(ratio_g) <- c("green")
  ratio_t <- as.data.frame(mean_t/mean_norm)
  colnames(ratio_t) <- c("teal")
  ratio_P4 <- as.data.frame(mean_P4/mean_norm)
  colnames(ratio_P4) <- c("P4")
  ratio_P5 <- as.data.frame(mean_P5/mean_norm)
  colnames(ratio_P5) <- c("P5")
  ratio_P6 <- as.data.frame(mean_P6/mean_norm)
  colnames(ratio_P6) <- c("P6")
  ratio_P7 <- as.data.frame(mean_P7/mean_norm)
  colnames(ratio_P7) <- c("P7")
  ratio_P8 <- as.data.frame(mean_P8/mean_norm)
  colnames(ratio_P8) <- c("P8")
  df_[[i]] <- cbind(ratio_b,ratio_t,ratio_g,ratio_r,ratio_y,ratio_gr,ratio_P4,ratio_P5,ratio_P6,ratio_P7,ratio_P8)
  rownames(df_[[i]])<-paste(i)
}

data_tot <-  do.call(rbind, df_)

# create the normalized depth values file
write.table(data_tot, file = "Normalized_depth_values.txt", quote=F,sep="\t",col.names = NA)

#assign the correspondent number of amplicon for the standardized depth value
data_tot <- data_tot %>% 
  mutate(blue_int = case_when(blue < 0.125 ~ 0
                              ,blue < 0.375 & blue >= 0.125 ~ 1
                              ,blue < 0.625 & blue >= 0.375 ~ 2
                              ,blue < 0.875 & blue >= 0.625 ~ 3
                              ,blue < 1.125 & blue >= 0.875 ~ 4
                              ,blue < 1.375 & blue >= 1.125 ~ 5
                              ,blue < 1.625 & blue >= 1.375 ~ 6
                              ,blue < 1.875 & blue >= 1.625 ~ 7
                              ,blue < 2.125 & blue >= 1.875 ~ 8
                              ,blue < 2.375 & blue >= 2.125 ~ 9
                              ,blue < 2.625 & blue >= 2.375 ~ 10
                              ,blue < 2.875 & blue >= 2.625 ~ 11
                              ,blue < 3.125 & blue >= 2.875 ~ 12
                              ,blue < 3.375 & blue >= 3.125 ~ 13
                              ,blue < 3.625 & blue >= 3.375 ~ 14
                              ,blue < 3.875 & blue >= 3.625 ~ 15
                              ,blue < 4.125 & blue >= 3.875 ~ 16
                              ,blue < 4.375 & blue >= 4.125 ~ 17
                              ,blue < 4.625 & blue >= 4.375 ~ 18
                              ,blue < 4.875 & blue >= 4.625 ~ 19
                              ,blue < 5.125 & blue >= 4.875 ~ 20), 
         teal_int = case_when(teal < 0.25 ~ 0
                              ,teal >= 0.25 & teal < 0.75 ~ 1
                              ,teal >= 0.75 & teal < 1.25 ~ 2
                              ,teal >= 1.25 & teal < 1.75 ~ 3
                              ,teal >= 1.75 & teal < 2.25 ~ 4
                              ,teal >= 2.25 & teal < 2.75 ~ 5
                              ,teal >= 2.75 & teal < 3.25 ~ 6
                              ,teal >= 3.25 & teal < 3.75 ~ 7
                              ,teal >= 3.75 & teal < 4.25 ~ 8
                              ,teal >= 4.25 & teal < 4.75 ~ 9
                              ,teal >= 4.75 & teal < 5.25 ~ 10
                              ,teal >= 5.25 & teal < 5.75 ~ 11
                              ,teal >= 5.75 & teal < 6.25 ~ 12
                              ,teal >= 6.25 & teal < 6.75 ~ 13
                              ,teal >= 6.75 & teal < 7.25 ~ 14
                              ,teal >= 7.25 & teal < 7.75 ~ 15
                              ,teal >= 7.75 & teal < 8.25 ~ 16
                              ,teal >= 8.25 & teal < 8.75 ~ 17
                              ,teal >= 8.75 & teal < 9.25 ~ 18
                              ,teal >= 9.25 & teal < 9.75 ~ 19
                              ,teal >= 9.75 & teal < 10.25 ~ 20),
         green_int = case_when(green < 0.167 ~ 0
                               ,green >= 0.167 & green < 0.5 ~ 1
                               ,green >= 0.5 & green < 0.833 ~ 2
                               ,green >= 0.833 & green < 1.167 ~ 3
                               ,green >= 1.167 & green < 1.5 ~ 4
                               ,green >= 1.5 & green < 1.833 ~ 5
                               ,green >= 1.833 & green < 2.167 ~ 6
                               ,green >= 2.167 & green < 2.5 ~ 7
                               ,green >= 2.5 & green < 2.833 ~ 8
                               ,green >= 2.833 & green < 3.167 ~ 9
                               ,green >= 3.167 & green < 3.5 ~ 10
                               ,green >= 3.5 & green < 3.833 ~ 11
                               ,green >= 3.833 & green < 4.167 ~ 12
                               ,green >= 4.167 & green < 4.5 ~ 13
                               ,green >= 4.5 & green < 4.833 ~ 14
                               ,green >= 4.833 & green < 5.167 ~ 15
                               ,green >= 5.167 & green < 5.5 ~ 16
                               ,green >= 5.5 & green < 5.833 ~ 17
                               ,green >= 5.833 & green < 6.167 ~ 18
                               ,green >= 6.167 & green < 6.5 ~ 19
                               ,green >= 6.5 & green < 6.833 ~ 20),
         red_int = case_when(red < 0.125 ~ 0
                             ,red < 0.375 & red >= 0.125 ~ 1
                             ,red < 0.625 & red >= 0.375 ~ 2
                             ,red < 0.875 & red >= 0.625 ~ 3
                             ,red < 1.125 & red >= 0.875 ~ 4
                             ,red < 1.375 & red >= 1.125 ~ 5
                             ,red < 1.625 & red >= 1.375 ~ 6
                             ,red < 1.875 & red >= 1.625 ~ 7
                             ,red < 2.125 & red >= 1.875 ~ 8
                             ,red < 2.375 & red >= 2.125 ~ 9
                             ,red < 2.625 & red >= 2.375 ~ 10
                             ,red < 2.875 & red >= 2.625 ~ 11
                             ,red < 3.125 & red >= 2.875 ~ 12
                             ,red < 3.375 & red >= 3.125 ~ 13
                             ,red < 3.625 & red >= 3.375 ~ 14
                             ,red < 3.875 & red >= 3.625 ~ 15
                             ,red < 4.125 & red >= 3.875 ~ 16
                             ,red < 4.375 & red >= 4.125 ~ 17
                             ,red < 4.625 & red >= 4.375 ~ 18
                             ,red < 4.875 & red >= 4.625 ~ 19
                             ,red < 5.125 & red >= 4.875 ~ 20),
         yellow_int = case_when(yellow < 0.25 ~ 0
                                ,yellow >= 0.25 & yellow < 0.75 ~ 1
                                ,yellow >= 0.75 & yellow < 1.25 ~ 2
                                ,yellow >= 1.25 & yellow < 1.75 ~ 3
                                ,yellow >= 1.75 & yellow < 2.25 ~ 4
                                ,yellow >= 2.25 & yellow < 2.75 ~ 5
                                ,yellow >= 2.75 & yellow < 3.25 ~ 6
                                ,yellow >= 3.25 & yellow < 3.75 ~ 7
                                ,yellow >= 3.75 & yellow < 4.25 ~ 8
                                ,yellow >= 4.25 & yellow < 4.75 ~ 9
                                ,yellow >= 4.75 & yellow < 5.25 ~ 10
                                ,yellow >= 5.25 & yellow < 5.75 ~ 11
                                ,yellow >= 5.75 & yellow < 6.25 ~ 12
                                ,yellow >= 6.25 & yellow < 6.75 ~ 13
                                ,yellow >= 6.75 & yellow < 7.25 ~ 14
                                ,yellow >= 7.25 & yellow < 7.75 ~ 15
                                ,yellow >= 7.75 & yellow < 8.25 ~ 16
                                ,yellow >= 8.25 & yellow < 8.75 ~ 17
                                ,yellow >= 8.75 & yellow < 9.25 ~ 18
                                ,yellow >= 9.25 & yellow < 9.75 ~ 19
                                ,yellow >= 9.75 & yellow < 10.25 ~ 20),
         grey_int = case_when(grey < 0.25 ~ 0
                              ,grey >= 0.25 & grey < 0.75 ~ 1
                              ,grey >= 0.75 & grey < 1.25 ~ 2
                              ,grey >= 1.25 & grey < 1.75 ~ 3
                              ,grey >= 1.75 & grey < 2.25 ~ 4
                              ,grey >= 2.25 & grey < 2.75 ~ 5
                              ,grey >= 2.75 & grey < 3.25 ~ 6
                              ,grey >= 3.25 & grey < 3.75 ~ 7
                              ,grey >= 3.75 & grey < 4.25 ~ 8
                              ,grey >= 4.25 & grey < 4.75 ~ 9
                              ,grey >= 4.75 & grey < 5.25 ~ 10
                              ,grey >= 5.25 & grey < 5.75 ~ 11
                              ,grey >= 5.75 & grey < 6.25 ~ 12
                              ,grey >= 6.25 & grey < 6.75 ~ 13
                              ,grey >= 6.75 & grey < 7.25 ~ 14
                              ,grey >= 7.25 & grey < 7.75 ~ 15
                              ,grey >= 7.75 & grey < 8.25 ~ 16
                              ,grey >= 8.25 & grey < 8.75 ~ 17
                              ,grey >= 8.75 & grey < 9.25 ~ 18
                              ,grey >= 9.25 & grey < 9.75 ~ 19
                              ,grey >= 9.75 & grey < 10.25 ~ 20),
         P4_int = case_when(P4 < 0.25 ~ 0
                            ,P4 >= 0.25 & P4 < 0.75 ~ 1
                            ,P4 >= 0.75 & P4 < 1.25 ~ 2
                            ,P4 >= 1.25 & P4 < 1.75 ~ 3
                            ,P4 >= 1.75 & P4 < 2.25 ~ 4
                            ,P4 >= 2.25 & P4 < 2.75 ~ 5
                            ,P4 >= 2.75 & P4 < 3.25 ~ 6
                            ,P4 >= 3.25 & P4 < 3.75 ~ 7
                            ,P4 >= 3.75 & P4 < 4.25 ~ 8
                            ,P4 >= 4.25 & P4 < 4.75 ~ 9
                            ,P4 >= 4.75 & P4 < 5.25 ~ 10
                            ,P4 >= 5.25 & P4 < 5.75 ~ 11
                            ,P4 >= 5.75 & P4 < 6.25 ~ 12
                            ,P4 >= 6.25 & P4 < 6.75 ~ 13
                            ,P4 >= 6.75 & P4 < 7.25 ~ 14
                            ,P4 >= 7.25 & P4 < 7.75 ~ 15
                            ,P4 >= 7.75 & P4 < 8.25 ~ 16
                            ,P4 >= 8.25 & P4 < 8.75 ~ 17
                            ,P4 >= 8.75 & P4 < 9.25 ~ 18
                            ,P4 >= 9.25 & P4 < 9.75 ~ 19
                            ,P4 >= 9.75 & P4 < 10.25 ~ 20),
         P5_int = case_when(P5 < 0.25 ~ 0
                            ,P5 >= 0.25 & P5 < 0.75 ~ 1
                            ,P5 >= 0.75 & P5 < 1.25 ~ 2
                            ,P5 >= 1.25 & P5 < 1.75 ~ 3
                            ,P5 >= 1.75 & P5 < 2.25 ~ 4
                            ,P5 >= 2.25 & P5 < 2.75 ~ 5
                            ,P5 >= 2.75 & P5 < 3.25 ~ 6
                            ,P5 >= 3.25 & P5 < 3.75 ~ 7
                            ,P5 >= 3.75 & P5 < 4.25 ~ 8
                            ,P5 >= 4.25 & P5 < 4.75 ~ 9
                            ,P5 >= 4.75 & P5 < 5.25 ~ 10
                            ,P5 >= 5.25 & P5 < 5.75 ~ 11
                            ,P5 >= 5.75 & P5 < 6.25 ~ 12
                            ,P5 >= 6.25 & P5 < 6.75 ~ 13
                            ,P5 >= 6.75 & P5 < 7.25 ~ 14
                            ,P5 >= 7.25 & P5 < 7.75 ~ 15
                            ,P5 >= 7.75 & P5 < 8.25 ~ 16
                            ,P5 >= 8.25 & P5 < 8.75 ~ 17
                            ,P5 >= 8.75 & P5 < 9.25 ~ 18
                            ,P5 >= 9.25 & P5 < 9.75 ~ 19
                            ,P5 >= 9.75 & P5 < 10.25 ~ 20),
         P6_int = case_when(P6 < 0.25 ~ 0
                            ,P6 >= 0.25 & P6 < 0.75 ~ 1
                            ,P6 >= 0.75 & P6 < 1.25 ~ 2
                            ,P6 >= 1.25 & P6 < 1.75 ~ 3
                            ,P6 >= 1.75 & P6 < 2.25 ~ 4
                            ,P6 >= 2.25 & P6 < 2.75 ~ 5
                            ,P6 >= 2.75 & P6 < 3.25 ~ 6
                            ,P6 >= 3.25 & P6 < 3.75 ~ 7
                            ,P6 >= 3.75 & P6 < 4.25 ~ 8
                            ,P6 >= 4.25 & P6 < 4.75 ~ 9
                            ,P6 >= 4.75 & P6 < 5.25 ~ 10
                            ,P6 >= 5.25 & P6 < 5.75 ~ 11
                            ,P6 >= 5.75 & P6 < 6.25 ~ 12
                            ,P6 >= 6.25 & P6 < 6.75 ~ 13
                            ,P6 >= 6.75 & P6 < 7.25 ~ 14
                            ,P6 >= 7.25 & P6 < 7.75 ~ 15
                            ,P6 >= 7.75 & P6 < 8.25 ~ 16
                            ,P6 >= 8.25 & P6 < 8.75 ~ 17
                            ,P6 >= 8.75 & P6 < 9.25 ~ 18
                            ,P6 >= 9.25 & P6 < 9.75 ~ 19
                            ,P6 >= 9.75 & P6 < 10.25 ~ 20),
         P7_int = case_when(P7 < 0.25 ~ 0
                            ,P7 >= 0.25 & P7 < 0.75 ~ 1
                            ,P7 >= 0.75 & P7 < 1.25 ~ 2
                            ,P7 >= 1.25 & P7 < 1.75 ~ 3
                            ,P7 >= 1.75 & P7 < 2.25 ~ 4
                            ,P7 >= 2.25 & P7 < 2.75 ~ 5
                            ,P7 >= 2.75 & P7 < 3.25 ~ 6
                            ,P7 >= 3.25 & P7 < 3.75 ~ 7
                            ,P7 >= 3.75 & P7 < 4.25 ~ 8
                            ,P7 >= 4.25 & P7 < 4.75 ~ 9
                            ,P7 >= 4.75 & P7 < 5.25 ~ 10
                            ,P7 >= 5.25 & P7 < 5.75 ~ 11
                            ,P7 >= 5.75 & P7 < 6.25 ~ 12
                            ,P7 >= 6.25 & P7 < 6.75 ~ 13
                            ,P7 >= 6.75 & P7 < 7.25 ~ 14
                            ,P7 >= 7.25 & P7 < 7.75 ~ 15
                            ,P7 >= 7.75 & P7 < 8.25 ~ 16
                            ,P7 >= 8.25 & P7 < 8.75 ~ 17
                            ,P7 >= 8.75 & P7 < 9.25 ~ 18
                            ,P7 >= 9.25 & P7 < 9.75 ~ 19
                            ,P7 >= 9.75 & P7 < 10.25 ~ 20),
         P8_int = case_when(P8 < 0.25 ~ 0
                            ,P8 >= 0.25 & P8 < 0.75 ~ 1
                            ,P8 >= 0.75 & P8 < 1.25 ~ 2
                            ,P8 >= 1.25 & P8 < 1.75 ~ 3
                            ,P8 >= 1.75 & P8 < 2.25 ~ 4
                            ,P8 >= 2.25 & P8 < 2.75 ~ 5
                            ,P8 >= 2.75 & P8 < 3.25 ~ 6
                            ,P8 >= 3.25 & P8 < 3.75 ~ 7
                            ,P8 >= 3.75 & P8 < 4.25 ~ 8
                            ,P8 >= 4.25 & P8 < 4.75 ~ 9
                            ,P8 >= 4.75 & P8 < 5.25 ~ 10
                            ,P8 >= 5.25 & P8 < 5.75 ~ 11
                            ,P8 >= 5.75 & P8 < 6.25 ~ 12
                            ,P8 >= 6.25 & P8 < 6.75 ~ 13
                            ,P8 >= 6.75 & P8 < 7.25 ~ 14
                            ,P8 >= 7.25 & P8 < 7.75 ~ 15
                            ,P8 >= 7.75 & P8 < 8.25 ~ 16
                            ,P8 >= 8.25 & P8 < 8.75 ~ 17
                            ,P8 >= 8.75 & P8 < 9.25 ~ 18
                            ,P8 >= 9.25 & P8 < 9.75 ~ 19
                            ,P8 >= 9.75 & P8 < 10.25 ~ 20))

data_tot <- data_tot%>%select(-blue,-yellow,-red,-green,-grey,-teal,-P4,-P5,-P6,-P7,-P8)

colnames(data_tot) <- c("blue","teal","green","red","yellow","grey","P4","P5","P6","P7","P8")

#create the copy number calls file
write.table(data_tot, file = "Copy_number_calls.txt", quote=F,sep="\t",col.names = NA)