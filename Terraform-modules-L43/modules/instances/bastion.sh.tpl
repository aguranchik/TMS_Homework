#! /bin/bash
cat <<EOF > ${path}
${key}
EOF
sudo chmod 444 /${path}
