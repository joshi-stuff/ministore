# ministore

> Mini keyring store based on GnuPG.

Ministore is a command line utility that can be used to store and retrieve
passwords that are encrypted using your GnuPG key.

It is specially well suited for lightweight desktop environments (eg:
[Sway](https://swaywm.org/)) because it uses the GnuPG Agent for all UI
interaction with the user so, once you setup GnuPG, `ministore` runs smoothly.

It also features a [git-credentials](https://git-scm.com/docs/gitcredentials)
helper so that you can use `ministore` to manage the passwords of your Git
repositories.


## Installation

Currently it is only provided as an Arch Linux
[AUR package](https://aur.archlinux.org/packages/ministore) but it could be
easily tweaked to work in other Linux distros.

> 🤗 Feel free to file an issue or send me an e-mail if you are willing to
> support installations for your preferred Linux distro. I'll be more than happy
> to help you and tweak the project to make it work there.


## Configuration

Once installed, there's nothing special to be configured, as the program uses
sensible defaults (eg: it uses the default GnuPG key for encrypting values).

However, you may change a bit its behaviour by placing a `config.toml` file in
the `$HOME/.ministore` directory.

You can find a sample of that file at `/usr/share/ministore/samples/config.toml`
once you install the package.

The file is self-documented with comments. If you want to check it out online
just follow [this link](samples/config.toml).


### Configuring the git-credentials helper

You just basically need to add the following to your `$HOME/.gitconfig` file to
make `ministore` work as a git-credentials helper:

```
[credential]
	helper = ministore
```

That will make `git` ask `ministore` for credentials. 

In any case, have a look at the official Git documentation on
[git-credentials](https://git-scm.com/docs/gitcredentials) to see more advanced
things you can do.


## Usage

Simply run `ministore` without any argument to get help on how to use it.

For the sake of making our lives easier, the more useful commands are documented
here:

  - `list`: List the paths of all stored keys.
  - `get <key path>`: Prints the value of the given key.
  - `set <key path> <key value>`: Sets the value of the given key.
  - `type <key path>`: Like `set` but prompts the user for the value.
  - `del <key path>`: Deletes the given key.
 

## Why I created this project?

Mainly because I can and because I want to 😅.

The project is similar in philosophy to [Pass](https://www.passwordstore.org/),
but differs in that it only handles passwords (ie: you cannot store more
metadata associated to a single key path).

It doesn't support plugins, either.

Neither many of the commands of Pass.

Then, what's the advantage?

I don't know 🤷, but it seems very lightweight to me and, in addition:

  1. It uses GnuPG for everything so once you configure your personal GnuPG key,
     you don't need any other things to setup or an extra password to remember. 

  2. It will support the
     [Secrets API Specification](https://freedesktop.org/wiki/Specifications/secret-storage-spec/secrets-api-0.1.html)
     in the future, so it will be a great replacement for Gnome Keyring or 
     KeepassXC, for example.

