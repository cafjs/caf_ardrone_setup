#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $DIR
pushd "${DIR}/.."

ESSID=${ESSID:-'T-Mobile-Parrot1'}

WIFI_PASS=${WIFI_PASS:-'pleasechange'}

WPA_SUPPLICANT_CONF=${WPA_SUPPLICANT_CONF:-'/tmp/wpa_supplicant.conf'}

CAF_HOME_REL=${CAF_HOME_REL:-'data/caf'}

CAF_APP_REPO_DIR=${CAF_APP_REPO_DIR:-'application'}

rm -fr /tmp/changes
cp -r changes /tmp
cd /tmp/changes/

# first wlan
wpa_passphrase $ESSID $WIFI_PASS > etc/wpa_supplicant.conf
touch ${WPA_SUPPLICANT_CONF}
cat ${WPA_SUPPLICANT_CONF} >> etc/wpa_supplicant.conf

#Second app with no soft-links (created by `npm link`)
rm -fr /tmp/${CAF_APP_REPO_DIR}
cp -r ${CAF_HOME_REL}/${CAF_APP_REPO_DIR} /tmp/
cd /tmp/${CAF_APP_REPO_DIR}
npm install --link
npm shrinkwrap
cd /tmp
#   note we use `h` option to follow links
tar --exclude=.git  -c -h -v -f ${CAF_APP_REPO_DIR}.tar ${CAF_APP_REPO_DIR}
cd /tmp/changes
rm -fr ${CAF_HOME_REL}/${CAF_APP_REPO_DIR}
cd ${CAF_HOME_REL}
tar xvf /tmp/${CAF_APP_REPO_DIR}.tar

#Finally, just create tar with links
cd /tmp/changes
#  note we do not follow links because libs need soft links
tar --exclude=.git -c -v -z -f ../changes.tar.gz .
popd

