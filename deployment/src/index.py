#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
from urllib import request

def lambda_handler(event, context):
    # event.queryStringParameters
    # event.body
    ret = {
        'isBase64Encoded': False,
        'statusCode': 200,
        'headers': {"Content-Type": "application/json", "Access-Control-Allow-Origin":"*"},
        'body': '{"message": "Hello from AWS Lambda"}'
    }
    url = 'http://172.31.33.84:59980/expiring_items/'
    req = request.Request(url)
    with request.urlopen(req) as res:
        body = res.read()
        print(body)
        ret['body'] = body.decode('utf-8')

    return ret

if __name__ == "__main__":
    with open('./test.json', 'r') as f:
        lambda_handler(json.load(f), None)

