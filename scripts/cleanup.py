#!/usr/bin/python3

import json
import requests
import os
import pprint
import secrets
import sys
import time
# import util

host = "app.terraform.io"

with open(f"/home/{os.environ['USER']}/.terraform.d/credentials.tfrc.json") as tf_creds:
    token = json.load(tf_creds)["credentials"][host]["token"]

# print(f"Token is '{token}'")
headers = { "Authorization": f"Bearer {token}",
            "Content-Type": "application/vnd.api+json"}

resp = requests.post(f"https://{host}/api/v2/organizations/philbrook/workspaces/lambda-from-api/actions/safe-delete", headers=headers)
resp.raise_for_status()
