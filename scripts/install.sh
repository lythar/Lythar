#!/bin/bash

# LYTHAR INSTALLATION SCRIPT
# This script is used to install Lythar on a new machine. It will install all the necessary software and tools to get started with Lythar.

echo -e "\e[32mLythar Installation Script\e[0m"

if ! command -v docker &> /dev/null
then
    echo -e "\e[33mDocker nie jest zainstalowany.\e[0m"
    echo -e "\e[33mZainstaluj docker desktop z https://www.docker.com/products/docker-desktop (lub DockerCLI)\e[0m"
    exit
fi

if ! command -v docker-compose &> /dev/null
then
    echo -e "\e[33mDocker Compose nie jest zainstalowany.\e[0m"
    echo -e "\e[33mZainstaluj docker-compose z https://docs.docker.com/compose/install/\e[0m"
    exit
fi

if ! command -v git &> /dev/null
then
    echo -e "\e[32mGit nie jest zainstalowany. Zainstaluj go używajać package manegera\e[0m"
    exit
fi

clone_repository() {
    repo=$1
    path=$2

    if [ ! -d "$path" ]; then
        echo -e "\e[32mKlonowanie repozytorium $repo do $path...\e[0m"
        git clone $repo $path
        rm -rf "$path/.git"
    else
        echo -e "\e[33mRepozytorium $repo już istnieje w $path.\e[0m"
    fi
}

current_working_directory=$(pwd)

mkdir -p "$current_working_directory/Lythar"

new_working_directory="$current_working_directory/lythar-chat"

echo -e "\e[32mKlonowanie repozytoriów Lythar...\e[0m"

clone_repository "https://github.com/lythar/Lythar" "$new_working_directory/Lythar"
clone_repository "https://github.com/lythar/lythar-frontend" "$new_working_directory/lythar-frontend"
clone_repository "https://github.com/lythar/lythar-backend" "$new_working_directory/lythar-backend"

echo -e "\e[32mKopiowanie przykładowych plików konfiguracyjnych...\e[0m"
cp -r "$new_working_directory/Lythar/scripts/example_secrets" "$new_working_directory/Lythar/secrets"
cp "$new_working_directory/Lythar/.env.example" "$new_working_directory/Lythar/.env"

echo -e "\e[32mUsuwanie niepotrzebnych plików...\e[0m"
rm -rf "$new_working_directory/Lythar/scripts"

echo -e "\e[32mZainstalowano Lythar. Następne kroki:\e[0m"
echo -e "\e[32m- Skonfiguruj pliki konfiguracyjne w folderze secrets i  w pliku .env\e[0m"