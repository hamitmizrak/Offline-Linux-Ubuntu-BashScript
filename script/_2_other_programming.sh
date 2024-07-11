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
PACKAGE="Paket Sistemde Yüklü mü"


###################################################################
###################################################################
# Updated
updated() {
    sleep 2
    echo -e "\n###### ${UPDATED} ######  "
    
    # Güncelleme Tercihi
    echo -e "Güncelleme İçin Seçim Yapınız\n1-)update\n2-)upgrade\n3-)dist-upgrade"
    read chooise

    # Girilen sayıya göre tercih
    case $chooise in
        1)
            read -p "Sistemin Listesini Güncellemek İstiyor musunuz ? e/h " listUpdatedResult
            if [[ $listUpdatedResult == "e" || $listUpdatedResult == "E" ]]; then
                echo -e "List Güncelleme Başladı ..."

                # Geri Sayım
                ./countdown.sh

                # Güncelleme
                sudo apt-get update
            else
                echo -e "Güncelleme yapılmadı"
            fi
            ;; 
        2)
            read -p "Sistemin Paketini Yükseltmek İstiyor musunuz ? e/h " systemListUpdatedResult
            if [[ $systemListUpdatedResult == "e" || $systemListUpdatedResult == "E" ]]; then
                echo -e "Kernel Güncelleme Başladı ..."

                # Geri Sayım
                ./countdown.sh

                # Güncelleme
                sudo apt-get update && sudo apt-get upgrade -y
            else
                echo -e "Güncelleme yapılmadı"
            fi
            ;; 
        3)
            read -p "Sistemin Çekirdeğini Güncellemek İstiyor musunuz ? e/h " kernelUpdatedResult
            if [[ $kernelUpdatedResult == "e" || $kernelUpdatedResult == "E" ]]; then
                echo -e "Kernel Güncelleme Başladı ..."

                # Geri Sayım
                ./countdown.sh

                # Güncelleme
                sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y
                # Çekirdek(Kernel) güncellemelerinde yeniden başlamak gerekebilir
                sudo apt list --upgradable | grep linux-image
            else
                echo -e "Güncelleme yapılmadı"
            fi
            ;;
        *)
            echo -e "Lütfen sadece size belirtilen seçeneği seçiniz"
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

        # Geri Sayım
        ./countdown.sh

        # Update
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
# Git Packet Install
# Install
gitInstall() {
    # Güncelleme Fonksiyonu
    updated

    # Geri Sayım
    ./countdown.sh

    echo -e "\n###### ${INSTALL} ######  "
    read -p "Git Paketini Yüklemek İstiyor musunuz ? e/h " gitInstallResult
    if [[ $gitInstallResult == "e" || $gitInstallResult == "E" ]]; then
        echo -e "Git Paket Yükleme Başladı ..."

        # Geri Sayım
        ./countdown.sh

        echo -e "Bulunduğum dizin => $(pwd)\n"
        sleep 1
        echo -e "######### Git #########\n"

        # Yükleme
        sudo apt-get install git -y 
        git version
        git config --global user.name "Hamit Mızrak"
        git config --global user.email "hamitmizrak@gmail.com"
        git config --global -l

        # Geri Sayım
        ./countdown.sh

        echo -e "######### Git Version #########\n"
        git --version

        # Clean Function
        clean

        # Yüklenen Paket Hakkında Bilgi Almak
        is_loading_package

         # Git Check Package dependency Fonksiyonunu çağır
        check_package
    else
        echo -e "Git Yükleme yapılmadı...."
    fi
}
gitInstall


###################################################################
###################################################################
# VS CODE Packet Install
# Install
vsCodeInstall() {
     # Güncelleme Fonksiyonu
    updated

    # Geri Sayım
    ./countdown.sh

    echo -e "\n###### ${INSTALL} ######  "
    read -p "VS Code Paketini Yüklemek İstiyor musunuz ? e/h " vscodeInstallResult
    if [[ $vscodeInstallResult == "e" || $vscodeInstallResult == "E" ]]; then
        echo -e "VS Code Paket Yükleme Başladı ..."

        # Geri Sayım
        ./countdown.sh

        echo -e "Bulunduğum dizin => $(pwd)\n"
        sleep 1
        echo -e "######### VS CODE #########\n"

        # Yükleme
        sudo snap install code --classic
        sleep 1

        sudo mkdir frontend
        cd frontend
        code .

        # Clean Function
        clean

        # Yüklenen Paket Hakkında Bilgi Almak
        is_loading_package

        # VSCODE Check Package dependency Fonksiyonunu çağır
        check_package
    else
        echo -e "Git Yükleme yapılmadı...."
    fi
}
vsCodeInstall


