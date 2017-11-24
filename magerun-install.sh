#!/bin/bash -x

rm -rf "$MAGE_ROOT_DIR/*"

/n98-magerun.phar install --root-dir="$MAGE_ROOT_DIR" --installationFolder="$MAGE_ROOT_DIR" \
    --dbHost="$MAGE_DB_HOST" --dbUser="$MAGE_DB_USER" --dbPass="$MAGE_DB_PASS" --dbName="$MAGE_DB_NAME" \
    --installSampleData="$MAGE_WITH_SAMPLE_DATA" --magentoVersionByName="$MAGE_VERSION_NAME" \
    --baseUrl="$MAGE_BASE_URL" --useDefaultConfigParams=yes $@