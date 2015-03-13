# FreeNAS SABnzbd ⇔ OpenVPN

This repository is a modified version of [amussey/FreeNAS-SABnzbd-OpenVPN](https://github.com/amussey/FreeNAS-SABnzbd-OpenVPN) to use SABnzbd instead of SABnzbd. Many files are the same, including most of this README, so all credit to [amussey](https://github.com/amussey) for the awesome work!

This guide and the associated scripts will help you secure your SABnzbd client so it only sends traffic through a VPN.  For this particular guide, I'll be showing you how to set up [Private Internet Access](https://www.privateinternetaccess.com) on a [FreeNAS 9.3](http://www.freenas.org) jail, but any VPN service should work about the same, and the guide should be generic enough to apply to any FreeBSD jail.

## Setup

From the FreeNAS web interface, install the Trasmission plugin.

After Trasmission is installed, log into your FreeNAS machine over SSH.  Once inside, run `jls` to list the jails.

```bash
[root@MyNas] /# jls
   JID  IP Address      Hostname                      Path
     2  -               crashplan_1                   /mnt/volume/Plugins/Jails/crashplan_1
     9  -               sabnzbd_3 		              /mnt/volume/Plugins/Jails/SABnzbd_3
[root@MyNas] /#
```

To log into your SABnzbd jail, run `jexec (your jail number) tcsh`.  For example, to get into `sabnzbd_3`, we'd run:

```bash
[root@MyNas] /# jexec 9 tcsh
root@SABnzbd_3:/ #
```

Now you're inside your jail, running the `tcsh` shell.  `cd` to the root of the drive, and clone this repo.  `git` doesn't come pre-installed, but `svn` does, so you can run the following command to checkout the repo using svn:

```bash
svn checkout https://github.com/t3rminalVel0city/FreeNAS-SABnzbd-OpenVPN/trunk/FreeNAS-SABnzbd-OpenVPN
```

If you want to install git, you can run the following command:

```bash
pkg_add -r git
```

With the directory cloned, `cd` into it and run `make` to begin the setup.

```bash
root@SABnzbd_3:/ # cd /FreeNAS-SABnzbd-OpenVPN
root@SABnzbd_3:/FreeNAS-SABnzbd-OpenVPN # make
```

The setup script will walk you through a coupe additional steps.

When you've finished these steps, you'll need to copy your `openvpn.conf` and the associated keys into `/FreeNAS-SABnzbd-OpenVPN/openvpn`.  For Private Internet Access, these are available using the following command:

```bash
cd openvpn
wget https://www.privateinternetaccess.com/openvpn/openvpn.zip --no-check-certificate
unzip openvpn.zip
mv Sweden.ovpn openvpn.conf  # You can change this to the endpoint of your choice.
```

With the config file in place, fire up the OpenVPN process with the following line:

```bash
/etc/rc.d/SABnzbdvpn start
```

To stop the OpenVPN process, you can run the opposite command:

```bash
/etc/rc.d/SABnzbdvpn stop
```

That's all there is to it!  Enjoy your privacy!
