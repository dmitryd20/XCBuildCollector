from os.path import *
import json
import enum
from typing import Any


# Config
class ConfigKey(enum.Enum):
    derived_data_path = "derived_data_path"
    user = "user"
    white_list = "white_list"
    server_url = "server_url"


def read_config(key: ConfigKey) -> Any:
    return read_key(key.value, file="config.json")


# Start info
class StartInfoKey(enum.Enum):
    is_incremental = "is_incremental"
    start_time = "start_time"


def read_start_info(key: StartInfoKey) -> Any:
    return read_key(key.value, file="resources/start_info.json")


def save_start_info(is_incremental: bool, start_time: int):
    with open("resources/start_info.json", 'w') as start_info_file:
        json.dump({
            "is_incremental": is_incremental,
            "start_time": start_time
        }, start_info_file)


# Common
def read_key(key: str, file: str) -> Any:
    try:
        return read_dict(file)[key]
    except KeyError:
        return None


def read_dict(file: str) -> dict:
    if not isfile(file):
        return dict()
    with open(file, 'r') as dict_file:
        return json.load(dict_file)
