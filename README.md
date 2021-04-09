FreeBSD Port Tools
==================


Introduction
------------

FreeBSD Port Tools consist of the several small scripts run from
`port(1)` front-end:
- `port commit`: commit a port into the FreeBSD Ports GIT Repository
- `port create`: create a new port from a template
- `port diff`: generate a diff against a previous version of the port
- `port fetch`: fetch distfile(s) of a new version of the port
- `port followup`: followup on a PR with change/update
- `port help`: display usage summary for `port(1)` commands
- `port install`: install a port
- `port submit`: submit a PR with new port, or port change/update
- `port test`: automate testing a new port or a port update
- `port upgrade`: upgrade a port

FreeBSD Port Tools were originally available at <http://sourceforge.net/projects/porttools/>
but went unmaintained for too long, so I decided to fork the project and put it
on Github.

Usage
-----

Let us assume you are interested in helping out with one of the ports.
The most convenient way of doing that with the Port Tools is the following.
Even though the Port Tools have 3 most of diff generation, the recommended is
GIT (default). Do not be scared away at this point - it is very simple.
Let me give a quick overview:

1. Check out a working copy of the port. I usually do it in `~/ports` directory:

```
   xmj@mx12:~% git clone https://git.freebsd.org/ports.git
   xmj@mx12:~% cd ~/ports/net/ipsvd
```

   `net/ipsvd` is the sample port name.

2. Now, make your changes - e.g. change PORTVERSION from `0.6.0` to `0.6.1`.


```
   xmj@mx12:~/ports/net/ipsvd% vim Makefile
```

3. At this moment we need to fetch the new distfile and run `make makesum`
   to update the distinfo file. There is even simpler way to accomplish this
   with the Port Tools version `0.50` or later:

```
   xmj@mx12:~/ports/net/ipsvd% port fetch
```

4. Now we want to make sure that the port compiles, installs and works fine:

```
   xmj@mx12:~/ports/net/ipsvd% port test
```

5. Once I am satisfied with the results, let us submit a PR
   with the port update:

```
   xmj@mx12:~/ports/net/ipsvd% port submit
```

6. Sometimes things need work after submitting. Here's where I use followup to
   submit the patches. It has the neat feature of automatically obtaining the
   right subject line from the PR number supplied as argument.

```
   port followup -n <PR #>
```

Now, this interview consists of a few very simple cases, and it did not show off
all the features of the Port Tools, so please check `port(1)` manual page for details.

Thanks
------
Several people have contributed ideas and/or code to the FreeBSD Port Tools,
see `THANKS` file for details.

TODO
----
There are some improvements planned, see `TODO` file for details.

DISCLAIMER
----------

This program is free software; you can redistribute it and/or modify it under
the terms of the 2-clause Simplified BSD License which is distributed with the
software in the file LICENSE.
