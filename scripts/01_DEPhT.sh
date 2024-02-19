#!/bin/bash

#SBATCH --account p31752
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=48:00:00
#SBATCH --mem=0gb
#SBATCH --job-name="DEPht Prophage Search - Pseudomonas"
#SBATCH --mail-type=all
#SBATCH --mail-user=andrewwatson2025@u.northwestern.edu

#source directory variables
source config.sh
module load anaconda3

##Run this to create the conda environment unless envs/depht.yml works #WORKS AS OF 2/9/2024
##USE THIS TO UPDATE DEPENDANCIES IF ANYTHING BREAKS. THE ORDER OF INSTALLATION IS IMPORTANT

#if [ ! -d "${conda_envs}/depht" ]
#then
#	conda create -n depht -c bioconda -c conda-forge -y
#	source activate depht
#	conda install MMseqs2 -c bioconda -c conda-forge -y
#	conda install bioconda::aragorn -y
#	conda install bioconda::ClustalO -y
#	conda install -c conda-forge -c bioconda hhsuite -y
#	pip install depht
#	conda env export -f ../envs/depht.yml
#	source deactivate 
#fi

##load envs/depht.yml into a conda environment
if [ ! -d "${conda_envs}/depht" ]
then
	module load anaconda3
    conda env create -f "${mainDir}"/envs/depht.yml
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

##Run DEPHT – These options are not yet optimized

#With input directory
#depht ${assembledDir}/*/*.fna ${dephtDir} -c 20 -m sensitive -t ${dephtDir}

for directory in ${assembledDir}/*/
do
	d_sub=$(basename $directory) # Save Basename
	if [ ! -d "${dephtDir}/${d_sub}" ]
	then
	mkdir ${dephtDir}/${d_sub}
	depht ${assembledDir}/${d_sub}/*.fna ${dephtDir} -c 20 -m sensitive -t ${dephtDir}/${d_sub}
	fi
	
done



#With one input genome 
#depht ${assembledDir}/1020-IPA-00/1020-IPA-00.fna ${dephtDir} -c 20 -m sensitive -t ${dephtDir}


##Shut down conda and cleaer path
source deactivate
module purge all
mv slurm* logs
