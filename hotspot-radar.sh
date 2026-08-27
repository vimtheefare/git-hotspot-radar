#!/bin/bash

# git-hotspot-radar
# A Shell utility to analyze git commit history and rank files by change frequency to locate architectural hotspots.

# Existing functionality...

# New feature: Adding option to specify a date range for analysis

usage() {
    echo "Usage: $0 [options]"
    echo "Options:" 
    echo "  -s, --start  Start date (YYYY-MM-DD)"
    echo "  -e, --end    End date (YYYY-MM-DD)"
    echo "  -h, --help   Show this help message"
    exit 1
}

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -s|--start)
            START_DATE="$2"
            shift 2
            ;; 
        -e|--end)
            END_DATE="$2"
            shift 2
            ;; 
        -h|--help)
            usage
            ;; 
        *)
            echo "Unknown option: $1"
            usage
            ;; 
    esac
done

# Commit log processing with date range if provided
if [ -n "$START_DATE" ] && [ -n "$END_DATE" ]; then
    git log --after="$START_DATE" --before="$END_DATE" --name-only --pretty=format: | sort | uniq -c | sort -nr
else
    git log --name-only --pretty=format: | sort | uniq -c | sort -nr
fi
