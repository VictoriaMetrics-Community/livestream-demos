# Jenkins Setup

## Prerequisite for getting logs
Create the following file `/etc/docker/daemon.json` with the below as it's contents.
```json
{
    "log-driver": "syslog",
    "log-opts": {
        "syslog-address": "udp://localhost:1234",
        "syslog-format": "rfc5424",
        "tag": "{{.Name}}"
    }
}
```
Restart docker `sudo systemctl restart docker`

## Setup
```bash
docker compose up -d
```

## Logging into Jenkins
Use the password from in the next step for the admin wizard setup
```bash
cat /var/lib/docker/volumes/jenkins_jenkins_home/_data/secrets/initialAdminPassword
```
1. Goto the login screen for jenkins. substitute `your_ip` with your machines IP address. `http://your_ip:8080`
2. `Install suggested plugins`.
3. Go through the setup wizard with whatever other values you want.
4. Next goto the `settings cog` than `plugins`
5. Click on `Available plugins`
6. Search for `OpenTelemetry`
7. Click the check box beside `OpenTelemetry` not the API!
8. Click `Install`
Scroll to the bottom and check the `Restart Jenkins box`

## Configuring OTEL in Jenkins
1. Next goto the `settings cog` than `System`
2. Scroll down to `OTLP Endpoint` `http://otel_collector:4317`

3. Click on `Add Visualisation Observability Backend` Select `Custom Observability Backend` we will do this twice will the following values.
  Name: `View Traces`
  Trace visualization URL template: `http://35.239.115.183:3000/explore?schemaVersion=1&panes=%7B%22u0h%22:%7B%22datasource%22:%22deyz29j2g3qbkb%22,%22queries%22:%5B%7B%22refId%22:%22A%22,%22datasource%22:%7B%22type%22:%22jaeger%22,%22uid%22:%22deyz29j2g3qbkb%22%7D,%22queryType%22:%22search%22,%22service%22:%22jenkins%22%7D%5D,%22range%22:%7B%22from%22:%22now-1h%22,%22to%22:%22now%22%7D,%22compact%22:false%7D%7D&orgId=1`
  
  Name: `View Dashboard`
  Trace visualization URL template: `http://35.239.115.183:3000/d/adzf6pd/test`

4. Click on `Apply` than `Save`

## Creating a log recorder jenkins
1. Next goto the `settings cog` than `System Log`
2. At the top `Add recorder`
3. Give it a name.
4. `Add` under Loggers
5. Leave Logger empty
6. Select the logging level you want.
7. Click `Apply` than `Save`

## Creating a test job
1. On the main jenkins page Select `New Item`
2. Give it a name example: `test job`
3. Select `Freestyle Project` than hit `OK`
4. In the left menu click on `Build Steps`
5. Add a new build step `Add build step` -> `Execute shell`
For our demo this won't do anything more than print out text, wait for 30 seconds so some metrics are scraped during the execution time span, than we print out an additional bit of text just for fun before exiting.
6. Put the below code snippit into the `Command` field
```bash
echo 'hello world'
sleep 30
echo 'hello world2'
```
7. Press `Apply` and `Save`

## Running the job
You should have been taken back to the main page for the job we just created.
In the left click on `Build Now` that will run our job. You will notice it takes some time to run. This is because we told it to wait 30 seconds before it exits. After it is finished it will have a green checkmark beside it indicating that it has finished running and that it succeeded.

## Grafana
Everything should be setup and ready to go in grafana so all you have to do is login.
1. Goto the login screen of grafana. substitute `your_ip` with your machines IP address. `http://your_ip:3000` Use the default of `admin`, `admin` to login than change the password to whatever you want.
2. Navigate to `Dashboards` and you will see the `Jenkins Statistics` dashboard

Inside of that dashboard there are 2 panels at the top for metrics. They show CPU and memory usage over time.

Going down you will see a logs panel that shows the logs during the selected time. Than all the traces also over the time.

Onto the cool stuff.
If you click on a trace id and select `Trace Link` you will see the dashboard change. The logs are now filtered to just logs that happened within that trace. The metrics have also changed. They are over the time span of that trace.
If your not seeing metrics it's because we only scrape every 15 seconds so try looking for a trace with a duration of 30 seconds. That's why we had jenkins sleep for 30 seconds in our test job.

