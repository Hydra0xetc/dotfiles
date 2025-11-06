#!/usr/bin/env bash

# Fungsi untuk mengecek apakah command ada di PATH
check_command() {
    if command -v "$1" &> /dev/null; then
        printf "%-30s %s\n" "$1" "(OK)"
        return 0
    else
        printf "%-30s %s\n" "$1" "belum terinstall"
        return 1
    fi
}

# Fungsi untuk mengecek apakah package Python terinstall
check_python_package() {
    if python3 -c "import $1" 2>/dev/null; then
        printf "%-30s %s\n" "Python package $1" "(OK)"
        return 0
    else
        printf "%-30s %s\n" "Python package $1" "belum terinstall"
        return 1
    fi
}

# Fungsi untuk mengecek apakah package npm terinstall secara global
check_npm_package() {
    if npm list -g "$1" &> /dev/null; then
        printf "%-30s %s\n" "npm package $1" "(OK)"
        return 0
    else
        printf "%-30s %s\n" "npm package $1" "belum terinstall"
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

# Fungsi untuk install pip3 jika belum ada
install_pip3_if_needed() {
    if ! command -v pip3 &> /dev/null; then
        echo "Menginstall python3-pip..."
        apt update
        apt install -y python-pip
        pip3 install --upgrade pip
        echo "pip3 berhasil diinstall"
    else
        echo "pip3 sudah terinstall"
    fi
}

# Fungsi untuk install npm jika belum ada
install_npm_if_needed() {
    if ! command -v npm &> /dev/null; then
        echo "Menginstall npm dan nodejs..."
        apt update
        apt install -y npm nodejs
        echo "npm dan nodejs berhasil diinstall"
    else
        echo "npm sudah terinstall"
    fi
}

# Cek dan install pip3 & npm di awal
echo "=== Mempersiapkan environment ==="
echo "Mengecek pip3..."
install_pip3_if_needed

echo ""
echo "Mengecek npm..."
install_npm_if_needed

echo ""
echo "=== Memperbarui daftar package ==="
apt update

# List tools yang perlu dicek dan diinstall
# Format: "check_type:identifier:package_name:install_method"
# check_type: command, python_package, npm_package
tools=(
    # System tools (bisa dicek dengan command)
    "command:nvim:neovim:apt"
    "command:ruff:ruff:apt"
    "command:zoxide:zoxide:apt"
    "command:eza:eza:apt"
    "command:srm:secure-delete:apt"
    "command:node:nodejs:apt"
    "command:yarn:yarn:apt"
    "command:mpv:mpv:apt"
    "command:megatools:megatools:apt"
    "command:clang:build-essential:apt"
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
    "command:mandoc:man:apt"
    "command:aria2c:aria2:apt"
    "command:crond:cronie:apt"
    "command:htop:htop:apt"
    "command:git:git:apt"
    "command:nano:nano:apt"
    "command:python3:python3:apt"
    "command:tmux:tmux:apt"
    
    # Npm packages
    "command:lua-language-server:lua-language-server:apt"
    "command:bash-language-server:bash-language-server:npm"
    "npm_package:typescript:typescript:npm"
    "command:prettier:prettier:npm"
    "command:basedpyright:basedpyright:npm"
    "command:typescript-language-server:typescript-language-server:npm"
    
    # Pip3 packages
    "python_package:wcwidth:wcwidth:pip3"
    "python_package:mpv:python-mpv:pip3"
    "command:gallery-dl:gallery-dl:pip3"
    "command:yt-dlp:yt-dlp:pip3"
)

# Variabel untuk track apakah perlu install ulang
need_install=false

echo ""
echo "=== Mengecek tools yang sudah terinstall ==="

# Cek semua tools
for tool in "${tools[@]}"; do
    IFS=':' read -r check_type identifier package_name install_method <<< "$tool"
    
    case $check_type in
        "command")
            if ! check_command "$identifier" > /dev/null; then
                need_install=true
            fi
            ;;
        "python_package")
            if ! check_python_package "$identifier" > /dev/null; then
                need_install=true
            fi
            ;;
        "npm_package")
            if ! check_npm_package "$identifier" > /dev/null; then
                need_install=true
            fi
            ;;
        *)
            echo "Error: Check type tidak dikenali: $check_type"
            ;;
    esac
done

# Tampilkan hasil pengecekan pertama
echo ""
echo "Hasil pengecekan awal:"
for tool in "${tools[@]}"; do
    IFS=':' read -r check_type identifier package_name install_method <<< "$tool"
    
    case $check_type in
        "command")
            check_command "$identifier"
            ;;
        "python_package")
            check_python_package "$identifier"
            ;;
        "npm_package")
            check_npm_package "$identifier"
            ;;
    esac
done

# Jika ada yang perlu diinstall, jalankan install
if [ "$need_install" = true ]; then
    echo ""
    echo "=== Menginstall tools yang diperlukan ==="
    
    for tool in "${tools[@]}"; do
        IFS=':' read -r check_type identifier package_name install_method <<< "$tool"
        
        case $check_type in
            "command")
                if ! command -v "$identifier" &> /dev/null; then
                    case $install_method in
                        "apt") install_apt "$package_name" ;;
                        "npm") install_npm "$package_name" ;;
                        "pip3") install_pip3 "$package_name" ;;
                        *) echo "Error: Method install tidak dikenali untuk $identifier" ;;
                    esac
                fi
                ;;
            "python_package")
                if ! python3 -c "import $identifier" 2>/dev/null; then
                    case $install_method in
                        "pip3") install_pip3 "$package_name" ;;
                        *) echo "Error: Method install tidak dikenali untuk Python package $identifier" ;;
                    esac
                fi
                ;;
            "npm_package")
                if ! npm list -g "$identifier" &> /dev/null; then
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
echo "=== Verifikasi akhir ==="
for tool in "${tools[@]}"; do
    IFS=':' read -r check_type identifier package_name install_method <<< "$tool"
    
    case $check_type in
        "command")
            if command -v "$identifier" &> /dev/null; then
                printf "%-30s %s\n" "$identifier" "(OK)"
            else
                printf "%-30s %s\n" "$identifier" "belum terinstall"
            fi
            ;;
        "python_package")
            if python3 -c "import $identifier" 2>/dev/null; then
                printf "%-30s %s\n" "Python package $identifier" "(OK)"
            else
                printf "%-30s %s\n" "Python package $identifier" "belum terinstall"
            fi
            ;;
        "npm_package")
            if npm list -g "$identifier" &> /dev/null; then
                printf "%-30s %s\n" "npm package $identifier" "(OK)"
            else
                printf "%-30s %s\n" "npm package $identifier" "belum terinstall"
            fi
            ;;
    esac
done

echo ""
echo "=== Status package manager ==="
check_command "pip3"
check_command "npm"
