#!/bin/bash

# Define the directory containing your Markdown files
DIRECTORY="./"

# Loop through all Markdown files in the specified directory
for file in "$DIRECTORY"/*.md; do
    echo "Processing $file..."

    # Correct the headings: convert to lowercase, replace spaces with dashes, remove punctuation
    sed -i '' -e 's/^# \(.*\)$/# \L\1/' \
              -e 's/ /-/g' \
              -e 's/[[:punct:]]//g' "$file"
done

echo "All files processed."