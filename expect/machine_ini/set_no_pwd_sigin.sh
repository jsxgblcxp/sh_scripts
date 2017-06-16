#! /usr/bin/expect
set ipaddr [lindex $argv 0];
set usr_name [lindex $argv 1];
set usr_pwd  [lindex $argv 2];
set port  [lindex $argv 3];
set timeout -1


send  "$usr_pwd\n"
send  "$usr_name\n"
send  "$ipaddr \n"
sleep 1
spawn scp -F ./ssh_config_now  -P $port /home/jsxgblcxp/.ssh/id_rsa.pub $usr_name@$ipaddr:~

expect "yes" { 
        send "yes\n"
        expect "pass"
        send $usr_pwd;
        send "\n";
} "pass" { 
        send $usr_pwd;
        send "\n";
}

sleep 1

spawn ssh -F ./ssh_config_now -p $port $usr_name@$ipaddr

expect "yes" { 
        send "yes\n"
        expect "pass"
        send $usr_pwd;
        send "\n";
} "pass" { 
        send $usr_pwd;
        send "\n";
}

expect $usr_name
send  "mkdir .ssh\n"

expect $usr_name
send  "chmod 755 .ssh\n"

expect $usr_name
send  "cat id_rsa.pub >> ~/.ssh/authorized_keys \n"

expect $usr_name
send  "chmod 600 ~/.ssh/authorized_keys \n "

expect $usr_name
send  "rm -f ~/id_rsa.pub \n"


expect $usr_name
send "exit\n"


interact
