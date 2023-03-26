#! /usr/bin/env bash

(
  sleep 5
  [[ "$DB_AUTO_START" = "true" ]] && [[ "$USE_EXTERNAL_DATABASE" = "false" ]] && supervisorctl start db
  [[ "$APP_AUTO_START" = "true" ]] && supervisorctl start app
  [[ "$WEB_AUTO_START" = "true" ]] && supervisorctl start web
) &

exec /usr/bin/supervisord -c /etc/supervisord.conf
