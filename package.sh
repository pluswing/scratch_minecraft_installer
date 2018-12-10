BASE_NAME=minecraft_scratch_installer
VERSION=1.1.0
NAME=$BASE_NAME-$VERSION

mkdir $NAME
cp installer.command $NAME/
cp run.command $NAME/
cp -r scripts $NAME/
./make_jre.sh
cp -r jre $NAME/
cp README.md $NAME/
cp sample.sb $NAME/

zip -r $NAME.zip $NAME
