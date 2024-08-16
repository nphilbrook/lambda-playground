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

body = {
  "data": {
    "attributes": {
      "name": "lambda-from-api",
      "working-directory": "",
      "vcs-repo": {
        "identifier": "nphilbrook/terraform-aws-function-with-api",
        "github-app-installation-id": "ghain-ieieBWKoaGhWE3rE",
        "branch": "0.0.4",
      },
    },
      "relationships": {
      "project": {
        "data": {
          "type": "projects",
          "id": "prj-fH8F6t8pcX2zYQGY"
        }
      }
    },
    "type": "workspaces"
  }
}

resp = requests.post(f"https://{host}/api/v2/organizations/philbrook/workspaces", headers=headers, json=body)

resp.raise_for_status()

attributes = resp.json()

# pprint.pprint(attributes)

ws_id = attributes['data']['id']

body = {
  "data": {
    "type":"vars",
    "attributes": {
      "key":"basename",
      "value":"example-from-api",
      "category":"terraform",
      "hcl": False,
      "sensitive": False
    }
  }
}

var_resp = requests.post(f"https://{host}/api/v2/workspaces/{ws_id}/vars", headers=headers, json=body)
var_resp.raise_for_status()

body = {
  "data": {
    "attributes": {
      "message": "triggered from API"
    },
    "type":"runs",
    "relationships": {
      "workspace": {
        "data": {
          "type": "workspaces",
          "id": ws_id
        }
      }
    }
  }
}

run_resp = requests.post(f"https://{host}/api/v2/runs", headers=headers, json=body)
run_resp.raise_for_status()
