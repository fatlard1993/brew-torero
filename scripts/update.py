#!/usr/bin/env python3

from git import Repo
import hashlib
import os
import requests
import sys

version = sys.argv[1]
architecture = ["darwin-amd64","darwin-arm64","linux-amd64","linux-arm64"]

architectureMap = {}

def get_sha256_from_url(url):
    response = requests.get(url, stream=True)
    sha256_hash = hashlib.sha256()

    # Read the file in chunks to avoid using too much memory
    for chunk in response.iter_content(chunk_size=8192):
        sha256_hash.update(chunk)

    # Return the hexadecimal SHA-256 hash of the file
    return sha256_hash.hexdigest()


for architecture in architecture:
    url=f"https://download.torero.dev/torero-v{version}-{architecture}.tar.gz"
    architectureMap[architecture] = {}
    architectureMap[architecture]["url"] = url
    architectureMap[architecture]["sha256"] = get_sha256_from_url(url)

print(architectureMap)

def clone_repo(git_url, directory):
    """
    Clones a git repository into the specified directory.

    Args:
    git_url (str): URL of the git repository to clone.
    directory (str): Local path to clone the repository into.
    """
    # Ensure the directory exists and is empty
    if not os.path.exists(directory):
        os.makedirs(directory)
    else:
        if os.listdir(directory):  # Check if directory is empty
            raise Exception(f"Directory {directory} is not empty. Please provide an empty directory.")

    # Clone the repository
    Repo.clone_from(git_url, directory)
    print(f"Repository cloned into {directory}")

# Example usage
git_url = 'https://github.com/fatlard1993/homebrew-torero.git'
directory = 'homebrew-torero'

# try:
#     clone_repo(git_url, directory)
# except Exception as e:
#     print(str(e))

def update_rb_file(file_path, architecture_map):
    """
    Update the .rb file with new URLs and SHA256 hashes.

    Args:
    file_path (str): Path to the .rb file to update.
    architecture_map (dict): Dictionary containing the architecture, URLs, and SHA256 hashes.
    """
    # Read the original .rb file content
    with open(file_path, 'r') as file:
        lines = file.readlines()

    # Update lines with new URLs and SHA256 hashes
    new_lines = []
    for line in lines:
        for arch, info in architecture_map.items():
            if arch in line:
                if "url" in line:
                    line = f'    url "{info["url"]}"\n'
                elif "sha256" in line:
                    line = f'    sha256 "{info["sha256"]}"\n'
        new_lines.append(line)

    # Write the updated content back to the .rb file
    with open(file_path, 'w') as file:
        file.writelines(new_lines)

# Example usage
file_path = 'homebrew-torero/Formula/torero.rb'
update_rb_file(file_path, architectureMap)