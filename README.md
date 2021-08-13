# Meta-analytic findings of the self-controlled motor learning literature: Underpowered, biased, and lacking evidential value

This repository contains the necessary files and code to reproduce the analyses, figures, and the manuscript. The current version of the manuscript can be read by opening the *self-controlled-motor-learning-meta-analysis-manuscript.pdf* file.

## Usage

To reproduce the analyses, we strongly encourage opening the .Rproj file using RStudio. This will ensure all directory paths work on your system. All analyses and figures can be reproduced by running the *analysis.R*. This will source the other R scripts as necessary. When you run *analysis.R* it will check whether the necessary R packages are installed on your system and will load them. Any missing packages will be installed and then loaded into your R session.

## Repository tree
```bash
├── data
│   ├── data.csv
│   ├── dataret.txt
│   ├── fig1_count-data.csv
│   └── preregrma.csv
├── docs
│   ├── refs.bib
│   ├── revision
│   │   ├── appendix_a.Rmd
│   │   ├── appendix_a.tex
│   │   ├── appendix_b.Rmd
│   │   ├── appendix_b.tex
│   │   ├── manuscript-revised.pdf
│   │   ├── manuscript-revised.Rmd
│   │   ├── manuscript-revised.tex
│   │   ├── table-1.csv
│   │   └── table-a1.csv
│   └── submission
│       ├── latexmkrc
│       ├── manuscript.pdf
│       └── manuscript.tex
├── figs
│   ├── fig1.pdf
│   ├── fig2.pdf
│   ├── fig3.pdf
│   └── fig4.pdf
├── meta-analysis-self-controlled-motor-learning.Rproj
├── README.md
└── scripts
    ├── analysis.R
    ├── fig1.R
    └── pcurve_app4.06.R  
```
