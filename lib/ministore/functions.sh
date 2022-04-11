ASKPASS="/usr/lib/ssh/ssh-askpass"
COPY="/usr/bin/wl-copy"
PASTE="/usr/bin/wl-paste"
STORE="$HOME/.ministore"

askpass() {
	PROMPT="$1"
	
	MASTER=$($ASKPASS "$PROMPT")

	echo -n "$MASTER"
}

clear_passwd() {
	ID="$1"

	FILE="$STORE/$ID"

	rm -f "$FILE"
}

clip_copy() {
	echo -n "$@" | "$COPY"
}

clip_paste() {
	"$PASTE"
}

get_var() {
	CONFIG="$1"
	KEY="$2"

	LINE=$(echo "$CONFIG" | grep "^$KEY=")

	echo "$LINE" | sed -e "s/^$KEY=//"
}

get_passwd() {
	ID="$1"

	FILE="$STORE/$ID"

	if [ ! -e "$FILE" ]
	then
		return
	fi

	MASTER=$(askpass "Enter master password for '$ID':")

	if [ -n "$MASTER" ]
	then
		cat "$FILE" | _decrypt "$MASTER"
	fi
}

get_store() {
	if [ ! -e "$STORE" ]
	then
		mkdir "$STORE"
		chmod 700 "$STORE"
	fi

	echo "$STORE"
}

read_stdin() {
	while read LINE
	do
		echo "$LINE"
	done
}

set_passwd() {
	ID="$1"
	PASSWD="$2"

	FILE="$STORE/$ID"

	MASTER=$(askpass "Enter master password for '$ID':")

	if [ -n "$MASTER" ]
	then
		echo -n "$PASSWD" | _encrypt "$MASTER" > "$FILE" 
	fi
}

_decrypt() {
	MASTER="$1"

	openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -salt -pass pass:"$MASTER"
}

_encrypt() {
	MASTER="$1"

	openssl enc -aes-256-cbc -md sha512 -a -pbkdf2 -iter 100000 -salt -pass pass:"$MASTER"
}
