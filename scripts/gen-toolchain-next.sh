#!/bin/bash

started=false
recipe=""
layer=""
version=""

# Capture the highest version number available
GCCVERSION=""
SDKGCCVERSION="\${GCCVERSION}"
BINUVERSION=""
GDBVERSION=""
LINUXLIBCVERSION=""
QEMUVERSION=""
GOVERSION=""

# Input: $1 $2
# Output:
#   0 - $1 > $2
#   1 - $1 <= $2
#   2 - version comparison error (exit)

vercmp()
{
   local versionA="$1"
   local versionB="$2"

   local localVersionA=""
   local localVersionB=""

   local isNum_re='^[0-9]+$'
   local isAlpha_re='^[a-zA-Z]+$'

   # The idea is to compare chunks..
   # We first split at the first non-alphanumeric (partVer / Remainder)
   #  Take the partVer and then figure out what the first character type is
   #    split this based on the character type
   #      compare it chunk by chunk, alphabetically or numerically
   #        return if the comparison result is clear
   #      repeat until all chunks are verified..
   #  repeat until there is no longer a remainder..

   # Fast path, check if they're equal and return
   if [ "$versionA" = "$versionB" ]; then
      return 1
   fi

   while [ -n "$versionA" -a -n "$versionB" ]; do
      # Split on the first non-alphaNumeric character (usually a '.')
      localVersionA=${versionA/[!0-9a-zA-Z]/ }
      localVersionB=${versionB/[!0-9a-zA-Z]/ }

      # Now split on the space (or clear version)
      if [ "${localVersionA}" != "${versionA}" ]; then
         versionA=${localVersionA##* }      # Move versionA to after space
         localVersionA=${localVersionA%% *} # Move localVersionA to before space
      else
         versionA=""
      fi

      if [ "${localVersionB}" != "${versionB}" ]; then
         versionB=${localVersionB##* }      # Move versionB to after space
         localVersionB=${localVersionB%% *} # Move localVersionB to before space
      else
         versionB=""
      fi

      local localNextVersionA=${localVersionA}
      local localNextVersionB=${localVersionB}

      while [ -n "$localNextVersionA" -o -n "$localNextVersionB" ]; do
         localVersionA=${localNextVersionA}
         localVersionB=${localNextVersionB}

         # We break this based on version A and what the first char is
         if [[ ${localVersionA:0:1} =~ $isNum_re ]]; then
            local re='(^[0-9]+)(.*)'
         else
            local re='(^[a-zA-Z]+)(.*)'
         fi

         [[ ${localVersionA} =~ $re ]]
         localVersionA=${BASH_REMATCH[1]}
         localNextVersionA=${BASH_REMATCH[2]}

         [[ ${localVersionB} =~ $re ]]
         localVersionB=${BASH_REMATCH[1]}
         localNextVersionB=${BASH_REMATCH[2]}

         # If they are the same move to the next block
         if [ "$localVersionA" = "$localVersionB" ]; then
            continue
         fi

         # Do either values start with Alphabetic?  If so we compare Alphabetic
         if [[ ${localVersionA} =~ $isAlpha_re || ${localVersionB} =~ $isAlpha_re ]]; then
            if [ "$localVersionA" \> "$localVersionB" ]; then return 0 ; fi
            if [ "$localVersionA" \< "$localVersionB" ]; then return 1 ; fi
         # Must be a numerical comparison, verify they are both numbers...
         elif [[ ${localVersionA} =~ $isNum_re && ${localVersionB} =~ $isNum_re ]]; then
            if [ "$localVersionA" -gt "$localVersionB" ]; then return 0 ; fi
            if [ "$localVersionA" -lt "$localVersionB" ]; then return 1 ; fi
         else
         # Should never get here... but it's an error if we do
            echo "Comparison error: ${localVersionA} ?= ${localVersionB}" >&2
            exit 2
         fi

         # We have a mix, and need to keep going
      done
   done

   # If versionA isn't empty it had more stuff, so it's the winner
   if [ -n "$versionA" ]; then
      return 0
   fi

   # A is <= to B
   return 1
}

recipe_parse() {
   while read line; do
      if [ "$line" == "NOTE: Starting bitbake server..." -o "$line" == "NOTE: Reconnecting to bitbake server..." ]; then
         started=false
      fi
      if $started; then
         # Is this a new recipe name?
         if [ "${line%%:}" != "${line}" ]; then
            # store and reset the values
            recipe=${line%%:}
            layer=""
            version=""
         else
            local re='(^[a-zA-Z0-9]+)[[:space:]]+([^[:space:]]*)'

            [[ ${line} =~ $re ]]
            layer=${BASH_REMATCH[1]}
            version=${BASH_REMATCH[2]}

            case $recipe in
               gcc)
                  if vercmp "${version}" "${GCCVERSION}" ; then
                     GCCVERSION="${version}"
                  fi
                  ;;
               binutils)
                  if vercmp "${version}" "${BINUVERSION}" ; then
                     BINUVERSION="${version}"
                  fi
                  ;;
               gdb)
                  if vercmp "${version}" "${GDBVERSION}" ; then
                     GDBVERSION="${version}"
                  fi
                  ;;
               glibc)
                  if vercmp "${version}" "${GLIBCVERSION}" ; then
                     GLIBCVERSION="${version}"
                  fi
                  ;;
               linux-libc-headers)
                  if vercmp "${version}" "${LINUXLIBCVERSION}" ; then
                     LINUXLIBCVERSION="${version}"
                  fi
                  ;;
               qemu)
                  if vercmp "${version}" "${QEMUVERSION}" ; then
                     QEMUVERSION="${version}"
                  fi
                  ;;
               go)
                  if vercmp "${version}" "${GOVERSION}" ; then
                     GOVERSION="${version}"
                  fi
                  ;;
            esac
         fi
      else
         # Skip the headers
         if [ "$line" == "=== Available recipes: ===" -o "$line" == "=== Matching recipes: ===" ]; then
            started=true
            continue
         fi
       fi
   done
}

