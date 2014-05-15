MODID=examplemod
MODPACKAGE=com.example.examplemod
VERSION="1.0."$BUILD_NUMBER

MODPACKFILE=/home/doug/src/modcraft_server/public/downloads/mods/fullpack.zip
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

# Delete any old builds
rm -f ./build/libs/*

# Build the mod
./gradlew build

# Delete any old version of the mod
rm -f $SERVERDIR/mods/$MODID*

# Copy built mod file(s) into the mods directory
cp ./build/libs/* $SERVERDIR/mods/

# Zip the mods and make them publically available
rm -f $MODPACKFILE
cd $SERVERDIR/mods
zip -r $MODPACKFILE ./

# Restart the server (gives delay)
bash $SERVERDIR/runserver.sh restart "$MSG"
