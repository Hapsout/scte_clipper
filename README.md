# SCTE Clipper

This script creates audio segments (in WAV format) for each segment of a TS file, separated by Time Signal SCTE35 markers.

## Installation 

To operate, you must first install:
- jq: brew install jq
- ffmpeg (and ffprobe)
- scte35-threefive: https://github.com/futzu/scte35-threefive
