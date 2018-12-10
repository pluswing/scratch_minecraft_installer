FORGE_VERSION='1.12.2-forge1.12.2-14.23.5.2768'
GAME_DIRECTORY="${HOME}/minecraft_scratch"
SCRIPT_DIR=$(cd $(dirname $0); pwd)

curl https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.12.2-14.23.5.2768/forge-1.12.2-14.23.5.2768-installer.jar -L -o forge.jar
echo "Minecraft Forgeのインストーラーを起動します。"
echo "この画面は閉じずに、clientをインストールしてください。"

${SCRIPT_DIR}/jre/bin/java -jar forge.jar > /dev/null
rm forge.jar forge.jar.log

echo "MinecraftとScratchを繋ぐソフトをダウンロードしています。"

curl https://github.com/arpruss/raspberryjammod/releases/download/0.94/mods.zip -L -o mods.zip
unzip mods.zip 1.12.2/RaspberryJamMod.jar
rm mods.zip

curl https://github.com/arpruss/raspberryjammod/releases/download/0.94/python-scripts.zip -L -o python-scripts.zip
unzip python-scripts.zip # -> mcpipy
rm python-scripts.zip

curl https://raw.githubusercontent.com/pilliq/scratchpy/master/scratch/scratch.py -L -o scratch.py
curl https://raw.githubusercontent.com/scratch2mcpi/scratch2mcpi/master/scratch2mcpi.py -L -o scratch2mcpi.py
curl https://raw.githubusercontent.com/martinohanlon/minecraft-turtle/master/mcturtle/minecraftturtle.py -L -o minecraftturtle.py
curl https://raw.githubusercontent.com/scratch2mcpi/minecraft-stuff/master/minecraftstuff.py -L -o minecraftstuff.py

mkdir -p "$GAME_DIRECTORY/mods/"
mv "1.12.2/RaspberryJamMod.jar" "$GAME_DIRECTORY/mods/"
rm -rf 1.12.2
mv mcpipy "$GAME_DIRECTORY/"
mv scratch.py "$GAME_DIRECTORY/mcpipy/"
mv scratch2mcpi.py "$GAME_DIRECTORY/mcpipy/"
mkdir -p "$GAME_DIRECTORY/mcpipy/mcturtle/"
touch "$GAME_DIRECTORY/mcpipy/mcturtle/__init__.py"
mv minecraftturtle.py "$GAME_DIRECTORY/mcpipy/mcturtle/"
mkdir -p "$GAME_DIRECTORY/mcpipy/mcstuff/"
touch "$GAME_DIRECTORY/mcpipy/mcstuff/__init__.py"
mv minecraftstuff.py "$GAME_DIRECTORY/mcpipy/mcstuff/"

ruby $SCRIPT_DIR/scripts/make_gamedir.rb 'minecraft_scratch' "$FORGE_VERSION" "$GAME_DIRECTORY"

echo "Scratch オフランエディターをダウンロードしています。"
curl http://download.scratch.mit.edu/MacScratch1.4.dmg -L -o MacScratch1.4.dmg
open MacScratch1.4.dmg

echo "インストールが完了しました。この画面を閉じてください。"
