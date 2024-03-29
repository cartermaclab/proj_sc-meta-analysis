# Meta-analytic findings of the self-controlled motor learning literature: Underpowered, biased, and lacking evidential value

This repository contains the necessary files and code to reproduce the analyses, figures, and the manuscript.

## Usage

To reproduce the analyses, we strongly encourage opening the .Rproj file using RStudio. This will ensure all directory paths work on your system. All analyses and figures can be reproduced by running the *analysis.R*. This will source the other R scripts as necessary. When you run *analysis.R* it will check whether the necessary R packages are installed on your system and will load them. Any missing packages will be installed and then loaded into your R session.

## Repository tree
```bash
├── data
│   ├── data.csv
│   ├── dataret.txt
│   ├── fig1_count-data.csv
│   ├── preregrma.csv
│   └── rob_dat.csv
├── docs
│   ├── accepted
│   │   ├── appendix_a.Rmd
│   │   ├── appendix_a.tex
│   │   ├── appendix_b.Rmd
│   │   ├── appendix_b.tex
│   │   ├── manuscript-accepted.pdf
│   │   ├── manuscript-accepted.Rmd
│   │   ├── manuscript-accepted.tex
│   │   ├── table-1.csv
│   │   └── table-a1.csv
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
│   ├── r-references.bib
│   └── submission
│       ├── latexmkrc
│       ├── manuscript.pdf
│       └── manuscript.tex
├── figs
│   ├── fig1.pdf
│   ├── fig2.pdf
│   ├── fig3_old.pdf
│   ├── fig3.pdf
│   ├── fig4_old.pdf
│   ├── fig4.pdf
│   └── fig5.pdf
├── meta-analysis-self-controlled-motor-learning.Rproj
├── README.md
└── scripts
    ├── analysis.R
    ├── fig1.R
    └── pcurve_app4.06.R
```
