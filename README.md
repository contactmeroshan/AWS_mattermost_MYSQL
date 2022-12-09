**Implementing a Team Communication Solution Using Mattermost and AWS.**

***Project 2 ***

DESCRIPTION

You are a Cloud engineer working on a Team Communication Solution
project for a big MNC. The client has compliance policies which do not
allow them to use services managed by third parties.\
The client wants a team communication solution that can be managed and
hosted on servers that are controlled by them.

**Steps to Perform:**

1.  Implement two different subnets (one public and the other private)
    in a custom VPC

2.  Install and configure MySQL on an Ubuntu 18.04 instance on the
    private subnet (Hint: Use a bastion host and a NAT instance)

3.  Install and configure Mattermost on an Ubuntu 18.04 instance on the
    public subnet

4.  Configure the security groups to allow the ports

5.  Test the installation by accessing the IP of the public instance in
    a browser.

PROPOSED SOLUTION ARCHITECTURE SETUP:

![Diagram Description automatically
generated](./images/media/image1.png){width="6.268055555555556in"
height="3.3208333333333333in"}

1)  Setting up VPC along with :

```{=html}
<!-- -->
```
a)  public and private subnet with their respective ROUTE TABLES is now
    easy with the new AWS VPC setup .

b)  This also sets up the NAT-GATWAY which is an improved solution over
    the older NAT instance. The setup was done as shown below, witn
    minimal configuration for demo purpose.

c)  We also enable DNS HOSTNAMES within the same page. ![Graphical user
    interface, application, Teams Description automatically
    generated](./images/media/image2.png){width="6.268055555555556in"
    height="3.5256944444444445in"}

> Zoomed in Detailed look:
>
> ![Graphical user interface, text, application, chat or text message
> Description automatically
> generated](./images/media/image3.png){width="6.448611111111111in"
> height="2.236111111111111in"}
>
> Left side panel view:
>
> ![Graphical user interface, text, application, email Description
> automatically
> generated](./images/media/image4.png){width="4.976337489063867in"
> height="9.188920603674541in"}
>
> ![Graphical user interface, text, application, email Description
> automatically
> generated](./images/media/image5.png){width="6.268055555555556in"
> height="5.826388888888889in"}
>
> Our main VPC.
>
> ![A screenshot of a computer Description automatically
> generated](./images/media/image6.png){width="6.268055555555556in"
> height="2.717361111111111in"}
>
> Public and private SUBNETS with IGW(FOR PUBLIC ) and NAT GATEWAY for
> PRIVATE SUBNET:
>
> ![A screenshot of a computer Description automatically
> generated](./images/media/image7.png){width="6.268055555555556in"
> height="2.615972222222222in"}
>
> ![A screenshot of a computer Description automatically
> generated](./images/media/image8.png){width="6.268055555555556in"
> height="2.7104166666666667in"}
>
> Enabling AUTO ASSIGN IP in PUBLIC SUBNET:
>
> ![Graphical user interface, application, Teams Description
> automatically
> generated](./images/media/image9.png){width="6.268055555555556in"
> height="2.685416666666667in"}
>
> WE ALSO SEE IGW configured and attached to our MAIN VPC. ![Graphical
> user interface, text, application, email Description automatically
> generated](./images/media/image10.png){width="6.268055555555556in"
> height="2.3555555555555556in"}
>
> Below can be seen PUBLIC and PRIVAE ROUTE TABLE configuration.
>
> ![Graphical user interface, text, application, email Description
> automatically
> generated](./images/media/image11.png){width="6.268055555555556in"
> height="2.661111111111111in"}![Graphical user interface, text,
> application, email Description automatically
> generated](./images/media/image12.png){width="6.268055555555556in"
> height="2.779861111111111in"}
>
> We also have subnets properly associated to public and private subnet.
> ![Graphical user interface, text, application, email Description
> automatically
> generated](./images/media/image13.png){width="6.268055555555556in"
> height="2.7631944444444443in"}![Graphical user interface, text,
> application, email Description automatically
> generated](./images/media/image14.png){width="6.268055555555556in"
> height="2.8569444444444443in"}

