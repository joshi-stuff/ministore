CONFIG_FILE="${HOME}/.ministore/config.toml"
STORE="${HOME}/.ministore/keys"

ERR_NOT_FOUND=1
ERR_CORRUPT=2
ERR_CANCEL=3

cfg_armor() {
	[[ -r "${CONFIG_FILE}" ]] || return

	echo $(grep "^armor\s=" "${CONFIG_FILE}" | cut -d= -f2)
}

cfg_recipient() {
	[[ -r "${CONFIG_FILE}" ]] || return

	echo $(grep "^recipient\s=" "${CONFIG_FILE}" | cut -d= -f2) | tr -d '"'
}

del_key() {
	local key_path="$1"

	local file_path="${STORE}/${key_path}"

	[[ -r "${file_path}" ]] || exit ${ERR_NOT_FOUND}

	rm "${file_path}"
}

get_key() {
	local key_path="$1"

	local file_path="${STORE}/${key_path}"

	[[ -r "${file_path}" ]] || exit ${ERR_NOT_FOUND}

	gpg --decrypt "${file_path}" 2>/dev/null

	[[ $? -eq 0 ]] || exit ${ERR_CORRUPT}
}

list_keys() {
	cd "${STORE}"
	find . -type f | grep -v "\.$" | sed 's/^\.\///'
	cd - >/dev/null
}

set_key() {
	local key_path="$1"
	local key_value="$2"

	local file_path="${STORE}/${key_path}"
	local recipient="$(cfg_recipient)"

	local armor="$(cfg_armor)"

	[[ "${armor}" == "true" ]] && armor="--armor"

	mkdir -p $(dirname "${file_path}")

	if [[ -z "${recipient}" ]]
	then
		echo "${key_value}" | gpg --encrypt ${armor} --default-recipient-self > "${file_path}"
	else
		echo "${key_value}" | gpg --encrypt ${armor} --default-recipient "${recipient}" > "${file_path}"
	fi
}

set_typed_key() {
	local key_path="$1"

	gpg-connect-agent "CLEAR_PASSPHRASE ministore" /bye >/dev/null

	local key_value=$(gpg-connect-agent "GET_PASSPHRASE --repeat=1 --qualitybar --data ministore $(echo "${key_path}" | tr ' ' '+') Password: Please+enter+password+for+entry:" /bye)

	[[ -z $(echo "${key_value}" | grep "^ERR ") ]] || exit ${ERR_CANCEL}

	key_value=$(echo "${key_value}" | grep "^D " | cut -c3-)

	set_key "${key_path}" "${key_value}"
}
