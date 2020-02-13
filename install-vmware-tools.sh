echo 'You can find vmware-tools iso under [/usr/lib/vmware/isoimages/linux.iso] on host machine'
echo ''
echo ''
echo 'Press enter to continue...'
read a

wget http://www.as2.com/linux/tools/vmtools-4-arch-and-co.tar.bz2
tar -xjf vmtools-4-arch-and-co.tar.bz2

sudo echo "rm vmtools-4-arch-and-co.*
sudo /etc/init.d/rc6.d/K99vmware-tools start
sudo echo '[Unit]
Description=VMWare Tools daemon
[Service]
ExecStart=/etc/init.d/vmware-tools start
ExecStop=/etc/init.d/vmware-tools stop
PIDFile=/var/lock/subsys/vmware
TimeoutSec=0
RemainAfterExit=yes
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/vmware-tools.service
sudo systemctl enable /etc/systemd/system/vmware-tools.service
sudo rm -rf /etc/vmisrp
sudo systemctl disable vmisrp.service
sudo rm /etc/vmisrp.service" > /etc/vmisrp.sh

sudo echo "[Unit]
Description=VMWare Install Script Restart Persistence
[Service]
ExecStart=/etc/vmisrp.sh
ExecStop=
RemainAfterExit=no
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/vmisrp.service

sudo systemctl enable /etc/systemd/system/vmisrp.service
echo ''
echo 'Installed VMWare Install Script Restart Persistence'
echo 'Removing open-vm-tools package'
sudo pacman -Rs open-vm-tools
echo ''
echo 'When the next section runs use default values and say yes to restart'
echo ''
echo 'Press enter to continue...'
read a

chmod +x ./vmtools-4-arch-and-co.sh
sudo ./vmtools-4-arch-and-co.sh
