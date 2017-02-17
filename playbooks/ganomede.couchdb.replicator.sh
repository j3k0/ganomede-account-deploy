#!/bin/bash

# TODO: replicate using mesos-dns (so data doesn't have to go throught the proxy)

{% if index == "0" %}
OTHER_INDEX="1"
{% else %}
OTHER_INDEX="0"
{% endif %}

DATABASES="
    {% for database in couchdb_databases %}
      {{ database }}
    {% endfor %}
"
INTERNAL_LB="http://{{ hostvars[groups['marathon-lb-internal'][0]].tun0 }}:9091"
FROM_URL="$INTERNAL_LB"

for DB_NAME in $DATABASES; do
  IP=${FROM_URL%:*}
  echo "New replication:"
cat << EOF > tmp-replicator.json
{
"_id": "replicate-$DB_NAME",
"create_target": true,
"continuous": true,
"source": {
"url": "$FROM_URL/$DB_NAME",
"headers": {"X-Marathon-App-Id":"/{{ app_name }}-$OTHER_INDEX"}
},
"target": {
"url": "$FROM_URL/$DB_NAME",
"headers": {"X-Marathon-App-Id":"/{{ app_name }}-{{ index }}"}
}
}
EOF

  cat tmp-replicator.json
  sleep 1
  echo 3
  sleep 1
  echo 2
  sleep 1
  echo 1
  sleep 1
  echo
  curl -H "X-Marathon-App-Id: {{ marathon_app_id}}" -H "Content-type: application/json" $INTERNAL_LB/_replicator -d @tmp-replicator.json
  echo
done
