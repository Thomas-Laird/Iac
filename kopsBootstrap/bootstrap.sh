export NAME=test.k8s.local
export KOPS_STATE_STORE=s3://thomas-laird-kubernetes/kopsState

#kops create cluster --state ${KOPS_STATE_STORE} --name ${NAME} --zones eu-west-1a --target terraform --out .

kops toolbox template --template template.yaml --values values.yaml > cluster.yaml

kops replace -f cluster.yaml --name --state ${KOPS_STATE_STORE} --name ${NAME} --force

kops create secret --name ${NAME} sshpublickey admin -i ~/.ssh/id_rsa.pub

kops update cluster --target terraform ${NAME} --out .

terraform init

terraform apply --auto-approve

kops update cluster --target terraform --name ${NAME} --out .

kops rolling-update cluster --name ${NAME} --cloudonly --force --yes


