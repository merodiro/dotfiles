#!/bin/sh

red='\e[1;31m'
green='\e[1;32m'
white='\e[0m'

if type jq > /dev/null
then
    echo "$green✅ jq already installed $white"
else
    (
        set -e
        echo "⏬ Installing jq"
        curl -sfSL "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64" -o ~/.local/bin/jq
        chmod +x ~/.local/bin/jq
        echo "$green✅ jq installed $white"
    )
    if [ $? -ne 0 ]; then
        echo "$red❌ jq installation failed $white"
    fi
fi

if type gh > /dev/null
then
    echo "$green✅ gh already installed $white"
else
    (
        set -e
        echo "⏬ Installing gh"
        res=$(curl -s "https://api.github.com/repos/cli/cli/releases/latest")
        version=$(echo "$res" | tr '\r\n' ' ' | jq -r '.tag_name')
        downloadLink=$(echo "$res" | tr '\r\n' ' ' | jq -r '.assets[] | select(.name | contains("linux_amd64.tar.gz")).browser_download_url')
        folderName=$(echo "$res" | tr '\r\n' ' ' | jq -r '.assets[] | select(.name | contains("linux_amd64.tar.gz")).name[:-7]')
        curl -sSL $downloadLink | tar xzf -
        rm "$folderName/LICENSE"
        rsync -au --remove-source-files "$folderName/" ~/.local
        chmod +x ~/.local/bin/gh

        rm -rf $folderName

        echo "$green✅ gh installed $white"
    )
    if [ $? -ne 0 ]; then
        echo "$red❌ gh installation failed $white"
    fi
fi

if type bat > /dev/null
then
    echo "$green✅ bat already installed $white"
else
    (
        set -e
        echo "⏬ Installing bat"
        res=$(gh api /repos/sharkdp/bat/releases/latest)
        downloadLink=$(echo "$res" | tr '\r\n' ' ' | jq -r '.assets[] | select(.name | contains("x86_64-unknown-linux-gnu")).browser_download_url')
        folderName=$(echo "$res" | tr '\r\n' ' ' | jq -r '.assets[] | select(.name | contains("x86_64-unknown-linux-gnu")).name[:-7]')
        curl -sSL $downloadLink | tar xzf - -C .

        mv "$folderName/bat" ~/.local/bin/bat
        mv "$folderName/bat.1" ~/.local/share/man/man1/bat.1

        rm -rf "$folderName"

        echo "$green✅ bat installed $white"
    )
    if [ $? -ne 0 ]; then
        echo "$red❌ bat installation failed $white"
    fi
fi

if type exa > /dev/null
then
    echo "$green✅ exa already installed $white"
else
    (
        set -e
        echo "⏬ Installing exa"
        res=$(gh api /repos/ogham/exa/releases/latest)
        downloadLink=$(echo "$res" | tr '\r\n' ' ' | jq -r '.assets[] | select(.name | contains("linux-x86_64")).browser_download_url')
        folderName=$(echo "$res" | tr '\r\n' ' ' | jq -r '.assets[] | select(.name | contains("linux-x86_64")).name[:-3]')

        curl -sSL "https://raw.githubusercontent.com/ogham/exa/master/man/exa.1.md" -o ~/.local/share/man/man1/man.1

        curl -sSL "$downloadLink" -o exa.zip
        unzip -qo exa.zip
        mv exa-linux-x86_64 ~/.local/bin/exa
        rm exa.zip

        echo "$green✅ exa installed $white"
    )
    if [ $? -ne 0 ]; then
        echo "$red❌ exa installation failed $white"
    fi
fi

if type fzf > /dev/null
then
    echo "$green✅ fzf already installed $white"
else
    (
        set -e
        echo "⏬ Installing fzf"
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
        echo "$green✅ fzf installed $white"
    )
    if [ $? -ne 0 ]; then
        echo "$red❌ fzf installation failed $white"
    fi
fi

if type cheat > /dev/null
then
    echo "$green✅ cheat already installed $white"
else
    (
        set -e
        echo "⏬ Installing cheat"
        downloadLink=$(gh api /repos/cheat/cheat/releases/latest | jq -r '.assets[] | select(.name | contains("linux-amd64")).browser_download_url')

        curl -sSL $downloadLink | gunzip -d > ~/.local/bin/cheat
        chmod +x ~/.local/bin/cheat
        echo "$green✅ cheat installed $white"
    )
    if [ $? -ne 0 ]; then
        echo "$red❌ cheat installation failed $white"
    fi
fi


