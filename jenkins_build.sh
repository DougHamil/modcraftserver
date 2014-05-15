MODID=examplemod
MODPACKAGE=com.example.examplemod
VERSION="1.0."$BUILD_NUMBER

DOWNLOADDIR=/home/doug/modcraft/public/downloads
FORGEDIR=/home/doug/minecraftforge
SERVERDIR=/home/doug/MinecraftForgeServer

FORGESRCDIR=$FORGEDIR/src

# Get the commit message
MSG=`git log -n 1 --pretty=format:"'%s'"`

# Clear out old code
rm -rf $FORGESRCDIR
mkdir $FORGESRCDIR

cp -r $WORKSPACE/* $FORGESRCDIR
cd $FORGEDIR

# Set mod ID, package and version in build file
sed -i s/^group.*/group=\"$MODPACKAGE\"/ build.gradle
sed -i s/^archivesBaseName.*/archivesBaseName=\"$MODID\"/ build.gradle
sed -i s/^version.*/version=\"$VERSION\"/ build.gradle

./gradlew build

# Copy built mod file(s) into the mods directory
cp ./build/libs/* $SERVERDIR/mods/

# Restart the server (gives 30 second delay)
bash $SERVERDIR/runserver.sh restart "$MSG"
