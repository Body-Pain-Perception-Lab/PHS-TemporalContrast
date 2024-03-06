## TSL METHODS FIGURE
library(tidyverse)  # data manipulation
library(rcompanion)
library(lme4)
library(lmerTest)
library(DHARMa)
library(gghalves)
library(ggpubr)
library(wesanderson)
library(Rmisc)

# make figure
## METHODS FIGURE
# download methods file - example participant data
mfilename <- "temp_array2.csv"
dat <- read.csv(file.path(Mpath, mfilename))
# changing tone value for easy plotting
dat$tone[dat$tone == '1'] = 32
dat$tone[dat$tone == '0'] = NA

# add phs to data-frame through some kind of indexing
phs = ex_id %>% dplyr::filter(phs == 1)
dat = left_join(dat, phs, by=c('temp'='threshold'))
# remove unnecessary columns
dat <- dat %>% 
  select(seconds,temp,baseline.x,instruction.x,tone,phs,descriptor) %>% 
  dplyr::rename(baseline = baseline.x,
                instruction = instruction.x)
dat$phs = dat$phs*dat$temp

## DETECTION
# A - starting temp: 32
detect_32 <- ggplot(data = dat %>% 
                      dplyr::filter(baseline == '32' & instruction == 'detect'),
                    mapping = aes(x = seconds, y = temp)) +
  geom_hline(yintercept = 32, linetype = 'dashed', 
             colour = 'grey50', size = .7) +
  geom_line(aes(x = seconds, y = temp), colour = color_light, size = 1.2) +
  geom_point(aes(x = seconds, y = tone), shape = 21, fill = 'white', colour = color_light, 
             size = 2.5, stroke = 1) +
  geom_point(aes(x = seconds, y = phs), shape = 21, colour = 'red', fill = 'red',
             size = 2, stroke = 1) +
  xlim(0,20) +
  ylim(25,45) +
  labs(x = '',
       y = 'Temperature (ºC)') +
  theme_classic() +
  theme(axis.text = element_text(size = axistext),
        axis.title = element_text(size = axistitle))

# B - starting temp: 38
detect_38 <- ggplot(data = dat %>% 
                      dplyr::filter(baseline == '38' & instruction == 'detect'),
                    mapping = aes(x = seconds, y = temp)) +
  geom_hline(yintercept = 38, linetype = 'dashed',  
             colour = 'grey50', size = .75) +
  geom_line(aes(x = seconds, y = temp), colour = color_light, size = 1.2) +
  geom_point(aes(x = seconds, y = tone), shape = 21, fill = 'white', colour = color_light, 
             size = 2.5, stroke = 1) +
  geom_point(aes(x = seconds, y = phs), shape = 21, colour = 'red', fill = 'red',
             size = 2, stroke = 1) +
  xlim(0,50) +
  ylim(25,45) +
  labs(x = '',
       y = '') +
  theme_classic() +
  theme(axis.text = element_text(size = axistext),
        axis.title = element_text(size = axistitle))

# C - starting temp: 44
detect_44 <- ggplot(data = dat %>% 
                      dplyr::filter(baseline == '44' & instruction == 'detect'),
                    mapping = aes(x = seconds, y = temp)) +
  geom_hline(yintercept = 44, linetype = 'dashed',  
             colour = 'grey50', size = .75) +
  geom_line(aes(x = seconds, y = temp), colour = color_light, size = 1.2) +
  geom_point(aes(x = seconds, y = tone), shape = 21, fill = 'white', colour = color_light, 
             size = 2.5, stroke = 1) +
  geom_point(aes(x = seconds, y = phs), shape = 21, colour = 'red', fill = 'red',
             size = 2, stroke = 1) +
  xlim(0,90) +
  ylim(25,45) +
  labs(x = '',
       y = '') +
  theme_classic() +
  theme(axis.text = element_text(size = axistext),
        axis.title = element_text(size = axistitle))

## PAIN
# A - starting temp: 32
pain_32 <- ggplot(data = dat %>% 
                    dplyr::filter(baseline == '32' & instruction == 'pain'),
                  mapping = aes(x = seconds, y = temp)) +
  geom_hline(yintercept = 32, linetype = 'dashed', 
             colour = 'grey50', size = .7) +
  geom_line(aes(x = seconds, y = temp), colour = color_dark, size = 1.2) +
  geom_point(aes(x = seconds, y = tone), shape = 21, fill = 'white', colour = color_dark, 
             size = 2.5, stroke = 1) +
  geom_point(aes(x = seconds, y = phs), shape = 21, colour = 'red', fill = 'red',
             size = 2, stroke = 1) +
  xlim(0,60) +
  ylim(20,45) +
  labs(x = 'Time (s)',
       y = 'Temperature (ºC)') +
  theme_classic() +
  theme(axis.text = element_text(size = axistext),
        axis.title = element_text(size = axistitle))

# B - starting temp: 38
pain_38 <- ggplot(data = dat %>% 
                    dplyr::filter(baseline == '38' & instruction == 'pain'),
                  mapping = aes(x = seconds, y = temp)) +
  geom_hline(yintercept = 38, linetype = 'dashed', 
             colour = 'grey50', size = .7) +
  geom_line(aes(x = seconds, y = temp), colour = color_dark, size = 1.2) +
  geom_point(aes(x = seconds, y = tone), shape = 21, fill = 'white', colour = color_dark, 
             size = 2.5, stroke = 1) +
  geom_point(aes(x = seconds, y = phs), shape = 21, colour = 'red', fill = 'red',
             size = 2, stroke = 1) +
  xlim(0,90) +
  ylim(20,45) +
  labs(x = 'Time (s)',
       y = '') +
  theme_classic() +
  theme(axis.text = element_text(size = axistext),
        axis.title = element_text(size = axistitle))

# B - starting temp: 44
pain_44 <- ggplot(data = dat %>% 
                    dplyr::filter(baseline == '44' & instruction == 'pain'),
                  mapping = aes(x = seconds, y = temp)) +
  geom_hline(yintercept = 44, linetype = 'dashed', 
             colour = 'grey50', size = .7) +
  geom_line(aes(x = seconds, y = temp), colour = color_dark, size = 1.2) +
  geom_point(aes(x = seconds, y = tone), shape = 21, fill = 'white', colour = color_dark, 
             size = 2.5, stroke = 1) +
  geom_point(aes(x = seconds, y = phs), shape = 21, colour = 'red', fill = 'red',
             size = 2, stroke = 1) +
  xlim(0,90) +
  ylim(20,45) +
  labs(x = 'Time (s)',
       y = '') +
  theme_classic() +
  theme(axis.text = element_text(size = axistext),
        axis.title = element_text(size = axistitle))

# compile figures with header
p32 <- ggarrange(detect_32, pain_32,
                 ncol = 1, nrow = 2)
p32 <- annotate_figure(p32, top = text_grob("Starting temperature: 32ºC", 
                                            face = "bold", size = 12))
p38 <- ggarrange(detect_38, pain_38,
                 ncol = 1, nrow = 2)
p38 <- annotate_figure(p38, top = text_grob("Starting temperature: 38ºC", 
                                            face = "bold", size = 12))
p44 <- ggarrange(detect_44, pain_44,
                 ncol = 1, nrow = 2)
p44 <- annotate_figure(p44, top = text_grob("Starting temperature: 44ºC", 
                                            face = "bold", size = 12))

# arrange all plots and save
p1 <- ggarrange(p32, p38, p44,
                ncol = 3, nrow = 1)
p1

ggsave('methods-fig.png', p1, device = NULL, path = Mpath, 
       width = 10, height = 5, dpi = 1000)

