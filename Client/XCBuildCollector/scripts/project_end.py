#!/usr/bin/python

from common import *
from configs import *
from sender import *
import time
import os
import subprocess
import re


def get_device_info():
    try:
        items = subprocess \
            .check_output(['sysctl',
                           '-n',
                           'machdep.cpu.brand_string',
                           'hw.model',
                           'hw.memsize']) \
            .decode('utf-8') \
            .split('\n')
        info = " | ".join([i for i in items if i])
    except:
        info = "Unknown"
    return info


def get_git_user():
    try:
        raw_git_user = subprocess.check_output(['git', 'config', 'user.email'])[:-1]
        git_user = raw_git_user.decode('UTF-8')
    except:
        git_user = "Unknown"
    return git_user


def is_build_successful() -> bool:
    return "Succeeded" in os.environ.get("IDEAlertMessage", "No message")


def is_project_allowed() -> bool:
    white_list = read_config(ConfigKey.white_list)
    if white_list is None:
        return True
    for pattern in white_list:
        if re.match(pattern.strip(), get_project_name().strip()):
            return True
    return False


end_milliseconds = int(round(time.time() * 1000))
duration = end_milliseconds - read_start_info(StartInfoKey.start_time)

results = {
    "user": read_config(ConfigKey.user) or get_git_user(),
    "device": get_device_info(),
    "project": get_project_name(),
    "started": read_start_info(StartInfoKey.start_time),
    "duration": duration,
    "is_successful": is_build_successful(),
    "is_incremental": read_start_info(StartInfoKey.is_incremental)
}

if is_project_allowed():
    send_results(results)
