#!/bin/bash

set -e

VERSION=$(cat version/number)

pushd project
  ./mvnw -PversionNumber=$VERSION clean package
popd

cp project/target/$ARTIFACT_ID-$VERSION.jar build-output/.
