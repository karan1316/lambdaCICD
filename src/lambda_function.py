import boto3
ec2 = boto3.client('ec2')

def lambda_handler(event, context):
    resp = ec2.describe_instances() 
    running_instances = 0 
    terminated_instances = 0
    # print(resp) 
    if 'Reservations' in resp: 
        if len(resp['Reservations']) > 0:
            for rsv in resp['Reservations']:
                for instance in rsv['Instances']:
                    id = instance['InstanceId']
                    ec2_state = instance['State']['Name']
                    # print(ec2_state)
                    if ec2_state=='running':
                        print(f"EC2 Instance having ID : {id} is running!!!")
                        running_instances+=1
                    elif ec2_state=='terminated':
                        print(f"EC2 Instance having ID : {id} is terminated!!!")
                        terminated_instances+=1
        else:
            print("There are no running EC2 Instances!!!")
    else:
        print("There are no running EC2 Instances!!!")
    print(f"Total running instances: {running_instances}")
    print(f"Total EC2 Instances in terminated state: {terminated_instances}")

    
# import json

# def lambda_handler(event, context):
#     print("Received event: " + json.dumps(event, indent=2))
    
#     # Example processing
#     message = 'Hello from Lambda & from local and deployed from GitHub Actions!'
    
#     # Return a response
#     return {
#         'statusCode': 200,
#         'body': json.dumps({
#             'message': message
#         })
#     }
