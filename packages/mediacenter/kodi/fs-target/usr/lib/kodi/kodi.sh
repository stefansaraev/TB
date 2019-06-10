#!/bin/sh
#      Copyright (C) 2008-2013 Team XBMC
#      http://xbmc.org
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.

. /etc/profile

trap cleanup TERM

CRASHLOG_DIR=/storage/.kodi/temp
EXIT=0

cleanup() {
  EXIT=1
  while killall -0 kodi.bin &>/dev/null; do
    sleep 0.5
  done
}

command_exists()
{
  command -v $1 &>/dev/null
}

single_stacktrace()
{
  # core filename is "core.*kodi.bin.*"
  find "$1" -name 'core.*kodi.bin.*' | while read core; do
    echo "=====>  Core file: "$core"" >> $FILE
    echo "        =========================================" >> $FILE
    gdb /usr/lib/kodi/kodi.bin --core="$core" --batch -ex "thread apply all bt" 2>/dev/null >> $FILE
    rm -f "$core"
  done
}

print_crash_report()
{
  if [ ! -d $CRASHLOG_DIR ] ; then
    mkdir -p $CRASHLOG_DIR
  fi
  FILE="$CRASHLOG_DIR/kodi_crashlog.log"
  if [ -f $FILE ] ; then
    mv $FILE $FILE.old
  fi
  echo "############## kodi CRASH LOG ###############" > $FILE
  echo >> $FILE
  echo "################ SYSTEM INFO ################" >> $FILE
  echo -n " Date: " >> $FILE
  date >> $FILE
  echo -n " Kernel: " >> $FILE
  uname -a >> $FILE
  echo "############## END SYSTEM INFO ##############" >> $FILE
  echo >> $FILE
  echo "############### STACK TRACE #################" >> $FILE
  if command_exists gdb; then
    single_stacktrace $CRASHLOG_DIR
  else
    echo "gdb not installed, can't get stack trace." >> $FILE
  fi
  echo "############# END STACK TRACE ###############" >> $FILE
  echo >> $FILE
  echo "################# LOG FILE ##################" >> $FILE
  echo >> $FILE
  cat /storage/.kodi/temp/kodi.log >> $FILE
  echo >> $FILE
  echo "############### END LOG FILE ################" >> $FILE
  echo >> $FILE
  echo "############ END kodi CRASH LOG #############" >> $FILE
  echo "Crash report available at $FILE"
}

if command_exists gdb; then
  mkdir -p $CRASHLOG_DIR
  echo "$CRASHLOG_DIR/core.%e.%t" > /proc/sys/kernel/core_pattern
  ulimit -c unlimited
fi

while : ; do
  if [ "$EXIT" == "1" ] ; then
    break
  fi
  # clean up any stale cores. just in case
  rm -f $CRASHLOG_DIR/core.*

  export MALLOC_MMAP_THRESHOLD_=524288

  /usr/lib/kodi/kodi.bin --standalone -fs
  RET=$?

  if [ $(( ($RET >= 131 && $RET <= 136) || $RET == 139 )) = "1" ] ; then
    # Crashed with core dump
    print_crash_report
  fi
  sleep 1
done

exit $RET
