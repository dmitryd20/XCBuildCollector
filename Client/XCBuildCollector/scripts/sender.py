import requests
import json
from configs import *


def send_results(results):
    try:
        response = requests.post(
            url=read_config(ConfigKey.server_url) + "/events/new",
            headers={
                "Content-Type": "application/json",
            },
            data=json.dumps(results)
        )
        return response.status_code
    except requests.exceptions.RequestException:
        print('HTTP Request failed')