###################################################################
###################################################################
# JAVA JDK Packet Install
# Install
jdkInstall() {
     # Güncelleme Fonksiyonu
    updated

    # Geri Sayım
    ./countdown.sh

    echo -e "\n###### ${INSTALL} ######  "
    read -p "JDK Paketini Yüklemek İstiyor musunuz ? e/h " jdkInstallResult
    if [[ $jdkInstallResult == "e" || $jdkInstallResult == "E" ]]; then
        echo -e "JDK Paket Yükleme Başladı ..."

        # Geri Sayım
        ./countdown.sh

        echo -e "Bulunduğum dizin => $(pwd)\n"
        sleep 1
        echo -e "######### JDK #########\n"

        # Yükleme
        sudo apt-get install openjdk-11-jdk -y
        sudo add-apt-repository ppa:openjdk-r/ppa -y 
        echo -e "#Java Home\nJAVA_HOME=\"/usr/lib/jvm/java-11-openjdk-amd64/bin/\" " >> ~/.bashrc

        #sudo update-alternative --config java

        # Geri Sayım
        ./countdown.sh

        echo -e "######### Git Version #########\n"
        which git
        which java 
        java --version
        javac --version

        # Clean Function
        clean

        # Yüklenen Paket Hakkında Bilgi Almak
        is_loading_package

        # VSCODE Check Package dependency Fonksiyonunu çağır
        check_package
    else
        echo -e "Git Yükleme yapılmadı...."
    fi
}
jdkInstall

###################################################################
###################################################################
# MAVEN Packet Install
# Install
mavenInstall() {
     # Güncelleme Fonksiyonu
    updated

    # Geri Sayım
    ./countdown.sh

    echo -e "\n###### ${INSTALL} ######  "
    read -p "MAVEN Paketini Yüklemek İstiyor musunuz ? e/h " mavenInstallResult
    if [[ $mavenInstallResult == "e" || $mavenInstallResult == "E" ]]; then
        echo -e "MAVEN Paket Yükleme Başladı ..."

        # Geri Sayım
        ./countdown.sh

        echo -e "Bulunduğum dizin => $(pwd)\n"
        sleep 1
        echo -e "######### MAVEN #########\n"

        # Yükleme
        java --version 
        javac --version
        #sudo update-alternative --config java

        # Geri Sayım
        ./countdown.sh

        # Maven Yükle
        sudo apt install maven 
        
         # Geri Sayım
        ./countdown.sh

        echo -e "######### Version #########\n"
        which git
        which java
        which maven
        git --version
        java --version
        javac --version
        mvn --version

        # Clean Function
        clean

        # Yüklenen Paket Hakkında Bilgi Almak
        is_loading_package

        # VSCODE Check Package dependency Fonksiyonunu çağır
        check_package
    else
        echo -e "Git Yükleme yapılmadı...."
    fi
}
mavenInstall

