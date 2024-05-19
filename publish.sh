#!/bin/bash

trunk build --release --public-url ./
mkdir -p _publish_dir
git -C _publish_dir/ init
git -C _publish_dir/ config remote.origin.url >&- || git -C _publish_dir/ remote add origin $(git ls-remote --get-url origin)
git -C _publish_dir/ fetch
git -C _publish_dir/ checkout deploy || git -C _publish_dir/ checkout --orphan deploy
# Delete everything (except dotfiles, e.g. .git), so we don't end up w/ cruft hanging around
rm -rf _publish_dir/*
cp -Rn dist/ _publish_dir/
git -C _publish_dir/ add .
git -C _publish_dir/ commit -m "Publish - $(date "+%Y-%m-%d %H:%M:%S")"
git -C _publish_dir/ push --set-upstream origin deploy
rm -rf _publish_dir/
