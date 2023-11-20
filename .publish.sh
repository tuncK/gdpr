#!/bin/bash
set -ex
source /usr/local/rvm/environments/ruby-2.4.1
ruby --version
rvm --version
gem --version
gem install bundler
bundle install



TMP_DIR=$(mktemp -d)
git checkout master
bundler exec jekyll build -d $TMP_DIR
git checkout gh-pages
rm -rf *
cp -Rv $TMP_DIR/. .

git add .
git add --all *
git config --local user.name "UseGalaxy.EU Build Bot"
git config --local user.email "jenkins@usegalaxy.eu"

git commit -m "Update site ($BUILD_NUMBER)

$BUILD_URL"

git push origin gh-pages
rm -rf $TMP_DIR
