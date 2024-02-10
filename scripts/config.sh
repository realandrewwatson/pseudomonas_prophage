#!/bin/bash

# This file sets up variables for the workspaces of each tool, 
# sourced by each file for the identifier 

##your netID or username here:
usr="adw7050"

#MODIFY THESE LINES
mainDir="/projects/p31752/pseudomonas_prophage" #THE ABSOLUTE PATH TO YOUR PROJECT FOLDER
assembledDir="${mainDir}/genome_data/pseudomonas" # CHANGE TO PATH OF FOLDER CONTAINING **SPADES** DATA
workspaceDir="${mainDir}/workspaces" # CHANGE TO WHERE THE OUTPUT FILES SHOULD GO


# Create the workspace directory
if [ ! -d "${workspaceDir}" ]
then
	mkdir "${workspaceDir}"
fi



# Setup variables
dephtDir="${workspaceDir}/dephtDir"
quastDir="${workspaceDir}/quast"


conda_envs="/home/${usr}/.conda/envs"

