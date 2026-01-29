#!/bin/bash

echo "[+] Installing bug hunting tools..."

sudo apt install -y jq curl python3-pip

go install github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/projectdiscovery/katana/cmd/katana@latest
go install github.com/tomnomnom/waybackurls@latest

pip3 install arjun

echo "[+] Done. Add ~/go/bin to PATH"
