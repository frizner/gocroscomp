#!/bin/bash
#
# The script to perform cross compilation for set platforms
# Dmitry Frizner, 2018
#

function Help()
{ 
  echo "$0 performs cross compilation of a golang package,"
  echo "   archaive the binaries and creates file with checksum for the each archive."
  echo
  echo "usage: $0 PLATFORMS PACKET FILENAME VERSION" 
  echo
  echo "  - PLATFORMS. Sets OSes and platforms by using regular expression to build binarie files."
  echo "    For instance '(windows|linux)\/(386|amd64)'."                  
  echo
  echo "  - PACKET. The name of packet to compile."
  echo "    For instance 'github.com/friznerd/solrdump/cmd/solrdump'"
  echo
  echo "  - FILENAME. The name of destination binary file."
  echo "    For Windows OS, '.exe' extension will be aaded automatically"
  echo
  echo "  - VERSION. The version will be added into names of archaives of the binary files."
  echo "    For instance '0.1.1'"
}

if [ $# -lt 4 ]; then
  Help
  exit 1
fi

RE_MASK=$1
PACKET=$2
FILENAME=$3
VERSION=$4

PLATF="/tmp/platforms.tmp"

# Changing platform and OS names.  darwin to osx, amd64 to x86_64 etc.
function RenameARCH()
{
  ARCHFILE="${ARCHFILE/amd64/x86_64}"
  ARCHFILE="${ARCHFILE/386/x86_32}"
  ARCHFILE="${ARCHFILE/darwin/osx}"
}

# Receiving the list of accessible platforms and OS, filtering by settings
( go tool dist list | egrep $RE_MASK > $PLATF ) || ( exit 3 )

# Name of file to save checksums
CHECKSUMFILE=$FILENAME"_"$VERSION"_SHA256.txt"          

# Create or rewrite the checksumfile
cat <<EOF > $CHECKSUMFILE
EOF


# Compile, archive and get checksum for the each OS and platform

while read p; do
  # Set environment variables (OS and platform) for the compilation
  export GOOS=`echo $p | cut -d"/" -f1`
  export GOARCH=`echo $p | cut -d"/" -f2`

  if [ $GOOS == windows ]
    then
      # Compile and add '.exe' extension for the windows executable file
      go build -o $FILENAME.exe $PACKET || exit 10
      ARCHFILE=$FILENAME"_"$VERSION"_"$GOOS"_"$GOARCH".zip"
      
      RenameARCH      

      zip -m $ARCHFILE $FILENAME".exe"

    else
      go build -o $FILENAME $PACKET || exit 10
      ARCHFILE=$FILENAME"_"$VERSION"_"$GOOS"_"$GOARCH".gz"

      RenameARCH      
	      
      gzip $FILENAME
      mv $FILENAME".gz" $ARCHFILE
  fi  
  
  # Add checksum of the archive
  sha256sum $ARCHFILE >> $CHECKSUMFILE
  
done < $PLATF

# Remove temp file
rm $PLATF

exit 0


