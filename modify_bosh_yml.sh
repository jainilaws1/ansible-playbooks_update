
if [ -z "$1" ]
then
#{
        echo "ERROR: File name not passed"
        exit 1
#}
fi
echo $1
file_name=$1
echo $file_name
sudo apt-get update -y
sudo apt-get install awscli -y
mkdir -p /root/.aws
export AWS_ACCESS_KEY_ID=AKIA6ONPWXEEOCX6UNZO
export AWS_SECRET_ACCESS_KEY=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
export AWS_REGION=us-west-2

echo "[default]" > /root/.aws/credentials
echo "aws_access_key_id = "$AWS_ACCESS_KEY_ID >> /root/.aws/credentials
echo "aws_secret_access_key = "$AWS_SECRET_ACCESS_KEY >> /root/.aws/credentials
echo "[default]" > /root/.aws/config
echo "region = "$AWS_REGION >>/root/.aws/config
group_id=$(cat ${file_name} | grep default_security_groups | cut -d ":" -f2 | sed "s/[]//g" | sed "s/\"//g")
group_name=$(aws ec2 describe-security-groups ${group_id} | grep GroupName | cut -d ':' -f2 | sed "s/\"//g")
cat ${file_name} | sed "s/${group_id}/${group_name}/g" > ${file_name}_update
mv ${file_name}_update ${file_name}
