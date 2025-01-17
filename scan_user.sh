#!/bin/bash
figlet SCAN-USER
echo "Autor: Eduardo Amaral - eduardo4maral@protonmail.com"
echo "You Tube : https://www.youtube.com/faciltech"
echo "github   : https://github.com/faciltech"
echo "Linkedin : https://www.linkedin.com/in/eduardo-a-02194451/"
echo "Uso: ./scan-user.sh"

trap 'printf "\n";partial;exit 1' 2
echo ""

#### Condicao para criar um novo projeto caso este nome ja exista

while true; do
read -p $'\e[1;92m[\e[0m\e[1;77m?\e[0m\e[1;92m] Escolha o nome do projeto:\e[0m ' projeto
if [[ -e $projeto ]]; then
	echo "[-] Já existe um projeto com esse nome."
	
elif [[ -z $projeto ]];then
	echo "[-] O nome do projeto não pode ser vazio."
	
else
	mkdir $projeto
	break
fi
done


### Condicao para sanitizar o email (validar), ou deixar em branco

while true; do
read -p $'\e[1;92m[\e[0m\e[1;77m?\e[0m\e[1;92m] Entre com um Email:\e[0m ' email
if [[ "$email" =~ [a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4} ]] || [[ -z "$email" ]]
then
    break;
else
    echo "[+] Por favor entre com um email válido ou deixe em branco."
fi
done

#### Inicia a verificação de redes sociais

