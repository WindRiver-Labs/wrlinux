#!/bin/sh

echo -ne   "\n"
echo "****Robust testcase will run!****"

ERROR=0
fno=1
while((fno<=8))
do
  echo -ne   "\n"
  echo     "*****************************"
  echo     "******tst-robust${fno} start******"
  echo -ne "*****************************\n"

  nptl/tst-robust${fno}
if [ $? -eq 0 ]; then
	echo 
	echo "******tst-robust${fno} pass******"
else
	echo
	echo "******tst-robust${fno} fail******"
	ERROR=1;
fi
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

  nptl/tst-robustpi${fno}
if [ $? -eq 0 ]; then
        echo 
        echo "******tst-robustpi${fno} pass******"
else
        echo
        echo "******tst-robustpi${fno} fail******"
	ERROR=1;
fi
  echo "*****tst-robustpi${fno} end*****"
  let fno=$fno+1
done

echo -ne   "\n"
echo "****Robust testcase end****"

if [ ERROR = 1 ]; then
exit 1;
fi

