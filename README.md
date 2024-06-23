# Remove Branches CLI

Remove Branches CLI is a simple tool to help you remove local Git branches that no longer exist on the remote repository. 

I created this tool out of a personal need. I was tired of the repetitive process of manually checking and deleting local branches that had already been removed from the remote repository. 
This tool automates that process, making branch management much simpler and more efficient.

## Why Golang?

While it is possible to achieve the same result with a simple script, I have recently fallen in love with Golang.
Therefore, I decided to take this opportunity to create Remove Branches CLI in Golang.

## How to build it locally?

Just run:
`go build -o git-remove-branches . && mv git-remove-branches $GOPATH/bin/`
