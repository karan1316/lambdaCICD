import json

def lambda_handler(event, context):
    print("Received event: " + json.dumps(event, indent=2))
    
    # Example processing
    message = 'Hello from Lambda & from local and deployed from GitHub Actions!'
    
    # Return a response
    return {
        'statusCode': 200,
        'body': json.dumps({
            'message': message
        })
    }
