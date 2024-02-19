module load anaconda3
conda create --name vContact2 -y
source activate vContact2
conda install -y -c bioconda vcontact2
conda install -y -c bioconda mcl blast diamond


#conda create -n defensefinder
#source activate defensefinder
#pip install -U mdmparis-defense-finder