# 🚀 UDP Custom (YHDS Mod)

UDP Custom adalah tool untuk membuat UDP tunnel server berbasis VPS untuk kebutuhan testing dan koneksi UDP.

> ⚠️ Gunakan hanya untuk kebutuhan pribadi dan server yang diizinkan.

---

## 📦 Fitur
- UDP Tunnel Server
- Systemd service auto start
- Auto install manager menu
- Support Ubuntu & Debian
- Auto start on reboot
- Simple installation script

---

## 🖥️ Requirement
- Ubuntu 18.04 / 20.04 / 22.04
- Debian 10+
- Root access (sudo)
- wget / curl aktif

---

## ⚙️ Installation

### Cara 1 (Recommended)
```bash
wget -O install.sh https://raw.githubusercontent.com/mandiriwe1/udp-custom/main/install.sh
bash install.sh
```

---

### Cara 2 (One-line install)
```bash
bash <(curl -s https://raw.githubusercontent.com/mandiriwe1/udp-custom/main/install.sh)
```

---

## 📁 Struktur File

```
/root/udp/
 ├── udp-custom
 └── config.json
```

```
/etc/systemd/system/
 └── udp-custom.service
```

---

## ▶️ Service Control

Start:
```bash
systemctl start udp-custom
```

Restart:
```bash
systemctl restart udp-custom
```

Stop:
```bash
systemctl stop udp-custom
```

Status:
```bash
systemctl status udp-custom
```

---

## 📊 Menu Manager

```bash
menu
```

---

## 🔧 Troubleshooting

### lolcat error
```bash
apt install ruby -y
gem install lolcat
```

---

### service not running
```bash
systemctl daemon-reload
systemctl restart udp-custom
```

---

### cek port
```bash
iptables -L -n
ss -tulnp | grep udp
```

---

## 🌐 Default Port
- UDP 443 (recommended)
- UDP 80 (fallback)
- UDP 8080 (alternative)

---

## ⚡ Tips Stabil
- Gunakan VPS SG / JP
- Gunakan port 443 atau 80
- Hindari NAT VPS
- Pastikan UDP tidak diblok ISP

---

## 👨‍💻 Author
YHDS Developer Team  
https://github.com/mandiriwe1/udp-custom

---

## 📌 Notes
- Butuh root access
- Tidak semua ISP support UDP tunnel
- Stabilitas tergantung jaringan VPS
