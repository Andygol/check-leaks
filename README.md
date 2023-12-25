# Pre-Commit Installation Script

This script automates the installation, uninstallation, cleanup, and updating of pre-commit hooks in your Git repositories. 

Pre-commit hooks help ensure that your commits meet certain standards and protect against secret leakages.

## Usage

### Prerequisites

- Python must be installed on your system.

### Installation

#### 1. Download and Run Script

You can download and run the script directly using curl. Execute the following command in your terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/Andygol/check-leaks/main/pre-commit.sh | sh -s install
```

This will download and run the script with the `install` command.

Alternatively, you can download the script and make it executable manually:

```bash
curl -O https://raw.githubusercontent.com/Andygol/check-leaks/main/pre-commit.sh
```

#### 2. Make the script executable

```bash
chmod +x pre-commit.sh
```

### Commands

#### 1. Install

Run the following command to set up pre-commit hooks for your repository:

```bash
./pre-commit.sh install
```

This will create a virtual environment, install pre-commit, configure hooks including one for detecting secrets, and run pre-commit.

#### 2. Uninstall

To remove pre-commit from your repository, use the following command:

```bash
./pre-commit.sh uninstall
```

This will uninstall pre-commit and leave your repository without any hooks.

#### 3. Cleanup

If you want to remove the virtual environment and configuration files, run:

```bash
./pre-commit.sh cleanup
```

Do note that this will not remove the hooks from your repository. Use the `uninstall` command to remove them. You can combine `uninstall` and `cleanup` to remove the hooks and the virtual environment.

```bash
./pre-commit.sh uninstall cleanup
```

```bash
curl -fsSL https://raw.githubusercontent.com/Andygol/check-leaks/main/pre-commit.sh | sh -s uninstall cleanup
```

#### 4. Update

To update your pre-commit hooks to the latest versions, use:

```bash
./pre-commit.sh update
```

This will automatically update the hooks using `pre-commit autoupdate`.

### Additional Information

- This script assumes that you have Python installed on your system.
- For more details on pre-commit, visit the [official documentation](https://pre-commit.com/).

Feel free to customize the script based on your needs.

---

**Note:** Always review scripts before running them, and use them at your own risk.

## License

This script is licensed under the MIT License. See the [LICENSE](https://github.com/Andygol/check-leaks/blob/main/LICENSE) file for details.

## Author

This script was created by Andrii Holovin ([Andygol](https://github.com/Andygol)).
