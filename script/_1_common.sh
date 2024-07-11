#!/bin/bash
echo "Genel Kurulumlar"

# User Variable
UPDATED="Güncelleme"
CLEANER="Temizleme"
INSTALL="Yükleme"
DELETED="Silme"
CHMOD="Erişim İzni"
INFORMATION="Genel Bilgiler Ports | NETWORKING"
UFW="Uncomplicated Firewall Ggüvenlik duvarı Yöentim Araçı"
LOGOUT="Sistemi Tekrar Başlatmak"
CHECK="Yüklencek Paket bağımlılıkları"

###################################################################
###################################################################
# Access Permission
accessPermission() {
    sleep 2
    echo -e "\n###### ${CHMOD} ######  "
    read -p "Dosya İzinleri Vermek İstiyor musunuz ? e/h " permissionResult
    if [[ $permissionResult == "e" || $permissionResult == "E" ]]; then
        echo -e "Dosya izinleri Başladı ..."
        ./countdown.sh
        sudo chmod +x countdown.sh
        sudo chmod +x reboot.sh
    else
        echo -e "Dosya izinleri yapılmadı"
    fi
}
# Function Calling
accessPermission

###################################################################
###################################################################
# Updated
updated() {
    sleep 2
    echo -e "\n###### ${UPDATED} ######  "
    read -p "Sistemin Listesini Güncellemek İstiyor musunuz ? e/h " listUpdatedResult
    if [[ $listUpdatedResult == "e" || $listUpdatedResult == "E" ]]; then
        echo -e "List Güncelleme Başladı ..."
        ./countdown.sh
        sudo apt-get update
    else
        echo -e "Güncelleme yapılmadı"
    fi
    read -p "Sistemin Paketini Yükseltmek İstiyor musunuz ? e/h " systemListUpdatedResult
    if [[ $systemListUpdatedResult == "e" || $systemListUpdatedResult == "E" ]]; then
        echo -e "Kernel Güncelleme Başladı ..."
        ./countdown.sh
        sudo apt-get update && sudo apt-get upgrade -y
    else
        echo -e "Güncelleme yapılmadı"
    fi
    read -p "Sistemin Çekirdeğini Güncellemek İstiyor musunuz ? e/h " kernelUpdatedResult
    if [[ $kernelUpdatedResult == "e" || $kernelUpdatedResult == "E" ]]; then
        echo -e "Kernel Güncelleme Başladı ..."
        ./countdown.sh
        sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y
        # Çekirdek(Kernel) güncellemelerinde yeniden başlamak gerekebilir
        sudo apt list --upgradable | grep linux-image
    else
        echo -e "Güncelleme yapılmadı"
    fi
}
updated


###################################################################
###################################################################
# logout
logout() {
    sleep 2
    echo -e "\n###### ${LOGOUT} ######  "
    read -p "Sistemi Kapatıp Tekrar Açmak ister misiniz ? e/h " logoutResult
    if [[ $logoutResult == "e" || $logoutResult == "E" ]]; then
        echo -e "Sitem Kapatılıyor ..."
        ./countdown.sh
        sudo apt update 
        clean # Temizleme Fonkisyonunu çağırsın
        ./reboot.sh
    else
        echo -e "Sistem Kapatılmadı"
    fi
}
# logout

###################################################################
###################################################################
# Install
install() {
    sleep 2
    echo -e "\n###### ${INSTALL} ######  "
    read -p "Sistem İçin Genel Yükleme İstiyor musunuz ? e/h " commonInstallResult
    if [[ $commonInstallResult == "e" || $commonInstallResult == "E" ]]; then
        echo -e "Genel Yükleme Başladı ..."
        ./countdown.sh
        echo -e "Bulunduğum dizin => $(pwd)\n"
        sleep 1
        sudo apt-get install vim -y
        sleep 1
        sudo apt-get install rar -y 
        sleep 1
        sudo apt-get install unrar -y 
        sleep
        sudo apt-get install curl -y 
        sleep 1
        sudo apt-get install openssh-server -y
        sleep 1 
        sudo apt install build-essential wget zip unzip -y
        # build-essential: Temel Geliştirme araçları içeren meta-pakettir
    else
        echo -e "Güncelleme yapılmadı"
    fi
}
install

