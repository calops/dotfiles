#!/usr/bin/python3
# -*_ coding: utf-8 -*-

import json
from pathlib import Path
from subprocess import call

import sys
import websocket

config_location = Path("~/.config/gpmdp_api").expanduser()


def like_song(ws, like):
    thumbs_up = {"namespace": "rating", "method": "setRating", "arguments": [5 if like == "like" else 1]}

    ws.send(json.dumps(thumbs_up))
    call(["notify-send", "Liked song on GPMDP"])


def get_saved_code():
    if config_location.exists():
        return config_location.read_text()


def get_code(ws):
    code = get_saved_code()

    if not code:
        code = authenticate(ws)
    return code


def save_code(code):
    config_location.write_text(code)


def authenticate(ws):
    connect(ws)
    code = input("Please input code: ")
    res = connect(ws, code)
    save_code(res)
    return res


def connect(ws, code=None):
    connect = {"namespace": "connect", "method": "connect", "arguments": ["Song Liker"]}

    if code is not None:
        connect["arguments"].append(str(code))

    ws.send(json.dumps(connect))

    # we only get a response while authenticating
    if code is None or len(code) == 4:
        return get_response(ws, "connect")["payload"]


def get_response(ws, channel):
    for res in ws:
        if '"channel":"{0}"'.format(channel) in res:
            return json.loads(res)


def main(like):
    ws = websocket.create_connection("ws://localhost:5672")
    code = get_code(ws)
    connect(ws, code)
    like_song(ws, like)
    ws.close()


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "like")
