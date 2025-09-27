#!/bin/bash

# Fungsi untuk mengecek apakah command ada di PATH
check_command() {
    if command -v "$1" &> /dev/null; then
        echo "✓ $1 sudah terinstall"
        return 0
    else
        echo "✗ $1 belum terinstall"
        return 1
    fi
}

# Fungsi untuk install package menggunakan apt
install_apt() {
    echo "Menginstall $1..."
    apt install -y "$1"
}

# Fungsi untuk install package menggunakan npm
install_npm() {
    echo "Menginstall $1..."
    npm install -g "$1"
}

# Update package list terlebih dahulu
echo "Memperbarui daftar package..."
apt update

# List tools yang perlu dicek dan diinstall
# Format: command_name:package_name:install_method
tools=(
    "nvim:neovim:apt"
    "node:nodejs-lts:apt" 
    "lua-language-server:lua-language-server:apt"
    "bash-language-server:bash-language-server:npm"
    "basedpyright:basedpyright:npm"
    "typescript-language-server:typescript-language-server:npm"
)

# Variabel untuk track apakah perlu install ulang
need_install=false

echo "Mengecek tools yang sudah terinstall..."

# Cek semua tools
for tool in "${tools[@]}"; do
    IFS=':' read -r command_name package_name install_method <<< "$tool"
    if ! check_command "$command_name"; then
        need_install=true
    fi
done

# Jika ada yang perlu diinstall, jalankan install
if [ "$need_install" = true ]; then
    echo ""
    echo "Menginstall tools yang diperlukan..."
    
    for tool in "${tools[@]}"; do
        IFS=':' read -r command_name package_name install_method <<< "$tool"
        
        if ! check_command "$command_name"; then
            case $install_method in
                "apt")
                    install_apt "$package_name"
                    ;;
                "npm")
                    install_npm "$package_name"
                    ;;
                *)
                    echo "Error: Method install tidak dikenali untuk $command_name"
                    ;;
            esac
        fi
    done
    
    echo ""
    echo "Installasi selesai!"
else
    echo ""
    echo "Semua tools sudah terinstall!"
fi

# Verifikasi akhir
echo ""
echo "Verifikasi akhir:"
for tool in "${tools[@]}"; do
    IFS=':' read -r command_name package_name install_method <<< "$tool"
    check_command "$command_name"
done
