# lambda_function.py

import os
import json
import boto3
import requests

def get_access_token():
    url = f'https://login.microsoftonline.com/{os.environ["TENANT_ID"]}/oauth2/v2.0/token'
    headers = {
        'Content-Type': 'application/x-www-form-urlencoded'
    }
    data = {
        'grant_type': 'client_credentials',
        'client_id': os.environ['CLIENT_ID'],
        'client_secret': os.environ['CLIENT_SECRET'],
        'scope': 'https://graph.microsoft.com/.default'
    }

    response = requests.post(url, headers=headers, data=data)
    return response.json().get('access_token')


def lambda_handler(event, context):
    token = get_access_token()

    headers = {
        'Authorization': f'Bearer {token}'
    }

    site_id = os.environ['SITE_ID']
    drive_id = os.environ['DRIVE_ID']
    folder_path = os.environ['FOLDER_PATH']
    s3_bucket = os.environ['S3_BUCKET']

    # Step 1: List files in the SharePoint folder
    list_url = f'https://graph.microsoft.com/v1.0/sites/{site_id}/drives/{drive_id}/root:/{folder_path}:/children'
    list_response = requests.get(list_url, headers=headers)

    if list_response.status_code != 200:
        return {'error': 'Failed to list files', 'details': list_response.text}

    items = list_response.json().get('value', [])

    s3 = boto3.client('s3')

    saved_files = []
    
    for item in items:
        if 'file' in item:  # skip folders
            file_name = item['name']
            download_url = item['@microsoft.graph.downloadUrl']

            # Download file content
            file_response = requests.get(download_url)
            file_data = file_response.content

            # Upload to S3
            #s3.put_object(Bucket=s3_bucket, Key=file_name, Body=file_data)

            #print(f"Uploaded {file_name} to S3")

            # Save to /tmp folder instead of S3
            file_path = f"/tmp/{file_name}"
            with open(file_path, 'wb') as f:
                f.write(file_data)

            saved_files.append(file_path)
            print(f"Saved {file_name} to {file_path}")

    return {
        'statusCode': 200,
        'body': f'Successfully transferred {len(items)} files.'
    }
