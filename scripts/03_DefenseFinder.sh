#!/bin/bash

#SBATCH --account p31752
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=20:00:00
#SBATCH --mem=0gb
#SBATCH --job-name="Phage Defense System Finder - Pseudomonas"
#SBATCH --mail-type=all
#SBATCH --mail-user=andrewwatson2025@u.northwestern.edu
source config.sh

module purge all
module load mamba 
source activate defensefinder
module load hmmer
defense-finder update

if [ ! -d "${defFindDir}" ]
then
	mkdir ${defFindDir}
fi


#for directory in ${assembledDir}/*/
#do
#    d_sub=$(basename $directory) # Save Basename
#    mkdir ${defFindDir}/${d_sub} # Make new directory 
#    defense-finder run ${directory}/${d_sub}.faa -o ${defFindDir}/${d_sub} # Run Defense Finder
#
#done


defense-finder run ${assembledDir}/1020-IPA-00/1020-IPA-00.fna -o ${defFindDir}

conda deactivate
module purge all




