#!/bin/bash
# Write by Maruku Lin, lin.maruku@gmail.com
# Purpose: Change Root Password
# Date: 03-08/2022
# Version: 0.0.1
#######################

echo "Root New Password"
slappasswd > ${PWD}/rootPW

echo "Creating the changerootpw.ldif of file."
if [ -f ${PWD}/rootPW ]; then

ROOTPW=$( cat ${PWD}/rootPW )
#echo "Root PASSWORD:" $ROOTPW  #Debug Usage
cat > ${PWD}/changerootpw.ldif << EOFone
dn: olcDatabase={1}mdb,cn=config
changetype: modify
replace: olcRootPW
olcRootPW: ${ROOTPW}
EOFone

fi
echo "Changing the ROOT Password..."
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f changerootpw.ldif
echo "Done"
