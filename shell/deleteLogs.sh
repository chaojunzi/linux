#!/bin/bash
cd /logs/wolf-burst
find ./ -mtime +30  -name '*.log'  -exec 'rm' -rf {} \;
