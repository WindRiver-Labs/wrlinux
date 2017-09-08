#!/bin/bash

echo -ne   "\n"
echo "****Robust testcase will run!****"

fno=1
while((fno<=8))
do
  echo -ne   "\n"
  echo     "*****************************"
  echo     "******tst-robust${fno} start******"
  echo -ne "*****************************\n"

  ./tst-robust${fno}
if...
  echo "*******tst-robust${fno} end*******"
  let fno=$fno+1
done

fno=1
while((fno<=8))
do
  echo -ne   "\n"
  echo     "*****************************"
  echo     "*****tst-robustpi${fno} start*****"
  echo -ne "*****************************\n"

  ./tst-robustpi${fno}
  echo "*****tst-robustpi${fno} end*****"
  let fno=$fno+1
done

echo -ne   "\n"
echo "****Robust testcase end****"


