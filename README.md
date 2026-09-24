# PhotoBooth Flutter

Self Photo Studio App — Flutter (Android + Windows + macOS)

## Setup

### 1. Install Flutter
Download Flutter SDK: https://flutter.dev/docs/get-started/install
Minimum version: 3.22.0

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Generate Drift database code
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Run the app

**Windows:**
```bash
flutter run -d windows
```

**macOS:**
```bash
flutter run -d macos
```

**Android (emulator or tablet):**
```bash
flutter run -d android
```

## First Run — Admin Setup

1. Open the app → on the Idle screen tap **top-left corner 5 times**
2. Enter PIN: `1234`
3. Go to **Pengaturan** tab:
   - Set `nama_studio` → your studio name
   - Set `midtrans_server_key` → your Midtrans sandbox server key (`SB-Mid-server-...`)
   - Set `midtrans_env` → `sandbox`
4. Go to **Paket** tab → add at least one package
5. Press back → try a full session!

## Platform Notes

| Feature | Android | Windows | macOS |
|---------|---------|---------|-------|
| Full UI | ✅ | ✅ | ✅ |
| QRIS Payment | ✅ | ✅ | ✅ |
| USB PTP Camera | ✅ | 🔜 gPhoto2 | 🔜 gPhoto2 |
| Photo Capture (fallback) | Gallery picker | File picker | File picker |
| Print | ✅ | ✅ | ✅ |
| Google Drive Upload | ✅ | ✅ | ✅ |
