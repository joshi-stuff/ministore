get_var() {
	local blob="$1"
	local key="$2"
 
	local line=$(echo "${blob}" | grep "^${key}=")

	echo "${line}" | sed "s/^${key}\=//"
}

read_stdin() {
	local line

	while read line
	do
		echo "${line}"
	done
}

