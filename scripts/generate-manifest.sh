#!/bin/bash
#
# All CF_* variables are provided externally from this script

set -e

# copy the artifact to the task-output folder
cp release/$CF_ARTIFACT_ID-*.jar generate-manifest-output/.

pushd prepare-manifest-output

ARTIFACT_PATH=$(ls $CF_ARTIFACT_ID-*.jar)

cat <<EOF >manifest.yml
---
applications:
- name: $CF_APP_NAME
  host: $CF_APP_HOST
  path: $ARTIFACT_PATH
  memory: ${CF_APP_MEMORY:512M}
  instances: ${CF_APP_INSTANCES:1}
  timeout: ${CF_APP_TIMEOUT:180}
  services: [ $CF_APP_SERVICES ]
  env:
    JAVA_OPTS: -Djava.security.egd=file:///dev/urandom
EOF

if [ "true" = "$CF_SKIP_SSL" ]; then
  echo "    CF_TARGET: $CF_API_URL" >> manifest.yml
fi

echo "Generated manifest:"
cat manifest.yml

popd
