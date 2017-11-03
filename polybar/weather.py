#!/usr/bin/env python

import json
import urllib
import urllib.parse
import urllib.request
import os


def get_ip():
    return urllib.request.urlopen('http://whatismyip.akamai.com/').read()


def get_city(ip):
    response = urllib.request.urlopen('http://freegeoip.net/json/{}'.format(ip)).read()
    data = json.loads(response)

    return data.get('city')


def main():
    try:
        city = get_city(get_ip())
    except Exception as e:
        city = 'Brussels'
        # with open(os.path.join(
        #         os.path.expanduser("~"),
        #         '.config',
        #         'polybar',
        #         'city')) as f:
        #     city = f.readline().strip()
    try:
        with open(os.path.join(
                os.path.expanduser("~"),
                '.config',
                'polybar',
                'weather.json')) as f:
            api_key = json.load(f)['api_key']
    except Exception:
        return 'Weather unavailable'

    try:
        data = urllib.parse.urlencode({'q': city, 'appid': api_key})
        weather = json.loads(urllib.request.urlopen(
            'http://api.openweathermap.org/data/2.5/weather?' + data)
            .read())
        desc = weather['weather'][0]['description'].capitalize()
        temp = int(float(weather['main']['temp']) - 272.15)
        name = weather['name']
        return '{}, {}, {}°C'.format(name, desc, temp)
    except Exception:
        return 'Weather unavailable'


if __name__ == "__main__":
    print(main())
