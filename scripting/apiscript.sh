#!/bin/bash


TOKEN="a019d87c2368e0bd7ac14aeaa7e832e9f444f7b4b6e0771afcba7eabe2c0d242"

VALUE=$(curl -sH "Authorization: Bearer $TOKEN" "https://api.intra.42.fr/v2/users/$1" | tr -d '{}')

echo
if [ -z "$VALUE" ] || [ -z "$1" ]
then
      echo "Incorrect username or no username specified."
      echo "usage: ./apiscript.sh intra_username"
      exit 2
fi

echo -n "Name: "
echo $VALUE | grep -Po '"displayname":.*?[^\\]",' | tr -d '",' | cut -f2 -d":"
echo -n "Email: "
echo $VALUE | grep -Po '"email":.*?[^\\]",' | tr -d '",' | cut -f2 -d":"
echo -n "Phone number: "
echo $VALUE | grep -Po '"phone":.*?[^\\]",' | tr -d '",' | cut -f2 -d":"
echo -n "Location: "
echo $VALUE | grep -Po '"location":.*?[^\\]",' | tr -d '",' | cut -f2 -d":"
echo -n "Correction Points: "
echo $VALUE | grep -Po '"correction_point":.*?[^\\]",' | tr -d '",' | grep -oP '(?<=:).*?(?=p)'
echo -n "Wallet: "
echo $VALUE | grep -Po '"wallet":.*?[^\\]",' | head -1 | tr -d '",' | cut -f2 -d":" | cut -f1 -d"g" | awk '{print $1"₳"}'
echo -n "Level: "
echo $VALUE | grep -Po '"level":.*?[^\\]",' | head -1 | tr -d '",' | cut -f2 -d":" | cut -f1 -d"s"

python -mwebbrowser https://cdn.intra.42.fr/users/$1.jpg

#$VALUE | grep -Po '"image_url":.*?[^\\]",' | tr -d '",' | cut -d: -f2-
#grep -Po '"text":.*?[^\\]",'
