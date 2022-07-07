#!/bin/bash

rsync -auv --delete --exclude-from='exclude-file.txt' /mnt/d/Nutstore/wiki/ docs/

