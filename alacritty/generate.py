#!/usr/bin/env python

import yaml
import socket

if __name__ == '__main__':
    with open("./alacritty_template.yml", "r") as f:
        data = yaml.safe_load(f)

    hostname = socket.gethostname()
    if hostname == "panama":
        data["font"]["size"] = 6

    with open("./alacritty.yml", "w") as f:
        yaml.safe_dump(data, f)