2)  Lets create one key pair which we will use for both MATTERMOST and
    MYSQL server for easy of demo. ![Graphical user interface, text,
    application, email Description automatically
    generated](./images/media/image15.png){width="5.444724409448819in"
    height="4.11132217847769in"}

![Graphical user interface, text, application, email Description
automatically
generated](./images/media/image16.png){width="6.268055555555556in"
height="1.3409722222222222in"}

3)  Setting up our MySQL SERVER IN PRIVATE SUBNET using UBUNTU **22.04
    LTS.**

we choose the KEY PAIR created earlier with SECURITY GROUP setting
allowing inbound connection:

SSH at port 22 and

MySQL at port 3306.

![Graphical user interface, text, application Description automatically
generated](./images/media/image17.png){width="4.152995406824147in"
height="4.361339676290464in"}

![Graphical user interface, application Description automatically
generated](./images/media/image18.png){width="5.937805118110236in"
height="4.11132217847769in"}

FINAL CHECK FOR SECURITY GROUP OF MySQL SERVER:

![Graphical user interface, application, table Description automatically
generated](./images/media/image19.png){width="6.268055555555556in"
height="3.0930555555555554in"}

4)  Setting up our MATTERMOST SERVER IN PUBLIC SUBNET using UBUNTU
    **18.04 LTS.**

we choose the KEY PAIR created earlier with SECURITY GROUPS setting
allowing inbound connection:

SSH at port 22 and

MATTERMOST at port 8065

General web server test if required at port 80 and 443

![Graphical user interface, text, application, email Description
automatically
generated](./images/media/image20.png){width="6.268055555555556in"
height="2.954861111111111in"}

![Graphical user interface, application, email Description automatically
generated](./images/media/image21.png){width="6.268055555555556in"
height="3.0388888888888888in"}

FINAL CHECK FOR SECURITY GROUP OF MATTERMOST SERVER:

![Table Description automatically
generated](./images/media/image22.png){width="6.268055555555556in"
height="2.4402777777777778in"}

5)  LETS HOP INTO THE MySQL server , by first logging into MATTERMOST
    public server and from within MATTERMOST server we will SSH into the
    MySQL private server. I will be using MOBAXTERM .

After configuring the MySQL server we will get back to the MATTERMOST
server.

ssh -i \"projectkeypair.pem\" ubuntu@10.0.130.140***ssh -i
\"projectkeypair.pem\"
<ubuntu@ec2-34-227-225-154.compute-1.amazonaws.com>*** AND THEN CREATING
key pair file projectkeypair.pem to use for logging into MySql server.

***vi projectkeypair.pem*** and pasting into it the content of our
***projectkeypair.pem FILE WE DOWNLOADED***

LOGGING privately INTO MySQL server's private IP, from WITHIN THE
MATTERMOST public server:

> ***ssh -i \"projectkeypair.pem\" <ubuntu@10.0.130.140>***

View of logging into MATTERMOST server

![Text Description automatically
generated](./images/media/image23.png){width="6.268055555555556in"
height="3.511187664041995in"}

Creating .PEM file:

Command: ***vi projectkeypair.pem*** and pasting into it the content of
our ***projectkeypair.pem FILE WE DOWNLOADED***

![Text Description automatically
generated](./images/media/image24.png){width="6.268055555555556in"
height="4.643055555555556in"}

Run this command, if necessary, to ensure your key is not publicly
viewable.

***chmod 400 projectkeypair.pem***

![Text Description automatically
generated](./images/media/image25.png){width="5.625288713910761in"
height="0.9444925634295713in"}

View of logging into MySQL server

![Text Description automatically
generated](./images/media/image26.png){width="6.268055555555556in"
height="4.2034722222222225in"}

Copying set of commands from the install script at my github(below link
is the updated one) ***COMMAND : wget***
<https://github.com/contactmeroshan/AWS_mattermost_MYSQL/blob/e898a2ffb30e94950998010e77235fb832a6e7e3/updated_install_mysql.sh>

***COMMAND : - chmod 700 ./DOWNLOADED.SH***\_file

