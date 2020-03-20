#!/bin/bash
# ******************************************************************
# Please notice that this script is under the linux user of git
# ******************************************************************

# copy the immutable app.ini to the destination
cp /etc/gitea/conf/app.ini \
  /data/gitea/conf/app.ini

# retry until success
echo "[migration] Setup started"
while true; do 
  gitea migrate
  if [[ $? == 0 ]]; then 
    echo "[migration] Setup completed"
    break
  fi
  echo "[migration] Oops.. Perhaps database isn't ready, retry...."
  sleep 2
done

echo "[administrator] Setup started"
gitea admin change-password \
  --username $ADMIN_USER \
  --password $ADMIN_PASSWORD

if [ $? == 1 ]; then
  echo "[administrator] Let's create an entire new administrator"
  gitea admin create-user \
    --username $ADMIN_USER \
    --password $ADMIN_PASSWORD \
    --email $ADMIN_EMAIL --admin
else
  echo "[administrator] Found an administrator, creating skipped"
fi
echo "[administrator] Setup completed"

echo "[OAuth] Setup started"
if [ "$AUTH_NAME" != "" ]; then
  NAME=`gitea admin auth list | \
          grep 'ID Name Type Enabled' | \
             awk '{print $5}'`
  
  if [ "$NAME" != "$AUTH_NAME" ]; then
    echo "[OAuth] Let's configure OAuthN"
    gitea admin auth add-oauth \
      --name $AUTH_NAME \
      --provider $AUTH_PROVIDER \
      --key $AUTH_KEY \
      --secret $AUTH_SECRET \
      --auto-discover-url $AUTH_AUTODISCOVER_URL
  else
    echo "[OAuth] OAuthN skipped due to there's existing one already"
  fi
else
  echo "[OAuth] OAuthN skipped due to disabled"
fi

echo "[OAuth] Setup completed"