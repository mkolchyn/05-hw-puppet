# 05-puppet

yum -y install java-17-openjdk.x86_64
mkdir /opt/minecraft
wget https://piston-data.mojang.com/v1/objects/c9df48efed58511cdd0213c56b9013a7b5c9ac1f/server.jar
java -Xmx1024M -Xms1024M -jar server.jar --nogui
vi eula.txt



/etc/systemd/system/minecraft.service

[Unit]
Description=Minecraft Server

[Service]
KillMode=none
SuccessExitStatus=0 1

WorkingDirectory=/opt/minecraft/
ExecStart=/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar
ExecStop=/usr/local/bin/mcrcon -H 192.168.50.28 -P 25575 -p 111111 stop

[Install]
WantedBy=multi-user.target

/opt/minecraft/server.properties
rcon.port=25575
rcon.password=111111
enable-rcon=true


git clone https://github.com/Tiiffi/mcrcon.git
cd mcrcon
make
make install
