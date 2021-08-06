#Alison Cameron

library(ggplot2)
library(readr)
library(dplyr)
library(stringr)
library(Hmisc)
library(tidyr)
library(forcats)

#------------FUNCTIONS-----------
get_treatment_val <- function(filename, treatment_name){
  number_pattern <- "[\\d][._][\\d]*"
  treatment_pattern <- str_c(c(treatment_name, number_pattern), sep="", collapse="")
  treatment <- str_extract(filename, treatment_pattern)
  treatment_val <- NA
  
  decimal_pattern <- "[\\d].[\\d]+"
  integer_pattern <- "[\\d]+"
  if(str_detect(treatment, "\\.")){
    treatment_val <- str_extract(treatment, decimal_pattern)
  } else {
    treatment_val <- str_extract(treatment, integer_pattern)
  }
  treatment_val
}

get_data <- function(filename, folder, treatments){
  seed <- str_extract(filename, "SEED[\\d]+.")
  seed_val <- str_extract(seed, "[\\d]+")
  
  full_filename <- str_c(c(folder, filename), sep="", collapse="")
  data <- read_csv(full_filename) %>% mutate(SEED = seed_val)
  
  for (i in c(1:length(treatments))){
    data <- data %>% mutate(!!treatments[i] := as.factor(get_treatment_val(filename, treatments[i])))
  }
  data
}

combine_time_data <- function(filenames, folder, treatments){
  all_data <- get_data(filenames[1], folder, treatments)
  
  if(length(filenames) > 1){
    for (i in c(2:length(filenames))){
      add_data <- get_data(filenames[i], folder, treatments)
      all_data <- full_join(all_data, add_data)
    }
  }
  all_data %>% mutate(SEED = as.factor(SEED))
}

#------------SETTINGS------------
folder <- "Data/"
all_filenames <- list.files(folder)

hostval_filenames <- str_subset(all_filenames, "HostVals")
lysischance_filenames <- str_subset(all_filenames, "LysisChance")
phagevals_filenames <- str_subset(all_filenames, "SymVals")
freeliving_filenames <- str_subset(all_filenames, "FreeLivingSyms")
induction_filenames <- str_subset(all_filenames, "InductionChance")

treatments <- c("PLR", "COI")

#-----------MUNGE DATA------------
hostvals <- combine_time_data(hostval_filenames, folder, treatments)
lysischances <- combine_time_data(lysischance_filenames, folder, treatments)
phagevals <- combine_time_data(phagevals_filenames, folder, treatments)
freeliving <- combine_time_data(freeliving_filenames, folder, treatments)
inductionchances <- combine_time_data(induction_filenames, folder, treatments)

#----------CREATE GRAPHS-----------
colors <- c("#B50142", "#CD0778", "#D506AD", "#E401E7", "#AB08FF","#7B1DFF", 
            "#5731FD", "#4755FF", "#5E8EFF", "#6FC4FE", "#86E9FE", "#96FFF7", 
            "#B2FCE3", "#BBFFDB", "#D4FFDD", "#EFFDF0")

tenhelix <- c("#891901", "#B50142", "#D506AD", "#AB08FF", "#5731FD", "#4755FF", 
              "#86E9FE", "#B2FCE3", "#D4FFDD", "#EFFDF0")
##----------Hosts--------------
#host count
hostcount_plot <- ggplot(data=hostvals,
                         aes(x=update, y=count, 
                             group=PLR, colour=PLR)) + 
  ylab("Host Count") + xlab("Updates") + 
  stat_summary(aes(color=PLR, fill=PLR),
               fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + 
  theme(panel.background = element_rect(fill='white', colour='black')) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  guides(fill=FALSE) + scale_colour_manual(values=colors) + 
  scale_fill_manual(values=colors)

hostcount_plot + facet_wrap(~COI)

#host cfu count
hostcount_cfu_plot <- ggplot(data=hostvals, aes(x=update, y=cfu_count, 
                                                group=PLR, colour=PLR)) + 
  ylab("Host CFU Count") + xlab("Updates") + 
  stat_summary(aes(color=PLR, fill=PLR),
               fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + 
  theme(panel.background = element_rect(fill='white', colour='black')) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  guides(fill=FALSE) + scale_colour_manual(values=colors) + 
  scale_fill_manual(values=colors)

hostcount_cfu_plot + facet_wrap(~COI)

#host uninfected plot
host_uninfected_plot <- ggplot(data=hostvals, aes(x=update, y=uninfected_host_count, 
                                                  group=PLR, colour=PLR)) + 
  ylab("Uninfected Host Count") + xlab("Updates") + 
  stat_summary(aes(color=PLR, fill=PLR),
               fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + 
  theme(panel.background = element_rect(fill='white', colour='black')) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  guides(fill=FALSE) + scale_colour_manual(values=colors) + 
  scale_fill_manual(values=colors)

host_uninfected_plot + facet_wrap(~COI)

#host int val plot
hostvals_plot <- ggplot(data=hostvals, aes(x=update, y=mean_intval, 
                                           group=PLR, colour=PLR)) + 
  ylab("Mean Host Interaction Value") + xlab("Updates") + 
  stat_summary(aes(color=PLR, fill=PLR),
               fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + 
  theme(panel.background = element_rect(fill='white', colour='black')) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  guides(fill=FALSE) + scale_colour_manual(values=colors) + 
  scale_fill_manual(values=colors)

hostvals_plot + facet_wrap(~COI)

#--------Phage---------
#Phage count
phagecount_plot <- ggplot(data=lysischances,
                          aes(x=update, y=count,
                              group=PLR, color=PLR)) +
  ylab("Phage count") + xlab("Updates") + 
  stat_summary(aes(color=PLR, fill=PLR),
               fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + 
  theme(panel.background = element_rect(fill='white', colour='black')) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  guides(fill=FALSE) + scale_colour_manual(values=colors) + 
  scale_fill_manual(values=colors)

phagecount_plot + facet_wrap(~COI)

#Phage int val
phageintval_plot <- ggplot(data=phagevals, aes(x=update, y=mean_intval,
                                               group=PLR, color=PLR)) +
  ylab("Phage Interaction value") + xlab("Updates") + 
  stat_summary(aes(color=PLR, fill=PLR),
               fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + 
  theme(panel.background = element_rect(fill='white', colour='black')) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  guides(fill=FALSE) + scale_colour_manual(values=colors) + 
  scale_fill_manual(values=colors)

phageintval_plot + facet_wrap(~COI)

#Phage chance of lysis
lysischances_plot <- ggplot(data=lysischances,
                            aes(x=update, y=mean_lysischance,
                                group=PLR, color=PLR)) +
  ylab("Mean chance of lysis") + xlab("Updates") + 
  stat_summary(aes(color=PLR, fill=PLR),
               fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + 
  theme(panel.background = element_rect(fill='white', colour='black')) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  guides(fill=FALSE) + scale_colour_manual(values=colors) + 
  scale_fill_manual(values=colors)

lysischances_plot + facet_wrap(~COI)

#Phage chance of induction
inductionchances_plot <- ggplot(data=inductionchances,
                            aes(x=update, y=mean_inductionchance,
                                group=PLR, color=PLR)) +
  ylab("Mean chance of induction") + xlab("Updates") + 
  stat_summary(aes(color=PLR, fill=PLR),
               fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + 
  theme(panel.background = element_rect(fill='white', colour='black')) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  guides(fill=FALSE) + scale_colour_manual(values=colors) + 
  scale_fill_manual(values=colors)

inductionchances_plot + facet_wrap(~COI)


