#! /usr/bin/expect

set ipaddr [lindex $argv 0];
set root_pwd [lindex $argv 1];

set usr_name [lindex $argv 2];
set usr_pwd [lindex $argv 3];

send $root_pwd
spawn ssh  -F ./ssh_config_now root@$ipaddr

expect "yes" { 
        send "yes\n"
} "pass" { 
        send $root_pwd;
        send "\n";
}

expect "root"
send "adduser $usr_name\n"

expect "root"
send "passwd $usr_name\n"

expect "New password"
send $usr_pwd
send "\n"

expect "new"
send $usr_pwd
send "\n"


expect "root"
send "exit\n"

interact
