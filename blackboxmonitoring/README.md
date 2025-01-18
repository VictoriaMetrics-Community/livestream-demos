# Blackbox Monitoring
This is a demo of comparing various methods of blackbox monitoring including 

* Prometheus Blackbox exporter
* Telegraf
* gatus
* uptime-kuma

## Customization
All the demos have a ping, DNS, and HTTPS checks check configured for victoriametrics.com and docs.victoriametrics.com except uptime-kuma because it does not provide a way to pre-populate checks without a 3rd party tool.

### Traefik
in the traefik/traefik.yml file you will need to change the following to match you setup. If you do not want to use traefik all services will expose a port accessing the service without a reverse proxy, and this section will be ignored

* email address for generating letsencrypt emails under `certificateResolvers.dynamicResolver.acme.email`
* the dns challenge values under `certificateResolvers.dynamicResolver.dnsChallenge`
* the hostnames for each service under `http.routers.<service_name>.rule` should match the fqdn you want to use traefik

### Gatus
The configuration for gatus is kept in the gatus/config/config.yml file and documentation for configuring gatus can be found [in their docs](https://github.com/TwiN/gatus?tab=readme-ov-file#configuration)

### Blackbox Exporter
The configuration for blackbox exporter is kept in blackbox-exporter/config/blackbox.yml file. For more details on configuring blackbox exporter please review the following resources

* [Blackbox exporter Github](https://github.com/prometheus/blackbox_exporter)
* [Blog post for setting up blackbox exporter](https://www.opsramp.com/guides/prometheus-monitoring/prometheus-blackbox-exporter/)

### Telegraf
The configuration for Telegraf is kept in the telegraf/telegraf.d/blackbox.conf file. for details on configuring telegraf I have linked the docs for each plugin used in the config

* [http checks](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/http_response)
* [dns_checks](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/dns_query)
* [ping checks](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/ping)
* [prometheus scraping](https://github.com/influxdata/telegraf/tree/master/plugins/outputs/prometheus_client)
* [pushing via influxdb](https://github.com/influxdata/telegraf/tree/master/plugins/outputs/influxdb)

### Uptime Kuma
By default Uptime Kuma doesn't have any preconfigured checks

### Victoriametrics
In order to scrape metrics from uptime-kuma you will need to [create an API key by following their documenation](https://github.com/louislam/uptime-kuma/wiki/API-Keys#adding-an-api-key).
Then you will need to change the password victoriametrics-config/scrape.yml in the uptime-kuma job from `SUPER_SECRET_PASSWORD` to the api that was generated in uptime-kuma
