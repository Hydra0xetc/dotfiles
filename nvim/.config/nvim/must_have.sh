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

# Fungsi untuk mengecek apakah package Python terinstall
check_python_package() {
    if python3 -c "import $1" 2>/dev/null; then
        echo "✓ Python package $1 sudah terinstall"
        return 0
    else
        echo "✗ Python package $1 belum terinstall"
        return 1
    fi
}

# Fungsi untuk mengecek apakah package npm terinstall secara global
check_npm_package() {
    if npm list -g "$1" &> /dev/null; then
        echo "✓ npm package $1 sudah terinstall"
        return 0
    else
        echo "✗ npm package $1 belum terinstall"
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

# Fungsi untuk install package menggunakan pip3
install_pip3() {
    echo "Menginstall $1..."
    pip3 install "$1"
}

# Update package list terlebih dahulu
echo "Memperbarui daftar package..."
apt update

# List tools yang perlu dicek dan diinstall
# Format: "check_type:identifier:package_name:install_method"
# check_type: command, python_package, npm_package
tools=(
    # System tools (bisa dicek dengan command)
    "command:nvim:neovim:apt"
    "command:node:nodejs:apt"
    "command:mpv:mpv:apt"
    "command:megatools:megatools:apt"
    "command:clang:clang:apt"
    "command:make:make:apt"
    "command:cmake:cmake:apt"
    "command:ninja:ninja:apt"
    "command:xxd:xxd:apt"
    "command:file:file:apt"
    "command:rg:ripgrep:apt"
    "command:ld:binutils:apt"
    "command:autoconf:autoconf:apt"
    "command:fd:fd:apt"
    "command:ffmpeg:ffmpeg:apt"
    "command:mandoc:mandoc:apt"
    "command:aria2c:aria2:apt"
    "command:crond:cronie:apt"
    "command:htop:htop:apt"
    "command:git:git:apt"
    "command:nano:nano:apt"
    "command:python3:python3:apt"
    "command:tmux:tmux:apt"
    
    # Language servers (beberapa bisa dicek dengan command)
    "command:lua-language-server:lua-language-server:apt"
    "command:bash-language-server:bash-language-server:npm"
    "command:basedpyright:basedpyright:npm"
    "command:typescript-language-server:typescript-language-server:npm"
    
    # Pip3 packages
    "python_package:wcwidth:wcwidth:pip3"
    "python_package:mpv:python-mpv:pip3"
)

# Variabel untuk track apakah perlu install ulang
need_install=false

echo "Mengecek tools yang sudah terinstall..."

# Cek semua tools
for tool in "${tools[@]}"; do
    IFS=':' read -r check_type identifier package_name install_method <<< "$tool"
    
    case $check_type in
        "command")
            if ! check_command "$identifier"; then
                need_install=true
            fi
            ;;
        "python_package")
            if ! check_python_package "$identifier"; then
                need_install=true
            fi
            ;;
        "npm_package")
            if ! check_npm_package "$identifier"; then
                need_install=true
            fi
            ;;
        *)
            echo "Error: Check type tidak dikenali: $check_type"
            ;;
    esac
done

# Jika ada yang perlu diinstall, jalankan install
if [ "$need_install" = true ]; then
    echo ""
    echo "Menginstall tools yang diperlukan..."
    
    for tool in "${tools[@]}"; do
        IFS=':' read -r check_type identifier package_name install_method <<< "$tool"
        
        case $check_type in
            "command")
                if ! check_command "$identifier"; then
                    case $install_method in
                        "apt") install_apt "$package_name" ;;
                        "npm") install_npm "$package_name" ;;
                        "pip3") install_pip3 "$package_name" ;;
                        *) echo "Error: Method install tidak dikenali untuk $identifier" ;;
                    esac
                fi
                ;;
            "python_package")
                if ! check_python_package "$identifier"; then
                    case $install_method in
                        "pip3") install_pip3 "$package_name" ;;
                        *) echo "Error: Method install tidak dikenali untuk Python package $identifier" ;;
                    esac
                fi
                ;;
            "npm_package")
                if ! check_npm_package "$identifier"; then
                    case $install_method in
                        "npm") install_npm "$package_name" ;;
                        *) echo "Error: Method install tidak dikenali untuk npm package $identifier" ;;
                    esac
                fi
                ;;
        esac
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
    IFS=':' read -r check_type identifier package_name install_method <<< "$tool"
    
    case $check_type in
        "command")
            check_command "$identifier"
            ;;
        "python_package")
            if check_python_package "$identifier"; then
                echo "✓ Python package $identifier sudah terinstall"
            else
                echo "✗ Python package $identifier belum terinstall"
            fi
            ;;
        "npm_package")
            if check_npm_package "$identifier"; then
                echo "✓ npm package $identifier sudah terinstall"
            else
                echo "✗ npm package $identifier belum terinstall"
            fi
            ;;
    esac
done

# Cek dan install pip3 jika belum ada
echo ""
if ! check_command "pip3"; then
    echo "Menginstall python3-pip..."
    apt install -y python3-pip
    pip3 install --upgrade pip
fi

# Cek dan install npm jika belum ada
echo ""
if ! check_command "npm"; then
    echo "Menginstall npm..."
    apt install -y npm
    npm install -g n
    n latest
    hash -r
fi
