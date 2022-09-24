#!/bin/bash

# flutterを起動
flutter clean
flutter build web

echo "Starting server on port $PORT"

# サーバを起動
cd build/web/
python3 -m http.server $PORT