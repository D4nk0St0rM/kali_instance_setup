#### Protonvpn
* * *
#### How to install the official Linux beta app

    If you are using an older version of  our Linux client, we recommend that you uninstall it before installing the new app. 
    Please see the Notes(1) section at the end of this article for instructions. 

    Open Terminal and enter the following commands (or just copy and paste them in):

    1. Add the ProtonVPN repository to your system’s software sources(2):

      wget -q -O - https://repo.protonvpn.com/debian/public_key.asc | sudo apt-key add - 

    Followed by:

     sudo add-apt-repository 'deb https://repo.protonvpn.com/debian unstable main'

    Note: Once this repo has been added, the app will be kept updated by your default package manager.

    2. Install the client:

      sudo apt-get update && sudo apt-get install protonvpn




#### How to use the official Linux beta app

    1. Log in using your regular Proton/ProtonVPN account details 
    (please note that these are not the OpenVPN/IKEv2 login credentials used by the older community Linux client). 

#### Log in with the command:

    protonvpn-cli login [ProtonVPN username]

    You will be prompted to enter your password. If you don’t have a ProtonVPN account you can sign up for one here.

* * *


### FortiClient SSLVPN - Used with virtualhackinglabs
* * *

    Open a Terminal session and run the following commands:

    wget https://www.virtualhackinglabs.com/wp-content/uploads/2017/03/forticlientsslvpn_linux_4.4_2336.tar.gz
    
    tar -zxf forticlientsslvpn_linux_4.4_2336.tar.gz

    cd forticlientsslvpn

    sudo ./fortisslvpn.sh

#### Invalid certificate error

Because the FortiClient SSLVPN for Linux does not use the default OS truststore, but checks for trusted certificates in its own repository, you can get an ‘Invalid certificate error’ when connecting to the Virtual Hacking Labs VPN. To avoid this we need to run the following three commands to add the CA certificates to the FortiClient trusted store:

    mkdir ~/.fctsslvpn_trustca

    cp /etc/ssl/certs/COMODO_RSA_Certification_Authority.pem ~/.fctsslvpn_trustca/

    cp /etc/ssl/certs/USERTrust_RSA_Certification_Authority.pem ~/.fctsslvpn_trustca/

    Links

    https://kb.fortinet.com/kb/viewContent.do?externalId=FD40440
  
#### Server: Enter the information sent to you in the confirmation e-mail from VHL

    Port: 443

    Username: Sent by e-mail

    Password: Sent by e-mail

    Lab: Sent by e-mail
    
 
