source config.sh

target="${workspaceDir}/dephtDir"
##courtesy of chuckles 
count_files_by_type() {
    # $1: Directory to search in
    # $2: File extension to look for, e.g., "txt" for text files

    if [ $# -ne 2 ]; then
        echo "Usage: count_files_by_type <directory> <file_extension>"
        return 1
    fi

    local search_dir=$1
    local file_extension=$2
    local output_file="file_counts.tsv"

    # Check if the directory exists
    if [ ! -d "$search_dir" ]; then
        echo "Directory does not exist: $search_dir"
        return 1
    fi

    # Prepare or clear the output file
    echo -e "Subdirectory\tCount" > "$output_file"

    # Iterate over subdirectories
    for subdir in "$search_dir"/*; do
        if [ -d "$subdir" ]; then
            # Count files of the specified type
            local count=$(find "$subdir" -type f -name "*.$file_extension" | wc -l)
            # Extract the basename of the subdirectory
            local basename=$(basename "$subdir")
            # Append the count to the output file
            echo -e "$basename\t$count" >> "$output_file"
        fi
    done

    echo "Output saved to $output_file"
}

count_directories_by_prefix() {
    # $1: Primary directory containing subdirectories
    # $2: Prefix string to match sub-subdirectories

    if [ $# -ne 2 ]; then
        echo "Usage: count_directories_by_prefix <primary_directory> <prefix_string>"
        return 1
    fi

    local primary_dir=$1
    local prefix_string=$2
    local output_file="counts.tsv"

    # Check if the primary directory exists
    if [ ! -d "$primary_dir" ]; then
        echo "Primary directory does not exist: $primary_dir"
        return 1
    fi

    # Prepare the output file
    echo -e "Subdirectory\tCount" > "$output_file"

    # Iterate over each subdirectory within the primary directory
    for subdir in "$primary_dir"/*/; do
        if [ -d "$subdir" ]; then
            # Count sub-subdirectories within each subdirectory that match the prefix
            local count=$(find "$subdir" -mindepth 1 -maxdepth 1 -type d -name "${prefix_string}*" | wc -l)
            # Extract the basename of the subdirectory
            local basename=$(basename "$subdir")
            # Append the count to the output file
            echo -e "$basename\t$count" >> "$output_file"
        fi
    done

    echo "Output saved to $output_file"
}

# Example usage:
# count_subsubdirectories_by_prefix /path/to/primary_directory prefix_

# Example usage:
# count_directories_by_prefix /path/to/directory prefix_
count_directories_by_prefix $target pro
ls $target