***COMMAND : Sudo ./DOWNLOADED.SH***\_file.

If SH file execution shows error , the commands can be executed one by
one in root SUDO mode in the order shown below:

Sudo apt update -y

Sudo apt install mysql-server -y

mysql -u root \<\<-EOF

UPDATE mysql.user SET authentication_string=PASSWORD(\'password\') WHERE
User=\'root\';

DELETE FROM mysql.user WHERE User=\'root\' AND Host NOT IN
(\'localhost\', \'127.0.0.1\', \'::1\');

DELETE FROM mysql.user WHERE User=\'\';

DELETE FROM mysql.db WHERE Db=\'test\' OR Db=\'test\_%\';

FLUSH PRIVILEGES;

CREATE USER \'mmuser\'@\'%\' IDENTIFIED BY \'mostest\';

CREATE DATABASE mattermost_test;

GRANT ALL PRIVILEGES ON mattermost_test.\* TO \'mmuser\'@\'%\';

EOF

Sudo sed \"s/bind-address/#bind-address/\"
/etc/mysql/mysql.conf.d/mysqld.cnf \> mysqld.cnf

mv mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

sudo /etc/init.d/mysql restart

. MYsql script set works well for the UBUNTU 18.04 but was problematic
for me in UBUNTU 22.04 .

![Text Description automatically
generated](./images/media/image27.png){width="6.268055555555556in"
height="3.7472222222222222in"}

6)  Setting up MATTERMOST server :

We can download using the commands below the set of scripts in SH file.

\- ***wget
<https://github.com/contactmeroshan/AWS_mattermost_MYSQL/blob/e898a2ffb30e94950998010e77235fb832a6e7e3/updated_mattermost_install.sh>***

***- chmod 700 ./DOWNLOADED.SH***\_file

***-sudo ./DOWNLOADED.SH***\_file \--

If SH file execution shows error , the commands can be executed one by
one in root SUDO mode in the order shown below:

wget
https://releases.mattermost.com/5.19.0/mattermost-5.19.0-linux-amd64.tar.gz

tar -xvzf mattermost\*.gz

echo \"Extracted Mattermost\"

mv mattermost /opt

mkdir /opt/mattermost/data

sudo useradd \--system \--user-group mattermost

echo \"Created user\"

sudo sed \"s/localhost:3306/\$1:3306/\"
/opt/mattermost/config/config.json \> config.json

mv config.json /opt/mattermost/config/config.json

![Text Description automatically
generated](./images/media/image28.png){width="6.268055555555556in"
height="2.8402777777777777in"}

Now connecting to MySQL server from MATTERMOST server, using command

***sudo ./mattermost_install.sh \<private IP of MySQL server\>***

in my case - ***sudo ./mattermost_install.sh 10.0.130.140***

**[then final commands :]{.underline}**

**[sudo chown -R mattermost:mattermost /opt/mattermost]{.underline}**

**[sudo chmod -R g+w /opt/mattermost]{.underline}**

**[cd /opt/mattermost]{.underline}**

**[sudo -u mattermost ./bin/mattermost]{.underline}**

***below can be seen MATTERMOST listening on port 8065***

![Text Description automatically
generated](./images/media/image29.png){width="6.268055555555556in"
height="3.4493055555555556in"}

7)  TESTING THE MATTERMOST ONLINE SERVER:

opening the below llink

-   http://34.227.225.154:8065/

WE ARE REDIRECTED TO

<http://34.227.225.154:8065/signup_email>

![Graphical user interface, text, application Description automatically
generated](./images/media/image30.png){width="6.268055555555556in"
height="3.5256944444444445in"}

AFTER REGISTERING INTO IT , WE SUCCESSFULLY GET INSIDE THE CONSOLE.

![Graphical user interface, text, application Description automatically
generated](./images/media/image31.png){width="6.268055555555556in"
height="3.5256944444444445in"}

**CONCLUSION:**

**We have been successful in** **Implementing a Team Communication
Solution Using Mattermost and AWS.**

-   contactmeroshanjha@gmail.com
