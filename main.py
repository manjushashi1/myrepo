import requests
url = "https://preprocessingcloudrun-ko7bzclbcq-uc.a.run.app/"
headers = {
        # 'Authorization': 'Bearer {}'.format(id_token),
        'content-type': 'application/json',
        'Accept': 'application/json'
    }
#response = requests.post(url, data=json.dumps(data), headers=headers)

def hello_gcs(event, context):
    """Triggered by a change to a Cloud Storage bucket.
    Args:
         event (dict): Event payload.
         context (google.cloud.functions.Context): Metadata for the event.
    """
    file = event
    print(f"Processing file: {file['name']}.")
    response = requests.get(url)
