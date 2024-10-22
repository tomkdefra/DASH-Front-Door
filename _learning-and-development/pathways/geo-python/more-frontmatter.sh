#!/bin/bash

# Find all .md files recursively starting from the current directory
find . -type f -name '*.md' | while read -r file; do
    # Use awk to modify the file in place
    awk '
    BEGIN { 
        FS=OFS="" 
    }
    /permalink:.*\/lessons\/[Ll]/ { 
        gsub(/\/lessons\/[Ll]/, "/lessons/lesson-") 
    }
    { print }' "$file" > temp && mv temp "$file"
done
