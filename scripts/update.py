#!/usr/bin/env python3

from git import Repo
import requests

import argparse
import hashlib
import os
import sys

parser = argparse.ArgumentParser(description="Update the published version of torero in homebrew")
parser.add_argument('--version', required=True, help="The version to publish")
parser.add_argument('--username', required=True, help="The github username with write access to the repo")
parser.add_argument('--token', required=True, help="The github token that provides write access to the repo")
args = parser.parse_args()

version = args.version
username = args.username
token = args.token

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
        if "version" in line:
            line = f'  version "{version}"\n'
        for arch, info in architectureMap.items():
            if arch in line:
                if "url" in line:
                    line = f'        url "{info["url"]}"\n'
                elif "sha256" in line:
                    line = f'        sha256 "{info["sha256"]}" # {arch}\n'
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

print(version)
print(username)
print(token)

print(f"Targeting {gitRemote}")
print(f"Registering version {version}")

try:
    clone_repo()
except Exception as e:
    print(str(e))

update_formula()

commit_changes()
