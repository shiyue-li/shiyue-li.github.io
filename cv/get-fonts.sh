#!/bin/sh
# Downloads the CV's fonts into cv/fonts/ (about 34 MB, not kept in git):
# Shippori Mincho and Yuji Mai, both under the SIL Open Font License, from
# Google Fonts' repository. Files already there are kept.
set -e
dir="$(dirname "$0")/fonts"
mkdir -p "$dir"
base=https://raw.githubusercontent.com/google/fonts/main/ofl
for f in shipporimincho/ShipporiMincho-Regular.ttf \
         shipporimincho/ShipporiMincho-SemiBold.ttf \
         shipporimincho/ShipporiMincho-ExtraBold.ttf \
         yujimai/YujiMai-Regular.ttf; do
  [ -f "$dir/$(basename "$f")" ] || curl -sSfL -o "$dir/$(basename "$f")" "$base/$f"
done
