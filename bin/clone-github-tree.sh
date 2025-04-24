#!/bin/bash

set -e

if [ $# -ne 1 ]; then
    echo "Usage: $0 <github-tree-url>"
    exit 1
fi

url=$1

# Extract owner and repo from URL
if [[ $url =~ github\.com/([^/]+)/([^/]+)(/tree/([^/]+)(/(.+))?)?$ ]]; then
    owner=${BASH_REMATCH[1]}
    repo=${BASH_REMATCH[2]}
    branch=${BASH_REMATCH[4]:-"main"}  # Default to "main" if branch is not specified
    path=${BASH_REMATCH[6]:-""}        # Empty string if path is not specified
else
    echo "Invalid GitHub URL"
    exit 1
fi

# target_dir is parent directory of the path
target_dir="./ref-docs/github/$owner/"
mkdir -p "$target_dir"

cd "$target_dir"
# Clone repository with minimal history and without checking out any files
git clone --depth 1 --no-single-branch --filter=blob:none --no-checkout "git@github.com:$owner/$repo.git"
cd "$repo"
# Initialize sparse checkout and temporarily allow all paths
git sparse-checkout set --no-cone '/*'
# Set sparse checkout to only include the specified path if provided
if [ -n "$path" ]; then
    git sparse-checkout set "$path"
else
    git sparse-checkout disable  # Clone entire repository if no path specified
fi
# Checkout the specified branch
git checkout "origin/$branch"

echo
if [ -n "$path" ]; then
    echo "Successfully cloned $path to $target_dir$repo"
else
    echo "Successfully cloned repository to $target_dir$repo"
fi
