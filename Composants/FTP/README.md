# File Transfer Protocol

FTP est un protocole de communication destiné au partage de fichiers sur un réseau TCP/IP. Il permet de copier des fichiers vers une autre machine du réseau ou encore de accéder/modifier/supprimer des fichiers sur une machine. 

## Construction de l'image
```
docker build --label rpi-proftpd --tag tcoupin /home/pirate
```
## Mise en route du serveur  
... sur le port **21**  
... montage des dossiers **/home/pirate** sur **/users** et **/mnt/Data** sur **/data**
```
docker run --name proftpd -d -p 21:21 -v /home/pirate:/users -v /mnt/Data:/data tcoupin
```
## Fichiers nécessaires
* Dockerfile
* proftpd.conf
* start.sh
* users

### Dockerfile  
*ne pas oublier le proxy !*
```
FROM resin/rpi-raspbian:jessie

MAINTAINER Thibault Coupin <thibault.coupin@gmail.com>

ENV http_proxy http://10.0.4.2:3128

RUN apt-get update && apt-get install -y proftpd-basic
RUN mkdir /proftpd

ADD proftpd.conf users /proftpd/
ADD start.sh /

EXPOSE 20 21 50000-50050

CMD /bin/bash /start.sh
```
### proftpd.conf
```
#
# /etc/proftpd/proftpd.conf -- This is a basic ProFTPD configuration file.
# To really apply changes, reload proftpd after modifications, if
# it runs in daemon mode. It is not required in inetd/xinetd mode.
#

# Includes DSO modules
Include /etc/proftpd/modules.conf

# Set off to disable IPv6 support which is annoying on IPv4 only boxes.
UseIPv6				on
# If set on you can experience a longer connection delay in many cases.
IdentLookups			off

ServerName			"RaspberryPi"
ServerType			standalone
DeferWelcome			off

MultilineRFC2228		on
DefaultServer			on
ShowSymlinks			on

TimeoutNoTransfer		600
TimeoutStalled			600
TimeoutIdle			1200

DisplayLogin                    welcome.msg
DisplayChdir               	.message true
ListOptions                	"-l"

DenyFilter			\*.*/

# Use this to jail all users in their homes
DefaultRoot			~

# Users require a valid shell listed in /etc/shells to login.
# Use this directive to release that constrain.
RequireValidShell		off

AuthUserFile /etc/proftpd/ftpd.passwd


# Port 21 is the standard FTP port.
Port				21

# In some cases you have to specify passive ports range to by-pass
# firewall limitations. Ephemeral ports can be used for that, but
# feel free to use a more narrow range.
PassivePorts                  5001 5051

# If your host was NATted, this option is useful in order to
# allow passive tranfers to work. You have to use your public
# address and opening the passive ports used on your firewall as well.
MasqueradeAddress               172.31.56.158

# This is useful for masquerading address with dynamic IPs:
# refresh any configured MasqueradeAddress directives every 8 hours
<IfModule mod_dynmasq.c>
# DynMasqRefresh 28800
</IfModule>

# To prevent DoS attacks, set the maximum number of child processes
# to 30.  If you need to allow more than 30 concurrent connections
# at once, simply increase this value.  Note that this ONLY works
# in standalone mode, in inetd mode you should use an inetd server
# that allows you to limit maximum number of processes per service
# (such as xinetd)
MaxInstances			30

# Set the user and group that the server normally runs at.
User				proftpd
Group				nogroup

# Umask 022 is a good standard umask to prevent new files and dirs
# (second parm) from being group and world writable.
Umask				022  022
# Normally, we want files to be overwriteable.
AllowOverwrite			on

# Uncomment this if you are using NIS or LDAP via NSS to retrieve passwords:
# PersistentPasswd		off

# This is required to use both PAM-based authentication and local passwords
# AuthOrder			mod_auth_pam.c* mod_auth_unix.c

# Be warned: use of this directive impacts CPU average load!
# Uncomment this if you like to see progress and transfer rate with ftpwho
# in downloads. That is not needed for uploads rates.
#
# UseSendFile			off

TransferLog /var/log/proftpd/xferlog
SystemLog   /var/log/proftpd/proftpd.log

# Logging onto /var/log/lastlog is enabled but set to off by default
#UseLastlog on

# In order to keep log file dates consistent after chroot, use timezone info
# from /etc/localtime.  If this is not set, and proftpd is configured to
# chroot (e.g. DefaultRoot or <Anonymous>), it will use the non-daylight
# savings timezone regardless of whether DST is in effect.
#SetEnv TZ :/etc/localtime

<IfModule mod_quotatab.c>
QuotaEngine off
</IfModule>

<IfModule mod_ratio.c>
Ratios off
</IfModule>


# Delay engine reduces impact of the so-called Timing Attack described in
# http://www.securityfocus.com/bid/11430/discuss
# It is on by default.
<IfModule mod_delay.c>
DelayEngine on
</IfModule>

<IfModule mod_ctrls.c>
ControlsEngine        off
ControlsMaxClients    2
ControlsLog           /var/log/proftpd/controls.log
ControlsInterval      5
ControlsSocket        /var/run/proftpd/proftpd.sock
</IfModule>

<IfModule mod_ctrls_admin.c>
AdminControlsEngine off
</IfModule>

#
# Alternative authentication frameworks
#
#Include /etc/proftpd/ldap.conf
#Include /etc/proftpd/sql.conf

#
# This is used for FTPS connections
#
#Include /etc/proftpd/tls.conf

#
# Useful to keep VirtualHost/VirtualRoot directives separated
#
#Include /etc/proftpd/virtuals.conf

# A basic anonymous configuration, no upload directories.

# <Anonymous ~ftp>
#   User				ftp
#   Group				nogroup
#   # We want clients to be able to login with "anonymous" as well as "ftp"
#   UserAlias			anonymous ftp
#   # Cosmetic changes, all files belongs to ftp user
#   DirFakeUser	on ftp
#   DirFakeGroup on ftp
#
#   RequireValidShell		off
#
#   # Limit the maximum number of anonymous logins
#   MaxClients			10
#
#   # We want 'welcome.msg' displayed at login, and '.message' displayed
#   # in each newly chdired directory.
#   DisplayLogin			welcome.msg
#   DisplayChdir		.message
#
#   # Limit WRITE everywhere in the anonymous chroot
#   <Directory *>
#     <Limit WRITE>
#       DenyAll
#     </Limit>
#   </Directory>
#
#   # Uncomment this if you're brave.
#   # <Directory incoming>
#   #   # Umask 022 is a good standard umask to prevent new files and dirs
#   #   # (second parm) from being group and world writable.
#   #   Umask				022  022
#   #            <Limit READ WRITE>
#   #            DenyAll
#   #            </Limit>
#   #            <Limit STOR>
#   #            AllowAll
#   #            </Limit>
#   # </Directory>
#
# </Anonymous>

# Include other custom configuration files
Include /etc/proftpd/conf.d/
```
### start.sh
```
#!/bin/bash

cp -r /proftpd/* /etc/proftpd/

echo "" > ftpd.passwd
echo "" >> /proftpd/users
cat /proftpd/users | while read line;
do
	read -r -a array <<< "$line"
	echo "$line"
	echo "${array[1]}" | ftpasswd --passwd --name ${array[0]} --home ${array[2]} --shell /bin/false --uid 1000 --stdin
	mkdir -p ${array[2]}
done
mv ftpd.passwd /etc/proftpd
chmod -R 600 /etc/proftpd
/usr/sbin/proftpd -n -c /etc/proftpd/proftpd.conf
```
### users  
*nom_utilisateur mot_de_passe répertoire_d'accès*
```
admin admin /mnt/data/livraison
```
