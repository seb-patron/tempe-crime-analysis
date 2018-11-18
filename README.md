psql postgres -U sebdev -f db_setup.sql

asu data - https://moto.data.socrata.com/dataset/Arizona-State-University-Police-Department/6fzp-yqnh

tempe - https://data-tempegov.opendata.arcgis.com/datasets/02533928ed1649d2ac773c8ebf50f37d_1?geometry=-111.959%2C33.414%2C-111.899%2C33.426


First, copy (don't git clone or else you need to overwrite settings later) this repository, enter terminal, and type:

$ conda env create -f environment.yml -n crime-analysis

This creates an virtual enviroment with Anaconda. To activate it, type

$ source activate crime-analysis

To update project with new packages, add them to environment.yml, then type in

$ conda env update -f environment.yml -n crime-analysis

To start up Jupyter Notebooks type

$ jupyter notebook