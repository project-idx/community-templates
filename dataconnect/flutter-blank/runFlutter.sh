#!/bin/bash
./startProxy.sh &
flutter run --machine -d web-server --web-hostname 0.0.0.0 --web-port 9003
