#!/bin/bash
# UserRecon v2.0
# Original Author: @thelinuxchoice
# Updated by: @Erzambayu
# Further updated: 2025
# https://github.com/Erzambayu/userrecon

trap 'printf "\n";partial;exit 1' 2

banner() {
printf "\e[1;92m  _   _               ____                       \e[0m\n"
printf "\e[1;92m | | | |___  ___ _ __|  _ \ ___  ___ ___  _ __  \e[0m\n"
printf "\e[1;92m | | | / __|/ _ \ '__| |_) / _ \/ __/ _ \| '_ \ \e[0m\n"
printf "\e[1;92m | |_| \__ \  __/ |  |  _ <  __/ (_| (_) | | | |\e[0m\n"
printf "\e[1;92m  \___/|___/\___|_|  |_| \_\___|\___\___/|_| |_|\e[0m\n"
printf "\e[1;92m                                                 \e[0m\n"
printf "\e[1;77m        Social Media Username Finder v2.0        \e[0m\n"
printf "\e[1;77m  Updated 2025 | Original: @thelinuxchoice       \e[0m\n"
printf "\e[1;77m  Modified by: @Erzambayu                        \e[0m\n\n"
}

partial() {
if [[ -e $username.txt ]]; then
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Results saved:\e[0m\e[1;77m %s.txt\n" $username
fi
}

check_connection() {
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Checking internet connection...\e[0m\n"
wget -q --spider https://google.com
if [ $? -ne 0 ]; then
    printf "\e[1;91m[\e[0m\e[1;77m!\e[0m\e[1;91m] Error: No internet connection\e[0m\n"
    exit 1
fi
}

check_site() {
    platform=$1
    url=$2
    pattern=$3
    invert=$4
    
    printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] %s: \e[0m" "$platform"
    
    response=$(curl -s -i "$url" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"' -m 10)
    
    if [ -z "$response" ]; then
        printf "\e[1;93mTimeout or error!\e[0m\n"
        return
    fi
    
    if [ "$invert" = "true" ]; then
        check=$(echo "$response" | grep -o "$pattern"; echo $?)
        if [[ $check == *'1'* ]]; then
            printf "\e[1;92m Found!\e[0m %s\n" "$url"
            printf "%s\n" "$url" >> $username.txt
        else
            printf "\e[1;93mNot Found!\e[0m\n"
        fi
    else
        check=$(echo "$response" | grep -o "$pattern"; echo $?)
        if [[ $check == *'0'* ]]; then
            printf "\e[1;93mNot Found!\e[0m\n"
        else
            printf "\e[1;92m Found!\e[0m %s\n" "$url"
            printf "%s\n" "$url" >> $username.txt
        fi
    fi
}

scanner() {
    read -p $'\e[1;92m[\e[0m\e[1;77m?\e[0m\e[1;92m] Input Username:\e[0m ' username

    if [[ -z "$username" ]]; then
        printf "\e[1;91m[\e[0m\e[1;77m!\e[0m\e[1;91m] You must enter a username\e[0m\n"
        scanner
        return
    fi

    if [[ -e $username.txt ]]; then
        printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Removing previous file:\e[0m\e[1;77m %s.txt\n" $username
        rm -rf $username.txt
    fi
    
    printf "\n"
    printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Checking username\e[0m\e[1;77m %s\e[0m\e[1;92m on: \e[0m\n" $username
    
    # Modern Social Media Platforms - 2025
    
    # Instagram - Fixed
    check_site "Instagram" "https://www.instagram.com/$username" "Sorry, this page isn't available" "true"
    
    # TikTok - Fixed
    check_site "TikTok" "https://www.tiktok.com/@$username" "Couldn't find this account" "true"
    
    # Twitter/X - Fixed
    check_site "Twitter/X" "https://x.com/$username" "This account doesn't exist" "true"
    
    # Facebook - Fixed
    check_site "Facebook" "https://www.facebook.com/$username" "page isn't available" "true"
    
    # LinkedIn
    check_site "LinkedIn" "https://www.linkedin.com/in/$username" "page not found" "true"
    
    # GitHub - Fixed
    check_site "GitHub" "https://github.com/$username" "404 Not Found" "true"
    
    # YouTube
    check_site "YouTube" "https://www.youtube.com/@$username" "404 Not Found" "true"
    
    # Reddit
    check_site "Reddit" "https://www.reddit.com/user/$username" "Sorry, nobody on Reddit goes by that name" "true"
    
    # Pinterest
    check_site "Pinterest" "https://www.pinterest.com/$username" "Oops! We couldn't find that page" "true"
    
    # Twitch
    check_site "Twitch" "https://www.twitch.tv/$username" "Sorry. Unless you've got a time machine, that content is unavailable" "true"
    
    # Medium
    check_site "Medium" "https://medium.com/@$username" "404" "true"
    
    # Tumblr
    check_site "Tumblr" "https://$username.tumblr.com" "There's nothing here" "true"
    
    # Snapchat
    check_site "Snapchat" "https://www.snapchat.com/add/$username" "cannot find the page you're looking for" "true"
    
    # Telegram
    check_site "Telegram" "https://t.me/$username" "If you have Telegram, you can contact" "false"
    
    # Threads
    check_site "Threads" "https://www.threads.net/@$username" "Page not found" "true"
    
    # Discord
    check_site "Discord" "https://discord.com/users/$username" "Not Found" "true"
    
    # Mastodon - Main instance
    check_site "Mastodon" "https://mastodon.social/@$username" "The page you are looking for isn't here" "true"
    
    # Substack
    check_site "Substack" "https://$username.substack.com" "Page not found" "true"
    
    # Patreon
    check_site "Patreon" "https://www.patreon.com/$username" "Page not found" "true"
    
    # OnlyFans
    check_site "OnlyFans" "https://onlyfans.com/$username" "Sorry, this page is not available" "true"
    
    # Spotify
    check_site "Spotify" "https://open.spotify.com/user/$username" "Couldn't find that page" "true"
    
    # SoundCloud
    check_site "SoundCloud" "https://soundcloud.com/$username" "We can't find that user" "true"
    
    # Behance
    check_site "Behance" "https://www.behance.net/$username" "Oops! We can't find that page" "true"
    
    # Dribbble
    check_site "Dribbble" "https://dribbble.com/$username" "Page not found" "true"
    
    # Roblox - Fixed
    check_site "Roblox" "https://www.roblox.com/user.aspx?username=$username" "Page cannot be found or no longer exists" "true"
    
    # Steam
    check_site "Steam" "https://steamcommunity.com/id/$username" "The specified profile could not be found" "true"
    
    # Fiverr
    check_site "Fiverr" "https://www.fiverr.com/$username" "not found" "true"
    
    # Etsy
    check_site "Etsy" "https://www.etsy.com/shop/$username" "Sorry, this shop is currently unavailable" "true"
    
    # Ko-fi
    check_site "Ko-fi" "https://ko-fi.com/$username" "404" "true"
    
    # Buy Me a Coffee
    check_site "BuyMeACoffee" "https://www.buymeacoffee.com/$username" "Page not found" "true"
    
    # DeviantArt
    check_site "DeviantArt" "https://www.deviantart.com/$username" "DeviantArt - 404" "true"
    
    # Flickr
    check_site "Flickr" "https://www.flickr.com/people/$username" "Oops! We couldn't find that page" "true"
    
    # Quora
    check_site "Quora" "https://www.quora.com/profile/$username" "Page Not Found" "true"
    
    # Bluesky
    check_site "Bluesky" "https://bsky.app/profile/$username" "Not found" "true"
    
    printf "\n\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Search completed!\e[0m\n"
    printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Results saved in:\e[0m\e[1;77m %s.txt\e[0m\n" $username
}

# Main execution
clear
check_connection
banner
scanner
