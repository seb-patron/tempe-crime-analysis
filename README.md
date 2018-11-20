# Tempe Crime Analysis
-

An analysis of crime in Tempe using data from both the city of Tempe and Arizona State University's police department. Features downloading and inserting data into a PostgreSQL database, data cleanup, and visualizations with matplotlib and google maps.


**Note:** Requires Rails 5.2

###\ Getting Started

Analysis is done in Jupyter notebooks and uses anaconda to manage the environment

#### Requirements

You'll need the following installed to run the analysis successfully:

* Anaconda
* PostgreSQL

### Installation

First create the anaconda environment:

```bash
conda env create -f environment.yml -n crime-analysis
```

Activate the environment:

```bash
$ source activate crime-analysis
```

Next, run the `download_data` bash script to get the data and insert it into a PostgreSQL database

```bash
./download_data
```

Finally, start up Jupyter and visit localhost:8888 to see the analysis.

```bash
jupyter notebook
```

## Data Sources

All data was taken from opendata sources.

asu data - https://moto.data.socrata.com/dataset/Arizona-State-University-Police-Department/6fzp-yqnh

tempe - https://data-tempegov.opendata.arcgis.com/datasets/02533928ed1649d2ac773c8ebf50f37d_1?geometry=-111.959%2C33.414%2C-111.899%2C33.426


### Additional Info

To update project with new packages, add them to environment.yml, then type in

```bash
$ conda env update -f environment.yml -n crime-analysis
```