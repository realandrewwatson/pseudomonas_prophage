#!/bin/bash

#SBATCH --account p31752
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=24:00:00
#SBATCH --mem=0gb
#SBATCH --job-name="DEPht Prophage Search - Pseudomonas"
#SBATCH --mail-type=all
#SBATCH --mail-user=andrewwatson2025@u.northwestern.edu

#source directory variables
source config.sh
module load anaconda3

##Run this to create the conda environment unless already created and installed #WORKS AS OF 2/9/2024
if [ ! -d "${conda_envs}/depht" ]
then
	conda create -n depht -c bioconda -c conda-forge -y
	source activate depht
	conda install MMseqs2 -c bioconda -c conda-forge -y
	conda install bioconda::aragorn -y
	conda install bioconda::ClustalO -y
	conda install -c conda-forge -c bioconda hhsuite -y
	pip install depht
	source deactivate 
fi

#activate remaining dependancies and conda environment
source activate depht 
module load blast
module load prodigal

#load model - DEFAULT PSEUDOMONAS MODEL FOR NOW! - will be changed if neccesary
#https://pypi.org/project/depht/#training-new-models

#Create workspace directory
if [ ! -d "${dephtDir}" ]
then
	mkdir ${dephtDir}
fi

##########################################
##************** Run DEPHT *************##
##########################################

#With input directory
depht ${assembledDir}/*/*.fna ${dephtDir} -c 20 -m sensitive -t ${dephtDir}

#With one input genome 
#depht ${assembledDir}/1020-IPA-00/1020-IPA-00.fna ${dephtDir} -c 20 -m sensitive -t ${dephtDir}

#With just one genome



##clear everything up
source deactivate
module purge all

