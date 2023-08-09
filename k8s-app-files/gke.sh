gcloud compute networks create gke-network --subnet-mode=custom

gcloud compute networks subnets create gke-network-subnet-1 \
    --project=prod-hsbc --range=10.1.0.0/16 --stack-type=IPV4_ONLY \
    --network=gke-network --region=us-east1 --enable-flow-logs \
    --logging-aggregation-interval=interval-5-sec --logging-flow-sampling=0.5 \
    --secondary-range pod-network=172.16.0.0/16,service-network=192.168.0.0/16 \
    --logging-metadata=include-all

gcloud compute --project=prod-hsbc firewall-rules create ingress-allow-all-vpc1 \
    --description=ingress-allow-all-vpc1 --direction=INGRESS --priority=1000 \
    --network=gke-network --action=ALLOW --rules=all --destination-ranges=0.0.0.0/0

gcloud compute --project=prod-hsbc firewall-rules create egress-allow-all-vpc1 \
    --description=egress-allow-all-vpc1 --direction=EGRESS --priority=1000 \
    --network=gke-network --action=ALLOW --rules=all --destination-ranges=0.0.0.0/0

#https://devopscube.com/setup-kubernetes-cluster-google-cloud/
gcloud container clusters create demo-gke \
    --region us-east1 \
    --no-enable-ip-alias \
    --node-locations us-east1-b,us-east1-d,us-east1-c \
    --num-nodes 1 \
    --enable-autoscaling \
    --min-nodes 1 \
    --max-nodes 1 \
    --node-labels=env=dev \
    --machine-type g1-small \
    --enable-autorepair \
    --node-labels=type=webapps \
    --enable-vertical-pod-autoscaling \
    --preemptible \
    --disk-type pd-standard \
    --disk-size 10 \
    --enable-ip-alias \
    --network gke-network \
    --subnetwork gke-network-subnet-1 \
    --cluster-secondary-range-name pod-network \
    --services-secondary-range-name service-network \
    --tags=webapp \
    --enable-master-authorized-networks \
    --master-authorized-networks=0.0.0.0/0 \
    --cluster-version latest

gcloud container clusters get-credentials demo-gke --region=us-east1

kubectl get namespaces

kubectl config view

gcloud container clusters delete demo-gke --region us-east1 -q
