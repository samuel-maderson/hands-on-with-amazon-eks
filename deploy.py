from dotenv import load_dotenv
import subprocess, os, boto3

def get_role_from_cloudformation(stack_name):
    print(f'Stack: {stack_name}')
    # Create a CloudFormation client
    cf_client = boto3.client('cloudformation')

    try:
        # Describe the stack
        response = cf_client.describe_stacks(StackName=stack_name)

        if stack_name == nodegroup_cfn_stack_name:
            cfn_filter = "InstanceRoleARN"
        else:
            cfn_filter = "IamPolicyArn"

        # Check if the stack exists and has outputs
        if 'Stacks' in response and len(response['Stacks']) > 0:
            stack = response['Stacks'][0]
            if 'Outputs' in stack:
                # Iterate through the outputs to find the role
                for output in stack['Outputs']:
                    if output['OutputKey'] == cfn_filter:  # Adjust this key as needed
                        return output['OutputValue']
                
                print(f"No RoleArn output found in stack {stack_name}")
            else:
                print(f"No outputs found in stack {stack_name}")
        else:
            print(f"Stack {stack_name} not found")

    except Exception as e:
        print(f"An error occurred while retrieving role from CloudFormation: {str(e)}")

    return None


def run_bash_command(command, script_name):
    try:
        
        if script_name == "chapter-1.sh":
            print("Waiting for EKS to be ready...")
            print("This may take a few minutes...")

            result = subprocess.run(['/bin/bash', '-c', command])

        else:
            result = subprocess.run(['/bin/bash', '-c', command],
                                    stdout=subprocess.DEVNULL,
                                    stderr=subprocess.DEVNULL,
                                    check=True
                                )
        
    except subprocess.CalledProcessError as e:
        # If there's an error, print the error message
        print("An error occurred while running the command:")
        print(e.stderr)



if __name__ == "__main__":

    load_dotenv()

    # # variables
    # scripts_dir = "scripts-by-chapter"
    nodegroup_cfn_stack_name = os.getenv("NODEGROUP_CFN_STACK_NAME")
    alb_policy_cfn_stack_name = os.getenv("ALB_POLICY_CFN_STACK_NAME")
    # scripts = os.getenv("SCRIPTS_LIST").split(" ")

    # for script in scripts:
    #     print(f"Running: {script}")
    #     # Install basics dependencies & Deploy EKS
    #     bash_command = f'cd {scripts_dir} && ./{script}'
    #     run_bash_command(bash_command, script)
    nodegroup_role_name = get_role_from_cloudformation(nodegroup_cfn_stack_name).split('/')[1]
    alb_policy_arn = get_role_from_cloudformation(alb_policy_cfn_stack_name)
    print(f"Role: {nodegroup_role_name}")
    print(f"ALB Policy ARN: {alb_policy_arn}")
