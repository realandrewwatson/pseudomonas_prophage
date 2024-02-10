#!/bin/bash

#SBATCH --account p31752
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=04:00:00
#SBATCH --mem=100gb
#SBATCH --job-name="quast_quality_control"
#SBATCH --mail-type=all
#SBATCH --mail-user=andrewwatson2025@u.northwestern.edu

# Setup
source config.sh
module purge all
module load quast

# Make a new quast directory
if [-d "${quastDir}" ]
then
    rm -r "${quastDir}"
fi
mkdir ${quastDir}

## Run Quast
#Run through each assembly folder and find the assembled genome file
for directory in ${assembledDir}/*/
do
    d_sub=$(basename $directory) # Save Basename
    mkdir ${quastDir}/${d_sub} # Make new directory 
    quast.py --threads 20 ${directory}/${d_sub}.fna -o ${quastDir}/${d_sub} # Run quast
done


# Deactivate conda and purge active modules
module purge all

# Run multiQC in the new quast directory
module load multiqc
cd ${quastDir}
multiqc . 

module purge all
mv slurm* logs