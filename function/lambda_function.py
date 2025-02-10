# ---
import boto3, botocore.exceptions
import hashlib
import hmac
import json
import os
import urllib3
from datetime import datetime, timezone, timedelta


def lambda_handler(event, context):
    """Main Lambda invocation function."""
    resp = ""
    if 'norf' in event:
        resp += f"norf={event['norf']},"
    resp += f"FOO={os.environ['FOO']},"
    print(event["headers"])
    print("\n")
    return {"statusCode": 200, "body": resp}
