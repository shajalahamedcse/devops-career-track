greet:=hello

KEY_FILE := auth.json
echo:
	@ echo ${greet}

PROJECT_ID:=playground-s-11-31ff0d6c
gcloud_login:
	@ gcloud auth activate-service-account --key-file=${KEY_FILE}

gcloud_set:
	@ gcloud config set project ${PROJECT_ID}

gcloud_list_network:
	@ gcloud compute networks list

VPC:=vpc-api
SUBNET_MODE := custom
gcloud_create_vpc:
	@ gcloud compute networks create ${VPC} --subnet-mode=${SUBNET_MODE}

gcloud_describe_network:
	@ gcloud compute networks describe ${VPC}
REGION:= us-east1
SUBNET:=web
SUBNET_CIDR:= 10.10.0.0/16
ZONE:=us-east1-b
MACHINE_TYPE:=e2-standard-2

gcloud_create_subnet:
	@ gcloud compute networks subnets create ${SUBNET} \
   					--network ${VPC} \
   					--region ${REGION} \
   					--range ${SUBNET_CIDR}
	
gcloud_list_subnet:
	@ gcloud compute networks subnets list

INSTANCE_NAME:=loadbalancer-1
gcloud_create_vm:
	@ gcloud compute instances create ${INSTANCE_NAME} \ 
		--project=${PROJECT_ID} --zone=${ZONE} \
		--machine-type=${MACHINE_TYPE} --subnet=${SUBNET} \
		--image-family=debian-10 --image-project=debian-cloud 
		--boot-disk-size=10GB
		--tag=
		--metadata ssh-keys=root:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCeeeac95K2Xlwjvc2LPlmyAERrv39m4XOIywSuMkh7K5Xh4I5OSIaCR62dV7TIWuo4YnoUifpMVSldgYmt/OHS0PSlpYwvvUud3Eah3FYJhNhJrlOw1iF2hJbKXI8fLQ46Zr1QEbjD6KYmITcO2KCLjm01S82ar9cz2swlsudZJ64MK3Gr6H2WganmYvK+/+YIaSdXxxDX9aMxsK99tW6QV3zG+UTKfrQXyEG3Hu+NCWYZd6T2pNOd5++ygLQNaG+PypAo4TCJGU4W+ykdt9DIaBes9mXIjGI/mWvnP+NPouTvN1ucjMGsaylJfUDSyOVb56mmhFroxt7+W4RBpAb9aCd/vJvu45txLL4qjA6jW1ciYhv//TOzUYR3iknd1K1FOtSPSNsi/GLZpZyceyoA6/li00mTcCypcfY28XZYQpYKG9LV5JfFkyOJlOT/Z00YqC2+Mhsuic1z1hWZmJmpCRiD1oKEdSxdHElGfRTnVUg2+WLc7XdRUW4Q/Jekzu8= root@81aa8fe914e2

INSTANCE_NAME:=loadbalancer
delete_vm:
	@ gcloud compute instances delete $(INSTANCE_NAME) --project=$(PROJECT_ID) --zone=$(ZONE) --quiet
all: gcloud_login gcloud_set