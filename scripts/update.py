#!/usr/bin/env python3

from git import Repo
import requests

import hashlib
import os
import sys

version = sys.argv[1]
username = sys.argv[2]
token = sys.argv[3]

gitRemote = f"https://{username}:{token}@github.com/fatlard1993/homebrew-torero.git"

gitFolder = 'homebrew-torero'
formulaPath = 'Formula/torero.rb'
fullFormulaPath = f'{gitFolder}/{formulaPath}'

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

def clone_repo():
    # Ensure the directory exists and is empty
    if not os.path.exists(gitFolder):
        os.makedirs(gitFolder)
    else:
        if os.listdir(gitFolder):  # Check if directory is empty
            raise Exception(f"Directory {gitFolder} is not empty. Please provide an empty directory.")

    # Clone the repository
    Repo.clone_from(gitRemote, gitFolder)
    print(f"Repository cloned into {gitFolder}")

def update_formula():
    """
    Update the formula file with new URLs and SHA256 hashes.
    """
    # Read the original .rb file content
    with open(fullFormulaPath, 'r') as file:
        lines = file.readlines()

    # Update lines with new URLs and SHA256 hashes
    new_lines = []
    for line in lines:
        for arch, info in architectureMap.items():
            if arch in line:
                if "url" in line:
                    line = f'    url "{info["url"]}"\n'
                elif "sha256" in line:
                    line = f'    sha256 "{info["sha256"]}"\n'
        new_lines.append(line)

    # Write the updated content back to the .rb file
    with open(fullFormulaPath, 'w') as file:
        file.writelines(new_lines)

def commit_changes():
    repo = Repo(gitFolder)

    repo.git.add(formulaPath)
    repo.index.commit(f"Update to {version}")

    origin = repo.remote(name="origin")
    origin.push()

    print(f"Changes committed and pushed to {gitFolder}")

# --- #

for architecture in architecture:
    url=f"https://download.torero.dev/torero-v{version}-{architecture}.tar.gz"
    architectureMap[architecture] = {}
    architectureMap[architecture]["url"] = url
    architectureMap[architecture]["sha256"] = get_sha256_from_url(url)

try:
    clone_repo()
except Exception as e:
    print(str(e))

update_formula()

commit_changes()
