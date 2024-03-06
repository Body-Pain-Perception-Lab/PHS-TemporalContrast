# Thermal Contrast Enhancement Predicts Paradoxical Heat Sensation
Public repository containing the data, source code, and visualizations used in this study.

## Table of Contents
1. [Abstract](#abstract)
2. [Introduction](#introduction)
3. [Directory Structure](#directory-structure)
4. [Access](#access)
5. [Reproducibility](#reproducibility)
6. [Usage](#usage)

## Abstract
Paradoxical Heat Sensation (PHS) is the remarkable feeling of warmth or heat pain while the skin is cooling. Despite its initial documentation over 100 years ago, a unified explanation for this perplexing experience remains elusive. Here we apply contrast enhancement principles, known for their instrumental role in understanding visual illusions, to the domain of thermosensation. Contrast enhancement describes the amplification of two contrasting visual features, such as the enhanced perception of an edge between a light and dark bar. In thermosensation, this encompasses an enhancement of the difference between sequential warming and cooling of the skin, and is defined as the normalised difference between successive temporal warm and cold temperatures. Remarkably, thermal contrast predicts the occurrence of PHS. Our findings reveal compelling evidence supporting the role of thermal contrast in the generation of PHS, shedding light on its underlying mechanism and offering a framework for broader encoding principles in thermosensation and pain. 

## Introduction
This repository contains all the scripts necessary to execute and generate the results, analyses, and the manuscript for the research paper titled "Thermal Contrast Enhancement Predicts Paradoxical Heat Sensation" To ensure complete reproducibility, the project is integrated with the Open Science Framework [OSF](https://osf.io/tp2q7/) to facilitate either the rerunning of analyses or the retrieval of results. This setup guarantees that other researchers can accurately reproduce and build upon the work presented in this study.


## Directory Structure

The repository is structured in the following way:

```         
PHS-manuscript/
  ├── README.md             # Overview of the project.
  │
  ├── data/                 # Data files used in analysis. The raw data file with fully anonymised data is anonymised_tsl2_208.csv
  │   └── ... 
  ├── figures/              # Figures generated from code to the from the final manuscript.
  │   └── ...
  ├── helpers/              # Helper files mostly used for generating Figure 1
  │   └── ...
  ├── results/              # Results of models presented in the manuscript, as well as simulation used to create confidence intervals of Models 3A - 3D
  │   └── ... 
  │
  ├── figure1_v1.m          # MATLAB script to generate Figure 1
  ├── figure2_v1.Rmd        # Markdown script to generate Figure 2
  ├── figure3_v2.Rmd        # Markdown script to generate Figure 3
  ├── supplementary_figures.Rmd        # Markdown script to reproduce supplementary figures
  │
  ├── tsl_phs_q1.Rmd        # Markdown script to reproduce results of first analysis (McNemar's and Model 1A)
  ├── tsl_phs_q2.Rmd        # Markdown script to reproduce results of second analysis (Models 2A and 2B)
  ├── tsl_phs_q3.Rmd        # Markdown script to reproduce results of third analysis (Models 3A-3D)
  │
  ├── tsl_phs_checks.Rmd    # Markdown script to check missing trial data
  └── qst_analysis.Rmd      # Markdown script to reproduce qst analysis reported in the results section and presented in supplementary materials


```

## Access

To get access to the data for running the analysis a OSF-token is needed, as the data is stored in the following [OSF-project](https://osf.io/pw956/). It is recommended to make an osf folder that contains an osf.txt file which on the first line contains the OSF-token, however make sure that this token is not shared or pushed to github. In the current gitignore an osf folder will be ignored.
To get access to the repository users are recommended to clone the respository with the following command in the terminal

```bash
git clone  https://github.com/Body-Pain-Perception-Lab/PHS-TemporalContrast.git
```

