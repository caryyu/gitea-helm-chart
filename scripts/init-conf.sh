#!/bin/bash
# ******************************************************************
# Please notice that this script is under the linux user of git
# ******************************************************************

# copy the immutable app.ini to the destination
cp /etc/gitea/conf/app.ini \
  /data/gitea/conf/app.ini

gitea migrate

echo "check if it already obtains an admin user"
gitea admin change-password \
  --username $ADMIN_USER \
  --password $ADMIN_PASSWORD

if [ $? == 1 ]; then
  echo "create a new admin user"
  gitea admin create-user \
    --username $ADMIN_USER \
    --password $ADMIN_PASSWORD \
    --email $ADMIN_EMAIL --admin
else
  echo "skip the admin creating "
fi

if [ "$AUTH_NAME" != "" ]; then
  NAME=`gitea admin auth list | \
          grep 'ID Name Type Enabled' | \
             awk '{print $5}'`

  if [ $NAME != $AUTH_NAME ]; then
    echo "configure a sso authentication"
    gitea admin auth add-oauth \
      --name $AUTH_NAME \
      --provider $AUTH_PROVIDER \
      --key $AUTH_KEY \
      --secret $AUTH_SECRET \
      --auto-discover-url $AUTH_AUTODISCOVER_URL
  else
    echo "skip sso authentication"
  fi

fi