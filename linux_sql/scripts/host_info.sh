# Setup and validate arguments (again, don't copy comments)
psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5

# Check # of args
if [ "$#" -ne 5 ]; then
    echo "Illegal number of parameters"
    exit 1
fi

# Save machine statistics in MB and current machine hostname to variables, and lscpu output
vmstat_mb=$(vmstat --unit M)
hostname=$(hostname -f)
lscpu_out=`lscpu`

# Retrieve host hardware specification variables
# xargs is a trick to trim leading and trailing white spaces
cpu_number=$(echo "$lscpu_out"  | egrep "^CPU\(s\):" | awk '{print $2}' | xargs)
cpu_architecture=$(echo "$lscpu_out" | grep "^Architecture:" | awk '{print $2}' | xargs)

# Used ': ' as a delimeter as the name is multiword so its easier to make it its own entry in awk
cpu_model=$(echo "$lscpu_out" | grep "^Model name:" | awk -F ': ' '{print $2}' | xargs)

# Used the NR command as I only want to see one entry (by default it gives 2 entries as the cpu has 2 cores
cpu_mhz=$(cat /proc/cpuinfo | grep "^cpu MHz" | awk 'NR==1 {print $4}' | xargs)
l2_cache=$(echo "$lscpu_out" | grep "^L2 cache:" | awk '{print $3}' | xargs)
total_mem=$(echo "$vmstat_mb" | tail -1 | awk '{print $4}'| xargs)

# Current time in `2019-11-26 14:40:19` UTC format
timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# PSQL command: Inserts server usage data into host_info table
# Note: be careful with double and single quotes
insert_stmt="INSERT INTO host_info(hostname, cpu_number, cpu_architecture, cpu_model, cpu_mhz, l2_cache, timestamp, total_mem) VALUES('$hostname', $cpu_number, '$cpu_architecture', '$cpu_model', $cpu_mhz, $l2_cache,  '$timestamp', $total_mem)"

#set up env var for pql cmd
export PGPASSWORD=$psql_password 
#Insert date into a database
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"
exit $?
