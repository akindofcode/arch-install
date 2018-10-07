#!/bin/sh

get_icon() {
    case $1 in
        01d) icon="";;
        01n) icon="";;
        02d) icon="";;
        02n) icon="";;
        03*) icon="";;
        04*) icon="";;
        09d) icon="";;
        09n) icon="";;
        10d) icon="";;
        10n) icon="";;
        11d) icon="";;
        11n) icon="";;
        13d) icon="";;
        13n) icon="";;
        50d) icon="";;
        50n) icon="";;
        *) icon="a";
    esac

    echo $icon
}

CITY="3129135"
API_KEY="52c37ed729a408cd4e3647aa39422e71"
UNITS="Metric"
UNIT_KEY="º"


if [ ! -z $CITY ]; then 
    weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?appid=$API_KEY&id=$CITY&units=$UNITS")
    #echo $weather
    # weather=$(curl -sf "http://api.openweathermap.org/data/2.5/forecast?APPID=$KEY&id=$CITY&units=$UNITS&cnt=1")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

    if [ ! -z "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?appid=$API_KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
    fi
fi

if [ ! -z "$weather" ]; then
    weather_desc=$(echo "$weather" | jq -r ".weather[0].description")
    weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
    weather_icon=$(echo "$weather" | jq -r ".weather[].icon")

    #echo "$(get_icon "$weather_icon")" "$weather_desc", "$weather_temp$SYMBOL""$UNIT_KEY"
    #echo "$(get_icon "$weather_icon")" "$weather_temp$SYMBOL""$UNIT_KEY" 
    echo "$(get_icon $weather_icon)" "$weather_temp$SYMBOL""$UNIT_KEY"
fi