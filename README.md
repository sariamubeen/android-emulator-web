# android-emulator-web# Android Emulator Web Access Toolkit

This repository provides a clean and efficient way to run an Android emulator on Ubuntu and stream it to any web browser with full interactivity (click, tap, type). It uses `x11vnc` and `noVNC` to expose the emulator GUI remotely.

---

## 📦 What's Included

- Android emulator launcher with GPU
- Boot check loop
- Auto-detection of emulator window
- x11vnc streaming to VNC
- noVNC server for web access

---

## ✅ Requirements

- Ubuntu 20.04 or newer
- Virtualization enabled in BIOS
- Android SDK & AVD configured (`test-x86` or any AVD)
- Git & x11vnc installed

---

## 🛠️ Setup

### 1. Clone This Repository
```bash
git clone https://github.com/your-username/android-emulator-web.git
cd android-emulator-web
```

### 2. Make the Script Executable
```bash
chmod +x start_emulator_vnc.sh
```

### 3. Run It 🚀
```bash
./start_emulator_vnc.sh
```

After successful launch, you’ll see:
```
✅ Access your emulator in the browser: http://<your-ip>:6080/vnc.html
```

Open that in any modern browser (Chrome, Firefox, etc.)

---

## 🧼 Clean Up
To stop all services:
```bash
killall emulator x11vnc node novnc_proxy
```

---

## 📁 Repo Structure
```
android-emulator-web/
├── start_emulator_vnc.sh   # Main launcher script
├── README.md               # You are here
```

---

## ✨ Features
- Headless-safe
- Interactive via browser
- Script auto-detects window
- GPU rendering enabled (if supported)

---

## 🙋 FAQ
**Q: My browser shows a black screen?**  
A: Ensure you’re not using `scrcpy` — this streams the actual emulator window, not a mirrored one.

**Q: Can I use this in CI/CD?**  
A: Yes! With a display server like `xvfb`, you can headlessly automate tests.

---

## 👤 Author
**Saria Mubeen**  
[github.com/sariamubeen](https://github.com/sariamubeen)

---

## 📜 License
MIT License — feel free to fork, use, and contribute ❤️
