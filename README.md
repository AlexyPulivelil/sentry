**Terraform**

* Terraform code in the terraform/ directory creates an EC2 instance and related resources.

* Variables and outputs are managed using variables.tf, terraform.tfvars, and outputs.tf.

* The EC2 instance acts as the host for the Sentry application.

**Ansible**

* The ansible/ directory contains the Ansible configuration used to configure the EC2 instance.

* The Ansible playbook installs and sets up the self-hosted Sentry application.

* Roles and tasks are defined under ansible/roles/sentry.

`ansible-playbook -i inventory playbook.yml \
  -e "sentry_admin_email=your-real-email@company.com" \
  -e "sentry_admin_password=YourRealPassword123"`

**Log Rotation**

The script (scripts/cleanup.sh) runs on a schedule and performs the following:

* Checks whether /var/log/application.log exists.
If it does not exist, the script exits safely.

* Checks the size of the log file.
If the file is smaller than 500 MB, no action is taken.

* If the log file is larger than 500 MB:
The current log file is copied to an archive directory

* A timestamp is added to the archived filename
The original log file is cleared so the application can continue writing without interruption

* The archived file is compressed using gzip.

* Any archived logs older than 5 days are automatically deleted.

This ensures that logs are rotated, compressed, and cleaned up without affecting the running application.

**Cron Schedule**

The script is configured to run every hour using cron:

`0 * * * * /bin/bash /opt/sentry/scripts/cleanup.sh >> /var/log/log_cleanup.log 2>&1`

Running it hourly ensures the log file does not grow too large during the day and that old logs are cleaned up automatically.

*Test the Log Rotation Manually*

Create a test log file:

`sudo touch /var/log/application.log` </br>
`sudo chmod 666 /var/log/application.log`

Add sample data:

`echo "Test log entry" >> /var/log/application.log`

Run the script:

`bash scripts/cleanup.sh`

Check the archive directory:

`ls /var/log/archive`

You should see compressed .gz files when the log file exceeds the size limit.