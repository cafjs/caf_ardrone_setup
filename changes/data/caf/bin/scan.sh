#!/bin/sh
iwlist scanning | egrep 'Address|Signal' > /tmp/foo
cat /tmp/foo | egrep 'Address' | awk '{print $5}' > /tmp/foo.1
cat /tmp/foo | egrep 'level' | awk '{print $3}' | sed 's/level=//' > /tmp/foo.2

awk 'BEGIN {OFS=" "}{
  getline line < "/tmp/foo.2"
    print $0, line
} ' /tmp/foo.1
    
