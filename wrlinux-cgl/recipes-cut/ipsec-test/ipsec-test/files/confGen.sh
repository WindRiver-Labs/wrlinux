#!/bin/sh

# Generate swanctl.conf for both targets

# source target info
#
. /opt/cut/ipsec-strongswan/ipsec_cut_config.sh

cat > swanctl-lcl.conf << EOF
connections {

   host-host {
      local_addrs  = ${lclIP}
      remote_addrs = ${rmtIP}

      local {
         auth = psk
         id = ${lclIP}
      }
      remote {
         auth = psk
         id = ${rmtIP}
      }
      children {
         host-host {
            esp_proposals = aes128gcm128-x25519
            mode = tunnel
         }
      }
      version = 2
      mobike = no
      proposals = aes128-sha256-x25519
   }
}

secrets {
      ike-host-host {
         id = ${rmtIP}
         secret = 0sv+NkxY9LLZvwj4qCC2o/gGrWDF2d21jL
    }
}
EOF

cat > swanctl-rmt.conf << EOF
connections {

   host-host {
      local_addrs  = ${rmtIP}
      remote_addrs = ${lclIP}

      local {
         auth = psk
         id = ${rmtIP}
      }
      remote {
         auth = psk
         id = ${lclIP}
      }
      children {
         host-host {
            esp_proposals = aes128gcm128-x25519
            mode = tunnel
         }
      }
      version = 2
      mobike = no
      proposals = aes128-sha256-x25519
   }
}

secrets {
      ike-host-host {
         id = ${lclIP}
         secret = 0sv+NkxY9LLZvwj4qCC2o/gGrWDF2d21jL
    }
}
EOF
