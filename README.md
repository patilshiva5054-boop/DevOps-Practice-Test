# Backup Automation System (Bash Project)

## Project Overview
This project is a **fully automated backup system** written in **Bash**, designed to create, verify, and clean up backups efficiently.  
It’s ideal for developers and system administrators who want a simple, configurable, and reliable backup workflow.

### Features
 Create compressed `.tar.gz` backups with date and time  
 Automatically generate and verify SHA-256 checksums  
 Clean up old backups using retention rules (daily/weekly/monthly)  
 Configurable backup settings via `backup.config`  
 Logging of all actions with timestamps  
 Dry run mode (test what will happen without executing)  
 Prevents multiple runs using a lock file  
 Optional restore functionality  

---

## Folder Structure

backup-system/
├── backup.sh # Main script
├── backup.config # Configuration file
├── README.md # Project documentation
├── logs/
│ └── backup.log # Detailed log file
├── backups/
│ ├── daily/ # Daily backups
│ ├── weekly/ # Weekly backups
│ └── monthly/ # Monthly backups
└── test_data/ # Sample data folder for testing

yaml
---

## Configuration (`backup.config`)

The script reads this configuration file to set up your backup preferences.

```bash
# --- Default Backup Configuration ---

# Where to store backups
BACKUP_DESTINATION=./backups

# Patterns to exclude from backup (comma-separated)
EXCLUDE_PATTERNS=".git,node_modules,.cache"

# Retention rules
DAILY_KEEP=7
WEEKLY_KEEP=4
MONTHLY_KEEP=3

# (Optional) Email notifications (not implemented yet)
EMAIL_NOTIFICATION=""


Step 1: Make the script executable
chmod +x backup.sh

Step 2: Run a normal backup
./backup.sh ./test_data


This creates a backup file like:

backup-2025-11-03-1630.tar.gz
backup-2025-11-03-1630.tar.gz.sha256

Step 3: Run in dry-run mode

See what would happen without actually creating/deleting files.

./backup.sh --dry-run ./test_data

Step 4: Restore from a backup (optional bonus)
./backup.sh --restore backups/daily/backup-2025-11-03-1630.tar.gz --to ./restored_files

 ## How It Works

 Step 1: Create Backup

The script compresses the target folder into a .tar.gz file.

# It names the backup using the current date and time:

backup-YYYY-MM-DD-HHMM.tar.gz

 Step 2: Generate and Verify Checksum

# It creates a SHA-256 checksum for each backup:

sha256sum backup.tar.gz > backup.tar.gz.sha256


# Then it verifies the integrity of the archive immediately:

sha256sum -c backup.tar.gz.sha256Project Test
