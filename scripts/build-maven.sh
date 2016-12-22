#!/bin/ash
#
# All UPERCASE variables are provided externally from this script

set -e

version=$(cat version/number)

args="-DversionNumber=$version"
[ -n "$MAVEN_REPO_MIRROR" ] && args="$args -Drepository.url=$MAVEN_REPO_MIRROR";
[ -n "$MAVEN_REPO_USERNAME" ] && args="$args -Drepository.username=$MAVEN_REPO_USERNAME";
[ -n "$MAVEN_REPO_PASSWORD" ] && args="$args -Drepository.password=$MAVEN_REPO_PASSWORD";

echo "MAVEN_OPTS=$MAVEN_OPTS"
echo "MAVEN_CONFIG=$MAVEN_CONFIG"
echo "args=$args"

cd project
  ./mvnw clean package $args
cd ..

cp project/target/$ARTIFACT_ID-$version.jar build-output/.
