#!/bin/bash

set -e

AVD_NAME="test-x86"
VNC_PORT=5900
NOVNC_PORT=6080

# 1. Start the emulator with GUI
echo "🚀 Starting emulator $AVD_NAME with GPU support..."
emulator -avd "$AVD_NAME" -gpu host -no-snapshot -no-audio -no-boot-anim &

# 2. Wait for emulator to fully boot
boot_completed=""
echo "⏳ Waiting for emulator to boot..."
while [[ "$boot_completed" != "1" ]]; do
  sleep 5
  boot_completed=$(adb shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')
  echo "Still booting..."
done

echo "✅ Emulator booted!"

# 3. Find the emulator window
EMULATOR_WINDOW_ID=$(xwininfo -root -tree | grep "Android Emulator" | awk '{print $1}' | head -n 1)

if [ -z "$EMULATOR_WINDOW_ID" ]; then
  echo "❌ Could not find emulator window. Make sure GUI is available."
  exit 1
fi

echo "🪟 Found emulator window: $EMULATOR_WINDOW_ID"

# 4. Start x11vnc on the emulator window
killall x11vnc || true
x11vnc -id $EMULATOR_WINDOW_ID -noxdamage -repeat -forever -shared -bg

echo "📡 x11vnc is running on port $VNC_PORT"

# 5. Start noVNC if not already running
if [ ! -d "$HOME/noVNC" ]; then
  echo "📦 Cloning noVNC..."
  git clone https://github.com/novnc/noVNC.git "$HOME/noVNC"
fi

cd "$HOME/noVNC"
echo "🌐 Launching noVNC on port $NOVNC_PORT..."
./utils/novnc_proxy --vnc localhost:$VNC_PORT &

sleep 2

# 6. Display access URL
IP=$(hostname -I | awk '{print $1}')
echo "✅ Access your emulator in the browser: http://$IP:$NOVNC_PORT/vnc.html"
