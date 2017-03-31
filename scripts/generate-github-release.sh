#!/bash

version=$(cat version/version)

echo v${version} > generate-github-release-output/release-name
echo v${version} > generate-github-release-output/release-tag
