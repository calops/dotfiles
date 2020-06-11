#!/usr/bin/python3
# -*_ coding: utf-8 -*-
# ~/.local/bin/now_playing

import json
import signal
import subprocess
import sys
from pathlib import Path
from time import sleep

import websocket

# TODO: change these to args?
MAX_LEN = 60
MODULE_PLAYING = "now_playing"
MODULE_LIKED = "like_song"
MODULE_DISLIKED = "dislike_song"
NOW_PLAYING_FILE = Path("~/.now_playing").expanduser()
SONG_LIKED_FILE = Path("~/.song_liked").expanduser()
SONG_DISLIKED_FILE = Path("~/.song_disliked").expanduser()

now_playing_data = {
    'state': ' '
}


def handle_message(ws, message):
    global now_playing_data
    msg = json.loads(message)

    if msg['channel'] == 'playState':
        now_playing_data['state'] = msg['payload']
        send_curr_song()

    elif msg['channel'] == 'track':
        now_playing_data.update(msg["payload"])
        send_curr_song()

    elif msg['channel'] == 'rating':
        now_playing_data.update(msg["payload"])
        send_rating()


def truncate_title_if_needed():
    # 7 hardcoded chars
    str_len = 7 + sum(
        len(v) for k, v in now_playing_data.items() if k in ["artist", "title"]
    )

    if str_len > MAX_LEN:
        # 3 chars for ellipsis
        to_remove = MAX_LEN - str_len - 3
        now_playing_data["title"] = now_playing_data["title"][:to_remove] + "..."


def send_rating():
    now_playing_data["liked"] = " " if now_playing_data["liked"] else " "
    now_playing_data["disliked"] = " " if now_playing_data["disliked"] else " "
    SONG_LIKED_FILE.write_text(now_playing_data["liked"])
    SONG_DISLIKED_FILE.write_text(now_playing_data["disliked"])
    send_polybar(2)


def send_curr_song():
    now_playing_data['state'] = ' ' if now_playing_data['state'] else ' '

    truncate_title_if_needed()
    msg = "{artist} - {title} {state}".format(**now_playing_data)
    NOW_PLAYING_FILE.write_text(msg)
    send_polybar(2)


def clear_song():
    send_polybar(1)


def send_polybar(hook):
    subprocess.call(["polybar-msg", "hook", MODULE_PLAYING, str(hook)])
    subprocess.call(["polybar-msg", "hook", MODULE_LIKED, str(hook)])
    subprocess.call(["polybar-msg", "hook", MODULE_DISLIKED, str(hook)])


def signal_handler(sig, frame):
    clear_song()
    sys.exit(0)


def main():
    print("started")
    while True:
        signal.signal(signal.SIGTERM, signal_handler)
        ws = websocket.WebSocketApp("ws://localhost:5672", on_message=handle_message)
        ws.run_forever()
        print("clear_song")
        clear_song()
        sleep(5)


if __name__ == "__main__":
    main()
