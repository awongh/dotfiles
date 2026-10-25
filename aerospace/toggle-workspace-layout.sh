#!/bin/bash

ids="$(aerospace list-windows --workspace focused \
  --format '%{window-id}')"

layouts="$(aerospace list-windows --workspace focused \
  --format '%{window-layout}')"

[ -n "$ids" ] || exit 0

# Float the workspace only when every window is already tiled.
if ! printf '%s\n' "$layouts" | grep -q 'floating'; then
    target="floating"
else
    target="tiling"
fi

for id in $ids; do
    aerospace focus --window-id "$id"
    aerospace layout "$target"
done

if [ "$target" = "tiling" ]; then
    aerospace layout tiles vertical
fi