###################################################################
###################################################################
# Apache Tomcat Packet Install
# Install
apacheTomcatInstall() {

     # Güncelleme Fonksiyonu
    updated

    # Geri Sayım
    ./countdown.sh

    echo -e "\n###### ${INSTALL} ######  "
    read -p "APACHE TOMCAT Paketini Yüklemek İstiyor musunuz ? e/h " apacheTomcatInstallResult
    if [[ $apacheTomcatInstallResult == "e" || $apacheTomcatInstallResult == "E" ]]; then
        echo -e "APACHE TOMCAT Paket Yükleme Başladı ..."

        # Geri Sayım
        ./countdown.sh

        echo -e "Bulunduğum dizin => $(pwd)\n"
        sleep 1
        echo -e "######### APACHE TOMCAT #########\n"

        # Yükleme
        java --version 
        javac --version
        mvn --version

        #sudo update-alternative --config java

        # Geri Sayım
        ./countdown.sh

        # Apache Tomcat Yükle
        # Tomcat 10 için En az JDK 11 kurmalısınız
        wget  https://archive.apache.org/dist/tomcat/tomcat-10/v10.0.8/bin/apache-tomcat-10.0.8.tar.gz
        sudo tar xzvf apache-tomcat-10.0.8.tar.gz
        sudo mkdir /opt/tomcat/
        sudo mv apache-tomcat-10.0.8/* /opt/tomcat/
        sudo chown -R www-data:www-data /opt/tomcat/
        # İzinleri Sembolik Mod olarak değiştirmek
        #sudo chmod -R u+rwx,g+rx,o+rx /opt/tomcat/
        sudo chmod -R 755 /opt/tomcat/
        
         # Geri Sayım
        ./countdown.sh

        # Tomcat Servisi Başlatma Ve Etkinleştirme
        sudo systemctl daemon-reload
        sudo systemctl start tomcat

        # Test 
        curl http://localhost:8080

        # Restart
        sudo systemctl restart tomcat

        # Tomcat Servisinin Otomatik Olarak Başlamasını Sağlıyordu.
        sudo sytemctl enable tomcat
        
        echo -e "######### Version #########\n"
        which git
        which java
        which maven
        git --version
        java --version
        javac --version
        mvn --version

        # Clean Function
        clean

        # Yüklenen Paket Hakkında Bilgi Almak
        is_loading_package

        # VSCODE Check Package dependency Fonksiyonunu çağır
        check_package
    else
        echo -e "Git Yükleme yapılmadı...."
    fi
}
mavenInstall

###################################################################
###################################################################
###################################################################
###################################################################
# Paket Yüklendi mi
is_loading_package() {
    sleep 2
    echo -e "\n###### ${PACKAGE} ######  "
    read -p "Paketin Yüklendiğini Öğrenmek İster misiniz ? e/h " packageResult
    if [[ $packageResult == "e" || $packageResult == "E" ]]; then
        echo -e "Yüklenmiş paket bilgisini öğrenme ..."

        # Geri Sayım
        ./countdown.sh

        echo -e "Bulunduğum dizin => $(pwd)\n"
        sleep 1

        echo -e "######### Paket Bağımlılığı #########\n"
        read -p "Lütfen yüklenmiş paket adını giriniz examples: git" user_input

        # dependency
        package_information "$user_input"
    else
        echo -e "Paket Yüklenme Bilgisi İstenmedi..."
    fi
}

package_information() {
    # parametre - arguman
    local packagename=$1

    # Belirli bir Komutun Yolu (Sistemde nerede olduğunu bulmak)
    which $packagename

    # İlgili Paketi bulma
    whereis $packagename

    # Paket Bilgilerini Görüntüleme
    apt-cache show $packagename

    # Paketin Yüklü olup olmadığını Kontrol Etmek
    dpkg-query -W -f='${Status} ${Package}\n' $packagename

    # Geri Sayım
    ./countdown.sh

    # Yüklü Tüm paketleri Listele
    dpkg -l 

    # Geri Sayım
    ./countdown.sh

    # Eğer paket isimleri uzunsa grep ile arama yap 
    dpkg -l | grep $packagename

    # Dosyalarını Listelemek İstersem
    dpkg -L $packagename

    ############
    # Yüklü Tüm Paketleri Listelemek
    apt list --installed

    # Belirli bir paketin yüklü olup olmadığını kontrol etmek
    apt list --installed | grep $packagename 
}

###################################################################
###################################################################
# Paket Bağımlıklarını Görme
check_package() {
    sleep 2
    echo -e "\n###### ${CHECK} ######  "
    read -p "Sistem İçin Genel Bağımlılık Paketini Yüklemek İstiyor musunuz ? e/h " checkResult
    if [[ $checkResult == "e" || $checkResult == "E" ]]; then
        echo -e "Yüklenecek Paket Bağımlılığı ..."

        # Geri Sayım
        ./countdown.sh

        echo -e "Bulunduğum dizin => $(pwd)\n"
        sleep 1

        echo -e "######### Paket Bağımlılığı #########\n"
        read -p "Lütfen yüklemek istediğiniz paket adını yazınız examples: nginx" user_input

        # dependency
        dependency "$user_input"
    else
        echo -e "Bağımlılıklar kontrol edilmedi ..."
    fi
}

dependency() {
    # parametre - arguman
    local packagename=$1
    #
    sudo apt-get check
    sudo apt-cache depends $packagename
    sudo apt-get install $packagename
}

###################################################################
###################################################################
# Information
information() {
    sleep 2
    echo -e "\n###### ${INFORMATION} ######  "
    read -p "Genel Bilgileri Görmek ister misiniz ? e/h " informationResult
    if [[ $informationResult == "e" || $informationResult == "E" ]]; then
        echo -e "Genel Bilgiler Verilmeye Başlandı ..."

        # Geri Sayım
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

        # Geri Sayım
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
    node -v
    zip -v
    unzip -v+
    # build-essential:
    gcc --version # gcc: GNU C compiler derlemek
    g++ --version # g++: GNU C++ compiler derlemek
    make --version # make: Makefile kullanarak derlemek içindir
    git --version
    java --version
    javac --version
     mvn --version
    #docker-compose -v
}
portVersion
