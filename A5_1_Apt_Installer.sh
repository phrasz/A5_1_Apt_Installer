#!/bin/bash
clear
CurStep="1"
TotStep="4"

res1=$(date +%s.%N)

echo "Allegro 5.1 Latest Install Script"
echo "================================="

echo "Would you like to install all A5.1 Dependencies? [Y/n]"
read D00d2
D00d="y"
if [ $D00d == $D00d$D00d2 ];then
	echo "[$CurStep/$TotStep] Grabbing Dependancies (needs sudo pw):"
	sudo apt-get install -y build-essential git cmake cmake-curses-gui xorg-dev libgl1-mesa-dev libfreetype6-dev libjpeg-dev libvorbis-dev libopenal-dev libphysfs-dev libgtk2.0-dev libpulse-dev libflac-dev libdumb1-dev libglu1-mesa-dev libpng12-dev libasound2-dev libcurl4-gnutls-dev ffmpeg

	echo ""
	CurStep=$((CurStep + 1))
else
	TotStep=$((TotStep-1))
fi

echo "Would you like to clone the latest A5.1 Repo? [Y/n]"
read D00d2
D00d="y"
if [ $D00d == $D00d$D00d2 ];then
	echo "[$CurStep/$TotStep] Cloning Latest SourceForge Repo..."
	git clone git://git.code.sf.net/p/alleg/allegro A5.1_$(date --iso-8601)

	echo ""
	CurStep=$((CurStep + 1))
else
	TotStep=$((TotStep-1))
fi

echo "[$CurStep/$TotStep] Attemping to build the source with Cmake"
echo "!!!IMPORTANT!!! Press C twice for Configure; then G to GO!"
echo "(Press Enter to Continue...)"
read temp
cd A5.1_$(date --iso-8601)
mkdir -p build
cd build
ccmake -DCMAKE_INSTALL_PREFIX=/usr ..

echo ""
CurStep=$((CurStep + 1))

echo "[$CurStep/$TotStep] Attemping to build the source!"
echo "This may take a while... (Press Enter to Continue)"
read temp
make

echo ""
CurStep=$((CurStep + 1))

echo "[$CurStep/$TotStep] Attempt to install! (may need sudo again...)"
sudo make install
echo ""
echo "DONE!!!!"
echo ""
echo "Build Report:"
echo "============="
res2=$(date +%s.%N)
echo "Start time: $res1"
echo "Stop time:  $res2"
echo "Elapsed:    $(echo "$res2 - $res1"|bc )"
