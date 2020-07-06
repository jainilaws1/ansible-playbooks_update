
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
group_id=$(cat ${file_name} | grep default_security_groups | cut -d ":" -f2 | sed "s/[]//g" | sed "s/\"//g")
group_name=$(aws ec2 describe-security-groups ${group_id} | grep GroupName | cut -d ':' -f2 | sed "s/\"//g")
cat ${file_name} | sed "s/${group_id}/${group_name}/g" > ${file_name}_update
mv ${file_name}_update ${file_name}
