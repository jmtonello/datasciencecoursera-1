## How code works

This code relies on R `dplyr` package, so please install it in order to execute R scripts without errors. Then, to get a tidy dataset from HAR dataset, simply clone this repository:

```sh
$ git clone https://github.com/sbaga90/datasciencecoursera.git
```

You don't need to download HAR dataset, the script will download it for you and will do all the operations on data to get a tidy dataset. In your R session change the current working directory into the directory in which you clone this project with `setwd()`. Simply you have to source `run_analysis.R` with:

```R
source("run_analysis.R")
```

Then the script will download the HAR dataset in a temporary dataset, it will unpack the archive file, it will read file and it will do all the necessary operations to get a `tidy_dataset` data frame and a `tidy_dataset.txt` text file. The `tidy_dataset.txt` is the same uploaded in Coursera Project.

