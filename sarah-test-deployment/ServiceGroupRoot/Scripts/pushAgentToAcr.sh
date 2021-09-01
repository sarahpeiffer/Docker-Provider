#!/bin/bash
set -e

# Note - This script used in the pipeline as inline script

# These are plain pipeline variable which can be modified anyone in the team
# AGENT_RELEASE=ciev2
# AGENT_IMAGE_TAG_SUFFIX=08202021

#Name of the ACR for ciprod & cidev images
DESTINATION_ACR_NAME=containerinsightsprod
AGENT_IMAGE_FULL_PATH=${ACR_NAME}/public/azuremonitor/containerinsights/${AGENT_RELEASE}:${AGENT_RELEASE}${AGENT_IMAGE_TAG_SUFFIX}
AGENT_IMAGE_TAR_FILE_NAME=agentimage.tar.gz

if [ -z ${DESTINATION_ACR_NAME+x} ]; then
    echo "DESTINATION_ACR_NAME is unset, unable to continue"
    exit 1;
fi

if [ -z ${TARBALL_IMAGE_FILE_SAS+x} ]; then
    echo "TARBALL_IMAGE_FILE_SAS is unset, unable to continue"
    exit 1;
fi

if [ -z ${IMAGE_NAME+x} ]; then
    echo "IMAGE_NAME is unset, unable to continue"
    exit 1;
fi

if [ -z ${TAG_NAME+x} ]; then
    echo "TAG_NAME is unset, unable to continue"
    exit 1;
fi

if [ -z ${AGENT_IMAGE_TAR_FILE_NAME+x} ]; then
    echo "AGENT_IMAGE_TAR_FILE_NAME is unset, unable to continue"
    exit 1;
fi

#Install crane
echo "Installing crane"
wget -O crane.tar.gz https://github.com/google/go-containerregistry/releases/download/v0.4.0/go-containerregistry_Linux_x86_64.tar.gz
tar xzvf crane.tar.gz
echo "Installed crane"

echo "Login cli using managed identity"
az login --identity


echo "Getting acr credentials"
TOKEN_QUERY_RES=$(az acr login -n "$DESTINATION_ACR_NAME" -t)
TOKEN=$(echo "$TOKEN_QUERY_RES" | jq -r '.accessToken')
DESTINATION_ACR=$(echo "$TOKEN_QUERY_RES" | jq -r '.loginServer')
./crane auth login "$DESTINATION_ACR" -u "00000000-0000-0000-0000-000000000000" -p "$TOKEN"

if [[ "$AGENT_IMAGE_TAR_FILE_NAME" == *"tar.gz"* ]]; then
  gunzip $AGENT_IMAGE_TAR_FILE_NAME
fi

if [[ "$AGENT_IMAGE_TAR_FILE_NAME" == *"tar.zip"* ]]; then
  unzip $AGENT_IMAGE_TAR_FILE_NAME
fi

echo "Pushing file $TARBALL_IMAGE_FILE to $AGENT_IMAGE_FULL_PATH"
./crane push *.tar "$AGENT_IMAGE_FULL_PATH"