# Packet Install
# Install
packageInstall() {
    sleep 2
    echo -e "\n###### ${INSTALL} ######  "
    read -p "Sistem İçin Genel Paket Yüklemek İstiyor musunuz ? e/h " packageInstallResult
    if [[ $packageInstallResult == "e" || $packageInstallResult == "E" ]]; then
        echo -e "Genel Paket Yükleme Başladı ..."
        ./countdown.sh
        echo -e "Bulunduğum dizin => $(pwd)\n"
        sleep 1
        echo -e "######### nginx #########\n"
        # Nginx Check Package dependency Fonksiyonunu çağır
        check_package
        sudo apt-get install nginx -y 
        sudo systemctl start nginx
        sudo systemctl enable mginx
        ./countdown.sh

        echo -e "######### nodejs #########\n"
        sudo apt install nodejs -y
        ./countdown.sh

        echo -e "######### Brute Force  #########\n"
        sudo apt install fail2ban -y 
        sudo systemctl start fail2ban
        sudo systemctl enable fail2ban
        ./countdown.sh

        echo -e "######### Monitoring  #########\n"
        sudo apt install htop iftop net-tools -y

        echo -e "######### Python  #########\n"
        sudo apt install python3 python3-pip -y
    else
        echo -e "Güncelleme yapılmadı"
    fi
}
packageInstall

###################################################################
###################################################################
# Paket Bağımlıklarını Görme
check_package() {
sleep 2
    echo -e "\n###### ${CHECK} ######  " 
    read -p "Sistem İçin Genel Paket Yüklemek İstiyor musunuz ? e/h " checkResult
    if [[ $checkResult == "e" || $checkResult == "E" ]]; then
        echo -e "Yüklenecek Paket Bağımlılığı ..."
        ./countdown.sh
        echo -e "Bulunduğum dizin => $(pwd)\n"
        sleep 1

        echo -e "######### Paket Bağımlılığı #########\n"
        read -p "Lütfen yüklemek istediğiniz paket adını yazınız examples: nginx" user_input

        # dependency
        dependency "$user_input"
    else
        echo -e "Güncelleme yapılmadı"
    fi
}

dependency(){
    # parametre - arguman
    local packagename=$1
    # 
    sudo apt-get check 
    sudo apt-cache depends $packagename
    sudo apt-get install $packagename
}

###################################################################
###################################################################
# Güvenlik duvarı INSTALL  (UFW => Uncomplicated Firewall)
theFirewallInstall() {

}
theFirewallInstall

# Güvenlik duvarı DELETE   (UFW => Uncomplicated Firewall)
heFirewallDelete() {

}
heFirewallDelete

###################################################################
###################################################################
# Information
information() {
    sleep 2
    echo -e "\n###### ${INFORMATION} ######  "
    read -p "Genel Bilgileri Görmek ister misiniz ? e/h " informationResult
    if [[ $informationResult == "e" || $informationResult == "E" ]]; then
        echo -e "Genel Bilgiler Verilmeye Başlandı ..."
        ./countdown.sh
        #sudo su
        echo -e "Ben Kimim => $(whoami)\n"
        sleep 1
        echo -e "Ağ Bilgisi => $(ifconfig)\n"
        sleep 1
        echo -e "Port Bilgileri => $(netstat -nlptu)\n"
        sleep 1
        echo -e "Linux Bilgileri => $(uname -a)\n"
        sleep 1
        echo -e "Dağıtım Bilgileri => $(lsb_release -a)\n"
        sleep 1
        echo -e "HDD Disk Bilgileri => $(df -m)\n"
        sleep 1
        echo -e "CPU Bilgileri => $(cat /proc/cpuinfo)\n"
        sleep 1
        echo -e "RAM Bilgileri => $(free -m)\n"
        sleep 1
    else
        echo -e "Dosya izinleri yapılmadı"
    fi
}
information

###################################################################
###################################################################
# Clean
# Install
clean() {
    sleep 2
    echo -e "\n###### ${CLEANER} ######  "
    read -p "Sistemde Gereksiz Paketleri Temizlemek İster misiniz ? e/h " cleanResult
    if [[ $cleanResult == "e" || $cleanResult == "E" ]]; then
        echo -e "Gereksiz Paket Temizliği Başladı ..."
        ./countdown.sh
        echo -e "######### nginx #########\n"
        sudo apt-get autoremove -y 
        sudo apt autoclean
         echo -e "Kırık Bağımlılıkları Yükle ..."
         sudo apt install -f
    else
        echo -e "Güncelleme yapılmadı"
    fi
}
clean

###################################################################
###################################################################
# Port And Version
portVersion() {
# node -v
        # java --version
        # git --version
        # docker-compose -v
        # zip -v 
        # unzip -v+
        # build-essential:
        # gcc --version # gcc: GNU C compiler derlemek
        # g++ --version # g++: GNU C++ compiler derlemek
        # make --version # make: Makefile kullanarak derlemek içindir
}
portVersion