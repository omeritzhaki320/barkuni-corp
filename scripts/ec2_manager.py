import boto3
import logging
from botocore.exceptions import ClientError


class EC2Manager:
    def __init__(self):
        self.region_name = 'us-east-1'
        self.ec2 = boto3.client('ec2', region_name=self.region_name)
        self.logger = logging.getLogger('EC2Manager')
        self.setup_logging()

    def setup_logging(self):
        """
        Sets up logging for the EC2Manager class.
        """
        logging.basicConfig(level=logging.INFO)
        handler = logging.FileHandler('ec2_manager.log')
        formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        handler.setFormatter(formatter)
        self.logger.addHandler(handler)

    def create_instance(self, ami_id: str, instance_type: str, key_name: str, subnet_id: str, security_group_ids: list,
                        os_type: str = 'Linux') -> str:
        """
        Creates an EC2 instance with the given AMI ID, instance type, key name, subnet ID, and security group IDs.
        :param ami_id: the ID of the AMI to use
        :param instance_type: the type of EC2 instance to create
        :param key_name: the name of the key pair to use
        :param subnet_id: the ID of the subnet to launch the instance in
        :param security_group_ids: the IDs of the security groups to associate with the instance
        :param os_type: the operating system type of the instance (default: 'Linux')
        :return: the ID of the newly created EC2 instance
        """
        try:
            self.logger.info(f'Attempting to create {os_type} EC2 instance in subnet {subnet_id} with AMI {ami_id}')

            response = self.ec2.run_instances(
                ImageId=ami_id,
                InstanceType=instance_type,
                KeyName=key_name,
                SubnetId=subnet_id,
                SecurityGroupIds=security_group_ids,
                MaxCount=1,
                MinCount=1,
                TagSpecifications=[
                    {
                        'ResourceType': 'instance',
                        'Tags': [
                            {'Key': 'Name', 'Value': f'{os_type} EC2 Instance'},
                        ]
                    },
                ]
            )

            instance_id = response['Instances'][0]['InstanceId']
            self.logger.info(f'Successfully launched {os_type} EC2 instance with ID: {instance_id}')
            return instance_id

        except ClientError as e:
            self.logger.error(f'Failed to create {os_type} EC2 instance: {e}')
            return None

    def describe_instance(self, instance_id: str) -> dict:
        """
        Describes an EC2 instance with the given ID.
        :param instance_id: the ID of the instance to describe
        :return: the details of the instance, or None if the instance could not be found
        """
        try:
            self.logger.info(f'Describing EC2 instance {instance_id}')
            response = self.ec2.describe_instances(InstanceIds=[instance_id])
            instance_details = response['Reservations'][0]['Instances'][0]
            return instance_details
        except ClientError as e:
            self.logger.error(f'Failed to describe EC2 instance {instance_id}: {e}')
            return None
