#!/bin/bash

# Function to activate the virtual environment if not already activated
activate_venv() {
    if [ -z "$VIRTUAL_ENV" ]; then
        echo "Activating virtual environment..."
        . ./venv/bin/activate
    fi
}

install() {
    # Check if Python is installed
    if ! command -v python &>/dev/null; then
        echo "Error: Python is not installed. Please install Python before running this script."
        exit 1
    fi

    # Create a virtual environment
    python -m venv venv
    activate_venv

    # Install pre-commit
    pip install pre-commit

    # Check for existing .pre-commit-config.yaml
    if [ -f .pre-commit-config.yaml ]; then
        # Backup existing .pre-commit-config.yaml with timestamp
        backup_filename=".pre-commit-config-$(date +"%Y%m%d%H%M%S").yaml"
        mv .pre-commit-config.yaml "$backup_filename"
        echo "Backup created: $backup_filename"
    fi

    # Create pre-commit configuration file
    pre-commit sample-config > .pre-commit-config.yaml
    cat <<EOF >> .pre-commit-config.yaml
-   repo: https://github.com/gitleaks/gitleaks
    rev: v8.18.1
    hooks:
    -   id: gitleaks
EOF

    # Call the update function to update pre-commit hooks
    update

    # Install pre-commit hooks
    pre-commit install --install-hooks

    # Run pre-commit
    pre-commit

    # Inform the user
    echo "Congratulations! Your commits are now protected from secret leakages."
}

uninstall() {
    # Activate virtual environment
    activate_venv

    # Uninstall pre-commit
    pre-commit uninstall

    # Deactivate virtual environment
    deactivate
}

cleanup() {
    # Optionally, remove virtual environment and configuration files
    rm -rf venv .pre-commit-config*.yaml
}

update() {
    # Activate virtual environment
    activate_venv

    # Update pre-commit hooks
    pre-commit autoupdate
}

# Check command line parameters
for command in "$@"; do
    case "$command" in
        install)
            install
            ;;
        uninstall)
            uninstall
            ;;
        cleanup)
            cleanup
            ;;
        update)
            update
            ;;
        *)
            echo "Error: Invalid command '$command'. Usage: $0 {install|update|uninstall|cleanup}"
            exit 1
            ;;
    esac
done
