#!/bin/bash

ids="$(aerospace list-windows --workspace focused --format '%{window-id}')"
[ -n "$ids" ] || exit 0

for id in $ids; do
    aerospace focus --window-id "$id"
    aerospace layout tiling
done

aerospace layout tiles vertical
