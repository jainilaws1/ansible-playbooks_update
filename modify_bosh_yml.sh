#script to download awscli and change the security id in bosh.yml to security group name.
group_id=$(cat bosh.yml | grep default_security_groups | cut -d "=" -f2)
group_name=$(aws ec2 describe-security-groups ${group_id} | grep GroupName | cut -d ':' -f2 | sed "s/\"//g")
cat bosh.yml | sed "s/${group_id}/${group_name}/g" > bosh_update.yml
mv bosh_update.yml bosh.yml
