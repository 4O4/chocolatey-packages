﻿SSHFS-Win is a minimal port of [SSHFS](https://github.com/libfuse/sshfs) to Windows. Under the hood it uses [Cygwin](https://cygwin.com) for the POSIX environment and [WinFsp](https://github.com/billziss-gh/winfsp) for the FUSE functionality.

## How to use

Once you have installed WinFsp and SSHFS-Win you can start an SSHFS session to a remote computer using the following syntax:

    \\sshfs\[locuser=]user@host[!port][\path]

For example, you can map a network drive to billz@linux-host by using the syntax:

    \\sshfs\billz@linux-host

As a more complicated example, you can map a network drive to billz@linux-host at port 9999, but give access rights to the local user billziss by using the syntax:

    \\sshfs\billziss=billz@linux-host!9999

It is also possible to map the remote root directory by starting the `path` with a double backslash as in the following example:

    \\sshfs\billz@linux-host\\home\billz

You can also mount the remote's root `/` directory using the following format:

    \\sshfs\user@host\..\..

You can use the Windows Explorer "Map Network Drive" functionality or you can use the `net use` command from the command line.

## GUI front end

[SiriKali](https://mhogomchungu.github.io/sirikali/) is a GUI front end for SSHFS-Win (and other file systems). Please report problems with SiriKali in its [issues](https://github.com/mhogomchungu/sirikali/issues) page.