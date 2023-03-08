#!/bin/python
# Download yt sub content en masse using yt-dlp
# Use '-s' to simulate 
import os
from pathlib import Path

sub_list = open("/home/nick/Videos/subs.txt", "r")

for sub in sub_list.readlines():
    name, link = sub.split(",")
    os.system(f'''
        yt-dlp -f mp4 -I "1:5" "{link}" -o "$HOME/Videos/channels/{name}/%(upload_date>%Y-%m-%d)s-%(title)s.%(ext)s"
    ''')
    # Remove extra videos
    channel_dir = Path(f'/home/nick/Videos/channels/{name}/')
    for i, file in enumerate(channel_dir.iterdir()):
        if i > 5:
           print(i, file)
           os.system(f'rm "{file}"') 

