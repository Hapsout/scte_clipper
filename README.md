# SCTE Clipper

This script creates audio segments (in WAV format) for each segment of a TS file, separated by Time Signal SCTE35 markers.

## Installation (Tested only on Mac but should work on other platforms)

1 °) Install the following dependencies:

- jq: ```brew install jq```
- ffmpeg (and ffprobe) : ```brew install ffmpeg```
- scte35-threefive: https://github.com/futzu/scte35-threefive

2 °) Download the ``` scte_clipper.sh ``` file and install it in ``` /usr/local/bin ```

3 °) Add excussion rights ```sudo chmod +x /usr/local/bin/scte_clipper.sh```

4 °) Relaunch your terminal
