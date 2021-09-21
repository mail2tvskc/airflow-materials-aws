
#!/bin/bash

# Create an IAM policy ALBIngressControllerIAMPolicy
# to alllow ALB makes API calls on your behalf
# Copy the Policy.Arn value
# aws iam create-policy \
#    --policy-name ALBIngressControllerIAMPolicy \
#    --policy-document file://airflow-materials-aws/section-7/iam/iam-alb-policy.json

PolicyARN=`aws iam list-policies --query "Policies[?PolicyName=='ALBIngressControllerIAMPolicy'].Arn" --output text`

eksctl create iamserviceaccount \
       --cluster=airflow \
       --namespace=kube-system \
       --name=alb-ingress-controller \
       --attach-policy-arn=$PolicyARN \
       --override-existing-serviceaccounts \
       --approve