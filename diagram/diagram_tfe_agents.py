from diagrams import Cluster, Diagram, Edge
from diagrams.aws.compute import EC2, EC2AutoScaling
from diagrams.aws.network import Route53,VPC, PrivateSubnet, PublicSubnet, InternetGateway, NATGateway, ElbApplicationLoadBalancer
from diagrams.onprem.compute import Server
from diagrams.aws.storage import SimpleStorageServiceS3Bucket
from diagrams.aws.database import RDSPostgresqlInstance
from diagrams.aws.database import ElasticacheForRedis

# Variables
title = "VPC with 1 public subnet for the TFE server and\n 2 private subnet in different AZ for the PostgreSQL instance requirement.\n Autoscaling group with TFE agents"
outformat = "png"
filename = "diagram-airgap"
direction = "TB"


with Diagram(
    name=title,
    direction=direction,
    filename=filename,
    outformat=outformat,
) as diag:
    # Non Clustered
    user = Server("user")

    # Cluster 
    with Cluster("aws"):
        bucket_tfe = SimpleStorageServiceS3Bucket("TFE bucket")
        bucket_files = SimpleStorageServiceS3Bucket("TFE airgap files")
        with Cluster("vpc"):
            igw_gateway = InternetGateway("igw")
    
            with Cluster("Availability Zone: eu-north-1b"):        
                # Subcluster
                with Cluster("subnet_private2"):
                        with Cluster("DB subnet"):
                            postgresql2 = RDSPostgresqlInstance("RDS different AZ")
                            
            with Cluster("Availability Zone: eu-north-1a \n\n  "):
                # Subcluster 
                with Cluster("subnet_public1"):
                     ec2_tfe_server = EC2("TFE_server")
                     ec2_tf_client = EC2("TF_client")
                # Subcluster
                with Cluster("subnet_private1"):
                    with Cluster("DB subnet"):
                        postgresql = RDSPostgresqlInstance("RDS Instance")
                    asg_tfe_agents = EC2AutoScaling("Autoscaling Group \n TFE agents")
    # Diagram

    user >> bucket_files 

    bucket_tfe
    
    user >> ec2_tf_client
    
    user >> ec2_tfe_server
     
    ec2_tfe_server >> [postgresql,
                       asg_tfe_agents,
                       bucket_tfe, 
                       bucket_files]

diag
