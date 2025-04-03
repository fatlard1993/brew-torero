# Install & Upgrade Journey

`% which torero`
```
torero not found
```

`% brew install torero`

```
==> Fetching torerodev/torero
==> Downloading https://download.torero.dev/torero-v1.2.0-darwin-arm64.tar.gz
##################################################################################################################################################### 100.0%
==> Installing torero from torerodev
==> ------- Installing Torero -------
==> Successfully installed!
🍺  /opt/homebrew/Cellar/torero/1.2.0: 4 files, 43.2MB, built in 2 seconds
==> Running `brew cleanup torero`...
Removing: /Users/chase.whitfield/Library/Caches/Homebrew/torero--1.3.0... (0B)
Removing: /Users/chase.whitfield/Library/Caches/Homebrew/torero--1.3.0.tar.gz... (19.8MB)
```

`% torero version`

```
Please read the license at: https://torero.dev/licenses/eula
Do you agree to the EULA? (yes/no): yes
License accepted. Thank You!
version: 1.2.0
commit: cb9cface4db3f45649d17887829e023cd93fdfda
executable: /opt/homebrew/bin
mode: local
```

`% ./torero run service python-script homebrew-update --set version=1.3.0 --set username=xxx --set token=yyy`

```
Start Time:   2025-04-03T00:29:31Z
End Time:     2025-04-03T00:29:42Z
Elapsed Time: 11.302788s
Return Code:  0
Stdout:
Registering version 1.3.0
Changes committed and pushed to homebrew-torero

Stderr:
```

`% brew update`

```
==> Updating Homebrew...
Updated 1 tap (torerodev).
==> Outdated Formulae
yabai                     torero
==> Outdated Casks
kitty

You have 2 outdated formulae and 1 outdated cask installed.
You can upgrade them with brew upgrade
or list them with brew outdated.
```

`% brew upgrade torero`

```
==> Upgrading 1 outdated package:
torerodev/torero 1.2.0 -> 1.3.0
==> Fetching torerodev/torero
==> Downloading https://download.torero.dev/torero-v1.3.0-darwin-arm64.tar.gz
##################################################################################################################################################### 100.0%
==> Upgrading torerodev/torero
  1.2.0 -> 1.3.0
==> ------- Installing Torero -------
==> Successfully installed!
🍺  /opt/homebrew/Cellar/torero/1.3.0: 4 files, 44MB, built in 1 second
==> Running `brew cleanup torero`...
Removing: /opt/homebrew/Cellar/torero/1.2.0... (4 files, 43.2MB)
Removing: /Users/chase.whitfield/Library/Caches/Homebrew/torero--1.2.0.tar.gz... (19.4MB)
```

`% torero version`

```
version: 1.3.0
commit: 4630d7061555abb522cb8d6c9096a3e838412062
executable: /opt/homebrew/bin
mode: local
```
