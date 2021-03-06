# launch a EMR cluster with 1 master and 2 workers
aws emr create-cluster \
--applications Name=Ganglia Name=Spark Name=Zeppelin \
--tags 'emr=' \
--ec2-attributes '{"KeyName":"lz1714-IAM-keypair",
                  "InstanceProfile":"EMR_EC2_DefaultRole",
                  "SubnetId":"subnet-aa6fed84",
                  "EmrManagedSlaveSecurityGroup":"sg-0800e273b14dd59b2",
                  "EmrManagedMasterSecurityGroup":"sg-043757d5f69d0a814"}' \
--service-role EMR_DefaultRole \
--enable-debugging \
--release-label emr-5.17.0 \
--log-uri 's3n://aws-logs-257685430371-us-east-1/elasticmapreduce/' \
--name 'data311in' \
--instance-groups '[{"InstanceCount":2,
                     "EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":32,"VolumeType":"gp2"},
                                                                   "VolumesPerInstance":1}]},
                     "InstanceGroupType":"CORE",
                     "InstanceType":"m4.large",
                     "Name":"Core Instance Group"},
                    {"InstanceCount":1,
                     "EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":32,"VolumeType":"gp2"},
                                                                   "VolumesPerInstance":1}]},
                     "InstanceGroupType":"MASTER",
                     "InstanceType":"m4.large",
                     "Name":"Master Instance Group"}]' \
--configurations '[{"Classification":"spark",
                    "Properties":{"maximizeResourceAllocation":"true"},
                    "Configurations":[]}]' \
--scale-down-behavior TERMINATE_AT_TASK_COMPLETION \
--region us-east-1
