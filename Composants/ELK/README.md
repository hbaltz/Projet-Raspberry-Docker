# Elasticsearch Logstash Kibana

- Logstash : Analyse des données brutes
- Elasticsearch : Stockage de toutes les données 
- Kibana : interface web pour graphiques et statistiques

Ces trois outils ont chacun un rôle bien précis dans le workflow permettant de passer des logs bruts au format text à des dashboards avec graphiques et statistiques. Ils montreront de manière synthétique le contenu des logs.

## Téléchargement des images
```
docker pull ind3x/rpi-elasticsearch
docker pull ind3x/rpi-logstash
docker pull ind3x/rpi-kibana
```
## Mise en route
```
docker-compose up
```
## Fichiers nécessaires
### docker-compose.yml
```
elasticsearch:

  image: ind3x/rpi-elasticsearch

  volumes:
    - elk-data:/usr/share/rpi-elasticsearch/data


logstash:

  image: ind3x/rpi-logstash

  links:
    - elasticsearch

  ports:
    - "5601:5601"

  volumes:
    - ./:/rpi-logstash/etc

  command: "-f /rpi-logstash/etc/completion.conf"


kibana:

  image: ind3x/rpi-kibana

  links:
    - elasticsearch

  ports:
    - "9201:9201"
```
### completion.conf
```
input {
	tcp {
		port => 5601
	}
	file {
		path => "/mnt/data/traefik/log/access.log"
	}
}
filter {
	grok {
		match => { "message" => "%{IP:client} %{WORD:method} %{URIPATHPARAM:request} %{NUMBER:bytes} %{NUMBER:duration}" }
  	}
}
output {
	elasticsearch {
		hosts => ["elasticsearch"]
	}
}
```
## Ce qui reste à faire...
Régler les ports.  
Analyser le fichier .log.  
Vérifier les chemins d'accès.
