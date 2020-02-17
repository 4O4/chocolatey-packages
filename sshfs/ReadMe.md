﻿SSHFS-Win is a minimal port of [SSHFS](https://github.com/libfuse/sshfs) to Windows. Under the hood it uses [Cygwin](https://cygwin.com) for the POSIX environment and [WinFsp](https://github.com/billziss-gh/winfsp) for the FUSE functionality.

## Basic Usage

Once you have installed WinFsp and SSHFS-Win you can map a network drive to a directory on an SSHFS host using Windows Explorer or the `net use` command.

### Windows Explorer

In Windows Explorer select This PC > Map Network Drive and enter the desired drive letter and SSHFS path using the following UNC syntax:

    \\sshfs\REMUSER@HOST[\PATH]

The first time you map a particular SSHFS path you will be prompted for the SSHFS username and password. You may choose to save these credentials with the Windows Credential Manager in which case you will not be prompted again.

In order to unmap the drive, right-click on the drive icon in Windows Explorer and select Disconnect.

<p align="center">
<img src="http://www.secfs.net/winfsp/files/cap.gif" height="450"/>
</p>

### Command Line

You can map a network drive from the command line using the `net use` command:

```
> net use X: \\sshfs\billziss@mac2018.local
The password is invalid for \\sshfs\billziss@mac2018.local.

Enter the user name for 'sshfs': billziss
Enter the password for sshfs:
The command completed successfully.
```

You can list your `net use` drives:

```
$ net use
New connections will be remembered.


Status       Local     Remote                    Network

-------------------------------------------------------------------------------
             X:        \\sshfs\billziss@mac2018.local
                                                WinFsp.Np
The command completed successfully.
```

Finally you can unmap the drive as follows:

```
$ net use X: /delete
X: was deleted successfully.
```

## UNC Syntax

The complete UNC syntax is as follows:

    \\sshfs\[LOCUSER=]REMUSER@HOST[!PORT][\PATH]
    \\sshfs.r\[LOCUSER=]REMUSER@HOST[!PORT][\PATH]
    \\sshfs.k\[LOCUSER=]REMUSER@HOST[!PORT][\PATH]

- `REMUSER` is the remote user (i.e. the user on the SSHFS host whose credentials are being used for access).
- `HOST` is the SSHFS host.
- `PORT` is the remote port on the SSHFS host (optional; default is 22).
- `PATH` is the remote path. This is interpreted as follows:
    - The `sshfs` prefix maps to `HOST:~REMUSER/PATH` on the SSHFS host (i.e. relative to `REMUSER`'s home directory).
    - The `sshfs.r` prefix maps to `HOST:/PATH` on the SSHFS host (i.e. relative to the `HOST`'s root directory).
    - The `sshfs.k` prefix maps to `HOST:~REMUSER/PATH` and uses the ssh key in `%USERPROFILE%/.ssh/id_rsa` (where `%USERPROFILE%` is the home directory of the local Windows user).
- `LOCUSER` is the local Windows user (optional; `USERNAME` or `DOMAIN+USERNAME` format).
    - Please note that this functionality is rarely necessary with latest versions of WinFsp.

## GUI front end

[SiriKali](https://mhogomchungu.github.io/sirikali/) is a GUI front end for SSHFS-Win (and other file systems). Instructions on setting up SiriKali for SSHFS-Win can be found at this [link](https://github.com/mhogomchungu/sirikali/wiki/Frequently-Asked-Questions#90-how-do-i-add-options-to-connect-to-an-ssh-server). Please report problems with SiriKali in its [issues](https://github.com/mhogomchungu/sirikali/issues) page.

SiriKali supports:

- Password authentication.
- Key Agents and KeePass 2.
- Public key authentication.

## Advanced Usage

It is possible to use the `sshfs-win.exe` and `sshfs.exe` programs directly for advanced usage scenarios. Both programs can be found in the `bin` subdirectory of the `SSHFS-Win` installation (usually `\Program Files\SSHFS-Win\bin`).

The `sshfs-win.exe` program is useful to launch `sshfs.exe` from a `cmd.exe` prompt (`sshfs-win cmd`) or to launch `sshfs.exe` under the control of the [WinFsp Launcher](https://github.com/billziss-gh/winfsp/wiki/WinFsp-Service-Architecture) (`sshfs-win svc`). The `sshfs-win.exe` program **SHOULD NOT** be used from Cygwin. The `sshfs-win.exe` program has the following usage:

```
usage: sshfs-win cmd SSHFS_COMMAND_LINE
    SSHFS_COMMAND_LINE  command line to pass to sshfs

usage: sshfs-win svc PREFIX X: [LOCUSER] [SSHFS_OPTIONS]
    PREFIX              Windows UNC prefix (note single backslash)
                        \sshfs[.r|.k]\[LOCUSER=]REMUSER@HOST[!PORT][\PATH]
                        sshfs: remote home; sshfs.r: remote root
                        sshfs.k: remote home with key authentication
    LOCUSER             local user (DOMAIN+USERNAME)
    REMUSER             remote user
    HOST                remote host
    PORT                remote port
    PATH                remote path (relative to remote home or root)
    X:                  mount drive
    SSHFS_OPTIONS       additional options to pass to SSHFS
```

The `sshfs.exe` program can be used with an existing Cygwin installation, but it requires prior installation of FUSE for Cygwin on that Cygwin installation. FUSE for Cygwin is included with WinFsp and can be installed on a Cygwin installation by executing the command:

```
$ sh WINFSP_INSTALL_DIR/opt/cygfuse/install.sh
FUSE for Cygwin installed.
```
