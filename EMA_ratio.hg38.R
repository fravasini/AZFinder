# packages
library(tidyverse)
library(TTR)

# read dataframe
df_AZFc<- read.table("Path to amplicon depth file",header=FALSE)
df_norm_reg <- read.table("Path to normalization region depth file", header=F)

# read sample list
list<-scan("sample_list.txt",character())

# change column names
colnames(df_AZFc) <- c("chr","pos", list)
colnames(df_norm_reg) <- c("chr","pos", list)

# delete 1st column (chr)
df_AZFc <- df_AZFc%>%select(-chr)
df_norm_reg <- df_norm_reg%>%select(-chr)

# calculate EMA with sliding windows of 10000 bp  
EMA_AZFc <- data.frame(apply(df_AZFc,2,EMA,n=10000))  

# create normalized depth value plot for each sample

for(i in list) {
  mean_norm <- mean(df_norm_reg[[i]])
  ratio <- as.data.frame(EMA_AZFc[[i]]/mean_norm)
  ratio <- cbind(df_AZFc[,1],ratio)
  colnames(ratio) <- c("pos","ratio")
  df6<-ratio[c(464566:549874),]
  df7<-ratio[c(549875:636544),]
  df8<-ratio[c(636545:722982),]
  df9<-ratio[c(722983:808613),]
  df10<-ratio[c(808614:873004),]
  df11<-ratio[c(873005:898651),]
  df12<-ratio[c(898652:924493),]
  df13<-ratio[c(924494:984332),]
  df14<-ratio[c(984333:1070124),]
  df15<-ratio[c(1070125:1308712),]
  df16<-ratio[c(1308713:1371916),]
  df17<-ratio[c(1371917:1397648),]
  df18<-ratio[c(1397649:1423261),]
  df19<-ratio[c(1423262:1488290),]
  df20<-ratio[c(1488291:1727308),]
  df21<-ratio[c(1727309:1813149),]
  df22<-ratio[c(1813150:1872683),]
  p <- ggplot(df6, aes(x=pos,y=ratio))+
    geom_line(data=df6,colour="blue")+
    geom_line(data=df7,colour="aquamarine")+
    geom_line(data=df8,colour="aquamarine")+
    geom_line(data=df9,colour="blue")+
    geom_line(data=df10,colour="green")+
    geom_line(data=df11,colour="red")+
    geom_line(data=df12,colour="red")+
    geom_line(data=df13,colour="gray")+
    geom_line(data=df14,colour="blue")+
    geom_line(data=df15,colour="yellow")+
    geom_line(data=df16,colour="green")+
    geom_line(data=df17,colour="red")+
    geom_line(data=df18,colour="red")+
    geom_line(data=df19,colour="green")+
    geom_line(data=df20,colour="yellow")+
    geom_line(data=df21,colour="blue")+
    geom_line(data=df22,colour="gray")+
    scale_y_continuous(limits = c(0,2.5))+
    scale_x_continuous(labels = function(x) format(x, scientific = FALSE))+
    labs(y= "Normalized depth value", x = "Position")+
    ggtitle(paste0(i))+
    theme(axis.text=element_text(size=20),
          axis.title=element_text(size=20))
  ggsave(paste(i,".png",sep=""), width = 11, height=5)}