echo ""
echo "#################################"
echo "## VERIFICANDO REDES SOCIAIS...##"
echo "#################################"
partial() {

if [[ -e $projeto/$username.txt ]]; then
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Saved:\e[0m\e[1;77m %s.txt\n" $projeto/$username
fi


}
scanner() {

read -p $'\e[1;92m[\e[0m\e[1;77m?\e[0m\e[1;92m] Entre com um Username:\e[0m ' username

if [[ -e /$projeto/$username.txt ]]; then
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Removendo arquivo:\e[0m\e[1;77m %s.txt" $username
rm -rf /$projeto/$username.txt
fi
printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Verificando username\e[0m\e[1;77m %s\e[0m\e[1;92m on: \e[0m\n" $username

## TIKTOK

check_tiktok=$(curl -s "https://www.tiktok.com/@$username" -L -H "Accept-Language: en" | grep -o '"id":"'; echo $?)
printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] TikTok: \e[0m"

if [[ $check_tiktok == *'0'* ]]; then
printf "\e[1;92m Encontrado!\e[0m https://www.tiktok.com/@%s\n" $username
printf "https://www.tiktok.com/@%s\n" $username > $projeto/$username.txt
elif [[ $check_tiktok == *'1'* ]]; then
printf "\e[1;93mNão Encontrado!\e[0m\n"
fi



## INSTAGRAM

check_insta=$(curl -s -H "Accept-Language: en" "https://www.instagram.com/$username" -L | grep -o 'The link you followed may be broken'; echo $?)
printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Instagram: \e[0m"
if [[ $check_insta == *'1'* ]]; then
printf "\e[1;92m Encontrado!\e[0m https://www.instagram.com/%s\n" $username
printf "https://www.instagram.com/%s\n" $username > $projeto/$username.txt
elif [[ $check_insta == *'0'* ]]; then
printf "\e[1;93mNão Encontrado!\e[0m\n"
fi

## FACEBOOK

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Facebook: \e[0m"
check_face=$(curl -s "https://www.facebook.com/$username" -L -H "Accept-Language: en" | grep -o 'not found'; echo $?)


if [[ $check_face == *'1'* ]]; then
printf "\e[1;92m Encontrado!\e[0m https://www.facebook.com/%s\n" $username
printf "https://www.facebook.com/%s\n" $username >> $projeto/$username.txt
elif [[ $check_face == *'0'* ]]; then
printf "\e[1;93mNão Encontrado!\e[0m\n"
fi
## TWITTER 

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Twitter: \e[0m"
check_twitter=$(curl -s "https://www.twitter.com/$username" -L -H "Accept-Language: en" | grep -o 'page doesn’t exist'; echo $?)


if [[ $check_twitter == *'1'* ]]; then
printf "\e[1;92m Encontrado!\e[0m https://www.twitter.com/%s\n" $username
printf "https://www.twitter.com/%s\n" $username >> $projeto/$username.txt
elif [[ $check_twitter == *'0'* ]]; then
printf "\e[1;93mNão Encontrado!\e[0m\n"
fi

## YOUTUBE

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] YouTube: \e[0m"
check_youtube=$(curl -s "https://www.youtube.com/$username" -L -H "Accept-Language: en" | grep -o 'Not Found'; echo $?)


if [[ $check_youtube == *'1'* ]]; then
printf "\e[1;92m Encontrado!\e[0m https://www.youtube.com/%s\n" $username
printf "https://www.youtube.com/%s\n" $username >> $projeto/$username.txt
elif [[ $check_youtube == *'0'* ]]; then
printf "\e[1;93mNão Encontrado!\e[0m\n"
fi

## BLOGGER

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Blogger: \e[0m"
check=$(curl -s "https://$username.blogspot.com" -L -H "Accept-Language: en" -i | grep -o 'HTTP/2 404'; echo $?)


if [[ $check == *'1'* ]]; then
printf "\e[1;92m Encontrado!\e[0m https://%s.blogspot.com\n" $username
printf "https://%s.blogspot.com\n" $username >> $projeto/$username.txt
elif [[ $check == *'0'* ]]; then
printf "\e[1;93mNão Encontrado!\e[0m\n"
fi


## GLOOGLE PLUS

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] GooglePlus: \e[0m"
check=$(curl -s "https://plus.google.com/+$username/posts" -L -H "Accept-Language: en" -i | grep -o 'HTTP/2 404' ; echo $?)


if [[ $check == *'1'* ]]; then
printf "\e[1;92m Encontrado!\e[0m https://plus.google.com/+%s/posts\n" $username
printf "https://plus.google.com/+%s/posts\n" $username >> $projeto/$username.txt
elif [[ $check == *'0'* ]]; then
printf "\e[1;93mNão Encontrado!\e[0m\n"
fi

## REDDIT

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Reddit: \e[0m"
check1=$(curl -s -i "https://www.reddit.com/user/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | head -n1 | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://www.reddit.com/user/%s\n" $username
printf "https://www.reddit.com/user/%s\n" $username >> $projeto/$username.txt
fi

## WORDPRESS

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Wordpress: \e[0m"
check1=$(curl -s -i "https://$username.wordpress.com" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o 'Do you want to register' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://%s.wordpress.com\n" $username
printf "https://%s.wordpress.com\n" $username >> $projeto/$username.txt
fi

## PINTEREST

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Pinterest: \e[0m"
check1=$(curl -s -i "https://www.pinterest.com/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o '?show_error' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://www.pinterest.com/%s\n" $username
printf "https://www.pinterest.com/%s\n" $username >> $projeto/$username.txt
fi

## ONLYFANS
printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Onlyfans: \e[0m"
check1=$(curl -s -i "https://www.onlyfans.com/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o '?show_error' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://www.onlyfans.com/%s\n" $username
printf "https://www.onlyfans.com/%s\n" $username >> $projeto/$username.txt
fi

## GITHUB

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] GitHub: \e[0m"
check1=$(curl -s -i "https://www.github.com/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://www.github.com/%s\n" $username
printf "https://www.github.com/%s\n" $username >> $projeto/$username.txt
fi

## TUMBLR

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Tumblr: \e[0m"
check1=$(curl -s -i "https://$username.tumblr.com" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://%s.tumblr.com\n" $username
printf "https://%s.tumblr.com\n" $username >> $projeto/$username.txt
fi

## FLICKR

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Flickr: \e[0m"
check1=$(curl -s -i "https://www.flickr.com/people/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o 'Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://www.flickr.com/photos/%s\n" $username
printf "https://www.flickr.com/photos/%s\n" $username >> $projeto/$username.txt
fi

## STEAM

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Steam: \e[0m"
check1=$(curl -s -i "https://steamcommunity.com/id/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o 'The specified profile could not be found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://steamcommunity.com/id/%s\n" $username
printf "https://steamcommunity.com/id/%s\n" $username >> $projeto/$username.txt
fi

## VIMEO

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Vimeo: \e[0m"
check1=$(curl -s -i "https://vimeo.com/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://vimeo.com/%s\n" $username
printf "https://vimeo.com/%s\n" $username >> $projeto/$username.txt
fi


## SOUNDCLOUD

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] SoundCloud: \e[0m"
check1=$(curl -s -i "https://soundcloud.com/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o '404 Not Found'; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://soundcloud.com/%s\n" $username
printf "https://soundcloud.com/%s\n" $username >> $projeto/$username.txt
fi

## MEDIUM

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Medium: \e[0m"
check1=$(curl -s -i "https://medium.com/@$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://medium.com/@%s\n" $username
printf "https://medium.com/@%s\n" $username >> $projeto/$username.txt
fi

## VK

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] VK: \e[0m"
check1=$(curl -s -i "https://vk.com/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://vk.com/%s\n" $username
printf "https://vk.com/%s\n" $username >> $projeto/$username.txt
fi

## ABOUT.ME

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] About.me: \e[0m"
check1=$(curl -s -i "https://about.me/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://about.me/%s\n" $username
printf "https://about.me/%s\n" $username >> $projeto/$username.txt
fi


## SLIDESHARE

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] SlideShare: \e[0m"
check1=$(curl -s -i "https://slideshare.net/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://slideshare.net/%s\n" $username
printf "https://slideshare.net/%s\n" $username >> $projeto/$username.txt
fi

## FOTOLOG

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Fotolog: \e[0m"
check1=$(curl -s -i "https://fotolog.com/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://fotolog.com/%s\n" $username
printf "https://fotolog.com/%s\n" $username >> $projeto/$username.txt
fi


## SPOTIFY

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Spotify: \e[0m"
check1=$(curl -s -i "https://open.spotify.com/user/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://open.spotify.com/user/%s\n" $username
printf "https://open.spotify.com/user/%s\n" $username >> $projeto/$username.txt
fi

## SCRIDB

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Scribd: \e[0m"
check1=$(curl -s -i "https://www.scribd.com/$username" -H "Accept-Language: en" -L | grep -o 'show_404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://www.scribd.com/%s\n" $username
printf "https://www.scribd.com/%s\n" $username >> $projeto/$username.txt
fi

## BADOO

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Badoo: \e[0m"
check1=$(curl -s -i "https://www.badoo.com/en/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://www.badoo.com/en/%s\n" $username
printf "https://www.badoo.com/en/%s\n" $username >> $projeto/$username.txt
fi


## CODECADEMY

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Codecademy: \e[0m"
check1=$(curl -s -i "https://www.codecademy.com/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://www.codecademy.com/%s\n" $username
printf "https://www.codecademy.com/%s\n" $username >> $projeto/$username.txt
fi

## GRAVATAR

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Gravatar: \e[0m"
check1=$(curl -s -i "https://en.gravatar.com/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://en.gravatar.com/%s\n" $username
printf "https://en.gravatar.com/%s\n" $username >> $projeto/$username.txt
fi

## PASTEBIN

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Pastebin: \e[0m"
check1=$(curl -s -i "https://pastebin.com/u/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o 'location: /index' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://pastebin.com/u/%s\n" $username
printf "https://pastebin.com/u/%s\n" $username >> $projeto/$username.txt
fi

## FOURSQUARE

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Foursquare: \e[0m"
check1=$(curl -s -i "https://foursquare.com/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://foursquare.com/%s\n" $username
printf "https://foursquare.com/%s\n" $username >> $projeto/$username.txt
fi

## ROBLOX

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Roblox: \e[0m"
check1=$(curl -s -i "https://www.roblox.com/user.aspx?username=$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://www.roblox.com/user.aspx?username=%s\n" $username
printf "https://www.roblox.com/user.aspx?username=%s\n" $username >> $projeto/$username.txt
fi


## CANVA

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Canva: \e[0m"
check1=$(curl -s -i "https://www.canva.com/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404 ' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://www.canva.com/%s\n" $username
printf "https://www.canva.com/%s\n" $username >> $projeto/$username.txt
fi


## TRIPADVISOR

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] TripAdvisor: \e[0m"
check1=$(curl -s -i "https://tripadvisor.com/members/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://tripadvisor.com/members/%s\n" $username
printf "https://tripadvisor.com/members/%s\n" $username >> $projeto/$username.txt
fi


## WIKIPEDIA

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Wikipedia: \e[0m"
check1=$(curl -s -i "https://www.wikipedia.org/wiki/User:$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://www.wikipedia.org/wiki/User:%s\n" $username
printf "https://www.wikipedia.org/wiki/User:%s\n" $username >> $projeto/$username.txt
fi

## HACKERNEWS

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] HackerNews: \e[0m"
check1=$(curl -s -i "https://news.ycombinator.com/user?id=$username" -H "Accept-Language: en" -L | grep -o 'No such user' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://news.ycombinator.com/user?id=%s\n" $username
printf "https://news.ycombinator.com/user?id=%s\n" $username >> $projeto/$username.txt
fi


# EBAY

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Ebay: \e[0m"
check1=$(curl -s -i "https://www.ebay.com/usr/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404\|404 Not Found\|eBay Profile - error' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://www.ebay.com/usr/%s\n" $username
printf "https://www.ebay.com/usr/%s\n" $username >> $projeto/$username.txt
fi

## SLACK

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Slack: \e[0m"
check1=$(curl -s -i "https://$username.slack.com" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404\|404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://%s.slack.com\n" $username
printf "https://%s.slack.com\n" $username >> $projeto/$username.txt
fi


## ELLO

printf "\e[1;77m[\e[0m\e[1;92m✔\e[0m\e[1;77m] Ello: \e[0m"
check1=$(curl -s -i "https://ello.co/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404\|404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNão Encontrado!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Encontrado!\e[0m https://ello.co/%s\n" $username
printf "https://ello.co/%s\n" $username >> $projeto/$username.txt
fi


partial
}
scanner

#### Inicia a verificação no gravatar por imagens relacionada ao email e faz o download

echo""
echo "##################################"
echo "## VERIFICANDO IMAGEM GRAVATAR...#"
echo "##################################"
hash=$(echo -n $email | md5sum | cut -d" " -f1)
echo ""
echo -e "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] VISUALIZAR FOTO NO NAVEGADOR: \e[0m"
echo https://gravatar.com/avatar/$hash?s=600
echo ""
echo -e "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] BAIXANDO IMAGEM DO PERFIL GRAVATAR: \e[0m" 
curl -s https://gravatar.com/avatar/$hash?s=600 > $projeto/gravatar.jpg
echo -e "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Salvo em: \e[0m\e[1;77m$projeto/gravatar.jpg"
display $projeto/gravatar.jpg&
sleep 3
exit
