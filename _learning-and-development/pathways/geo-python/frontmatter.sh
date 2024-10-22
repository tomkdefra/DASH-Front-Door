#!/bin/bash

# Directory to start searching from
start_dir="."

# Find all .md files recursively
find "$start_dir" -name "*.md" | while read -r file; do
    # Check if the file has YAML frontmatter
    if grep -q "^---" "$file"; then
        # Use awk to modify the frontmatter
        awk '
        BEGIN {
            in_frontmatter = 0
            sidebar_found = 0
            frontmatter_buffer = ""
        }
        /^---/ {
            if (in_frontmatter) {
                print frontmatter_buffer
                if (!sidebar_found) {
                    print "sidebar:"
                    print "  - image: assets/images/geopython.png"
                    print "    image_alt: \"Geo-Python logo\"\n"
                    print "  - nav: \"geo-python\""
                }
                in_frontmatter = 0
                sidebar_found = 0
                print $0
            } else {
                in_frontmatter = 1
                print $0
            }
            next
        }
        in_frontmatter {
          if ($0 ~ /^sidebar:/) {
              sidebar_found = 1
              frontmatter_buffer = frontmatter_buffer "sidebar:\n"
              frontmatter_buffer = frontmatter_buffer "  - image: assets/images/geopython.png\n"
              frontmatter_buffer = frontmatter_buffer "    image_alt: \"Geo-Python logo\"\n"
              frontmatter_buffer = frontmatter_buffer "  - nav: \"geo-python\""
          } else {
              if (sidebar_found && /^  nav: "geo-python"/) {
              } else {
                  frontmatter_buffer = frontmatter_buffer $0 "\n"
              }
          }
          next
        }
        { print }
        ' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
        
        echo "Updated $file"
    else
        echo "Skipping $file (no YAML frontmatter found)"
    fi
done