
package main

import (
    "fmt"
    "os"
    "os/exec"
    "strings"

    "github.com/spf13/cobra"
)

func fetchAndPrune() error {
    cmd := exec.Command("git", "fetch", "-p")
    cmd.Stdout = os.Stdout
    cmd.Stderr = os.Stderr
    return cmd.Run()
}

func getGoneBranches() ([]string, error) {
    cmd := exec.Command("git", "branch", "-vv")
    output, err := cmd.Output()
    if err != nil {
        return nil, err
    }
    lines := strings.Split(string(output), "\n")
    var goneBranches []string
    for _, line := range lines {
        if strings.Contains(line, ": gone]") {
            parts := strings.Fields(line)
            if len(parts) > 0 {
                goneBranches = append(goneBranches, parts[0])
            }
        }
    }
    return goneBranches, nil
}

func deleteBranches(branches []string, force bool) error {
    flag := "-d"
    if force {
        flag = "-D"
    }
    for _, branch := range branches {
        cmd := exec.Command("git", "branch", flag, branch)
        cmd.Stdout = os.Stdout
        cmd.Stderr = os.Stderr
        if err := cmd.Run(); err != nil {
            return err
        }
    }
    return nil
}

func main() {
    var prune bool
    var force bool

    var rootCmd = &cobra.Command{
        Use:   "remove-branches",
        Short: "Remove local branches that no longer exist on remote",
        Run: func(cmd *cobra.Command, args []string) {
            if err := fetchAndPrune(); err != nil {
                fmt.Println("Error during git fetch -p:", err)
                return
            }

            goneBranches, err := getGoneBranches()
            if err != nil {
                fmt.Println("Error getting gone branches:", err)
                return
            }

            if prune {
                if err := deleteBranches(goneBranches, force); err != nil {
                    fmt.Println("Error deleting branches:", err)
                }
            } else {
                fmt.Println("Branches to be removed:")
                for _, branch := range goneBranches {
                    fmt.Println(branch)
                }
            }
        },
    }

    rootCmd.Flags().BoolVar(&prune, "prune", false, "Remove local branches that no longer exist on remote")
    rootCmd.Flags().BoolVar(&force, "force", false, "Force delete local branches that no longer exist on remote")

    if err := rootCmd.Execute(); err != nil {
        fmt.Println("Error:", err)
        os.Exit(1)
    }
}

