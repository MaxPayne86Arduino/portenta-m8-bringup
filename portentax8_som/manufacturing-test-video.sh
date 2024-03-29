#!/bin/bash

verbose=0
fail=0

echo ""
echo "*************************START MANUFACTURING-TEST-VIDEO*************************"
echo ""

if [[ $1 == "-v" ]]; then
   echo "Verbose mode"
   let verbose=1
fi

# Send the RGB frame
echo 0 > /sys/class/graphics/fbcon/cursor_blink
cat /unit_tests/Display/testcard-1920x1080-bgra.rgb > /dev/fb0

ret="$(echo $?)"
if [[ $ret != "0" ]]; then
  let fail=1
  if [ $verbose == 1 ]; then
      echo "Unable to write RGB image to framebuffer"
  fi
fi

echo ""
echo "**************************END MANUFACTURING-TEST-VIDEO**************************"
echo ""

if [ $fail == 1 ]; then
   echo "FAIL"
   echo ""
   echo ""
   exit 1
else
  echo "PASS"
   echo ""
   echo ""
  exit 0
fi