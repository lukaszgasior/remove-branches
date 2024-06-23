[![Build remove-branches CLI](https://github.com/lukaszgasior/remove-branches/actions/workflows/build.yml/badge.svg)](https://github.com/lukaszgasior/remove-branches/actions/workflows/build.yml)
[![Release](https://github.com/lukaszgasior/remove-branches/actions/workflows/release.yml/badge.svg)](https://github.com/lukaszgasior/remove-branches/actions/workflows/release.yml)

# Remove Branches CLI

Remove Branches CLI is a simple tool to help you remove local Git branches that no longer exist on the remote repository. 

I created this tool out of a personal need. I was tired of the repetitive process of manually checking and deleting local branches that had already been removed from the remote repository. 
This tool automates that process, making branch management much simpler and more efficient.

## Why Golang?

While it is possible to achieve the same result with a simple script, I have recently fallen in love with Golang.
Therefore, I decided to take this opportunity to create Remove Branches CLI in Golang.

## Installation

### Linux/macOS

Download the app from the Releases page and add it to you $PATH folder (/usr/local/bin).
Installation script will be provided soon.

### Windows

To install this tool on Windows, open PowerShell as Administrator and run the following command:

```powershell
iex "& { $(Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/lukaszgasior/remove-branches/main/install.ps1' -UseBasicParsing) }"
```

The app will be installed in `"$env:ProgramFiles\Git\cmd"` folder, so in case of any issues with running this command 
make sure this folder is added to your $PATH.

## Usage

After installing the tool, you can use it with the following commands:

### Display branches to be removed

To display local branches that no longer exist on the remote repository, run:

```sh
git remove-branches
```

### Remove branches with -d flag

To remove local branches that no longer exist on the remote repository using the -d flag, run:

```sh
git remove-branches --prune
```

### Force remove branches with -D flag

To force remove local branches that no longer exist on the remote repository using the -D flag, run:

```sh
git remove-branches --prune --force
```

## How to build it locally?

Just run:
```sh
go build -o git-remove-branches . && mv git-remove-branches $GOPATH/bin/
```

## How to run goreleaser locally

```sh
goreleaser release --snapshot --clean
```

## Contributing

If you find any issues or have suggestions for improvements, please open an issue or create a pull request on the GitHub repository.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.

