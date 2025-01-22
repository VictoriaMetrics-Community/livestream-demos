# Blackbox Monitoring
This is a demo of comparing various methods of blackbox monitoring including 

* Prometheus Blackbox exporter
* Telegraf
* gatus
* uptime-kuma

## Thanks
Included in the Grafana deployment are some community dashboards.

- [Shiftmon's blackbox monitoring Dashboard]()
- [Sparanoid's blackbox dashboard](https://grafana.com/grafana/dashboards/7587-prometheus-blackbox-exporter/)
- [Eliottgoye's uptime kuma dashbaord](https://grafana.com/grafana/dashboards/18667-uptime-kuma-metrics/)
- [Gatus's Grafana Dashbaord](https://github.com/TwiN/gatus/tree/master/.examples/docker-compose-grafana-prometheus/grafana/provisioning/dashboards)

Thanks to all the authors for contributing these dashboards to the community.

I would also like to thank all the authors of the following tools for making the amazing open source software used in this demo

- [Uptime kuma](https://github.com/louislam/uptime-kuma)
- [gatus](https://gatus.io/)
- [Telegraf](https://github.com/influxdata/telegraf)
- [Blackbox exporter](https://github.com/prometheus/blackbox_exporter)

## Customization
All the demos have a ping, DNS, and HTTPS checks check configured for victoriametrics.com and docs.victoriametrics.com except uptime-kuma because it does not provide a way to pre-populate checks without a 3rd party tool.

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
By default Uptime Kuma doesn't have any preconfigured checks since by default it does not have an API or way to seed checks. You can follow along with the companion stream to add your own checks.

### Victoriametrics
In order to scrape metrics from uptime-kuma you will need to [create an API key by following their documenation](https://github.com/louislam/uptime-kuma/wiki/API-Keys#adding-an-api-key).
Then you will need to change the password victoriametrics-config/scrape.yml in the uptime-kuma job from `SUPER_SECRET_PASSWORD` to the api that was generated in uptime-kuma
