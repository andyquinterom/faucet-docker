#!/bin/bash

function build_and_publish() {

    FAUCET_VERSION=$1
    R_VERSION=$2

    IMAGE_NAME="andyquinterom/faucet"
    VERSION="$FAUCET_VERSION-r$R_VERSION"

    TAG_NAME="$IMAGE_NAME:$VERSION"

    echo "Building and publishing $TAG_NAME"
    docker build --no-cache --pull -t $TAG_NAME --build-arg FAUCET_VERSION=$FAUCET_VERSION --build-arg R_VERSION=$R_VERSION .
    docker push $TAG_NAME

}

SUPPORTED_R_VERSION=(
    4.3
    4.2
    4.1
    4.0
)

SUPPORTED_FAUCET_VERSION=(0.4.1)

for faucet_version in "${SUPPORTED_FAUCET_VERSION[@]}"
do
    for r_version in "${SUPPORTED_R_VERSION[@]}"
    do
        build_and_publish $faucet_version $r_version
    done
done