selftest()
{
   # Selftest of vercmp
   echo 'vercmp "" "1"' >&2
   vercmp "" "1"
   rc=$?
   echo $rc >&2
   if [ $rc -eq 0 ] ; then
      echo "Self test failure!" >&2
      exit 1
   fi

   echo 'vercmp "1" ""' >&2
   vercmp "1" ""
   rc=$?
   echo $rc >&2
   if [ $rc -eq 1 ] ; then
      echo "Self test failure!" >&2
      exit 1
   fi

   echo 'vercmp "1" "1"' >&2
   vercmp "1" "1"
   rc=$?
   echo $rc >&2
   if [ $rc -eq 0 ] ; then
      echo "Self test failure!" >&2
      exit 1
   fi

   echo 'vercmp "1" "2"' >&2
   vercmp "1" "2"
   rc=$?
   echo $rc >&2
   if [ $rc -eq 0 ] ; then
      echo "Self test failure!" >&2
      exit 1
   fi

   echo 'vercmp "2" "1"' >&2
   vercmp "2" "1"
   rc=$?
   echo $rc >&2
   if [ $rc -ne 0 ] ; then
      echo "Self test failure!" >&2
      exit 1
   fi

   echo 'vercmp "1.0.1" "1.0.1a"' >&2
   vercmp "1.0.1" "1.0.1a"
   rc=$?
   echo $rc >&2
   if [ $rc -eq 0 ] ; then
      echo "Self test failure!" >&2
      exit 1
   fi

   echo 'vercmp "1.0.1a" "1.0.1"' >&2
   vercmp "1.0.1a" "1.0.1"
   rc=$?
   echo $rc >&2
   if [ $rc -ne 0 ] ; then
      echo "Self test failure!" >&2
      exit 1
   fi

   echo 'vercmp "1.0.1a" "1.0.1b"' >&2
   vercmp "1.0.1a" "1.0.1b"
   rc=$?
   echo $rc >&2
   if [ $rc -eq 0 ] ; then
      echo "Self test failure!" >&2
      exit 1
   fi

   echo 'vercmp "1.0.1b" "1.0.1a"' >&2
   vercmp "1.0.1b" "1.0.1a"
   rc=$?
   echo $rc >&2
   if [ $rc -ne 0 ] ; then
      echo "Self test failure!" >&2
      exit 1
   fi

   echo "Self test passed." >&2
}

# Uncomment to enable the selftests... 
#selftest

TMPFILE=`mktemp`

bitbake-layers show-recipes gcc binutils gdb glibc linux-libc-headers qemu go 2>/dev/null 1>$TMPFILE

recipe_parse <$TMPFILE
rm -f $TMPFILE

echo "# This file is automatically generated."
echo "#"
echo "# Any manual changes will be overwritten."
echo "#"
echo "# Latest in-development versions"
echo
echo "WRLINUX_BRANCH_append = '_toolchain-next'"
echo
echo "GCCVERSION = '${GCCVERSION}'"
echo "SDKGCCVERSION = '${SDKGCCVERSION}'"
echo "BINUVERSION = '${BINUVERSION}'"
echo "GDBVERSION = '${GDBVERSION}'"
echo "GLIBCVERSION = '${GLIBCVERSION}'"
echo "LINUXLIBCVERSION = '${LINUXLIBCVERSION}'"
echo "QEMUVERSION = '${QEMUVERSION}'"
echo "GOVERSION = '${GOVERSION}'"


