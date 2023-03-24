#!/bin/bash

# Preencher o nome do servidor
SERVIDOR=meleca_srv
# Prencher o SITE = URL = CN
SITE=tiag0.com.br
NUM=001
if [[ "${SERVIDOR}" == "" || "${SITE}" == "" ]]; then
    echo
    echo "Preencha os campos abaixo"
    echo "#Preencha o nome do servidor"
    echo "Ex: Servidor=brilnxsupweb101"
    echo
    echo "# Preencha o SITE = URL = CN"
    echo "Ex: SITE=portal.portal.com"
    echo
    exit 1
fi
CONFIGFILE=${SITE}.${NUM}.req.config
echo "[req]
distinguished_name = req_distinguished_name
req_extensions = v3_req
prompt = no
[req_distinguished_name]
C = BR
ST = Parana
L = Curitiba
O = TIAG0_BR
OU = OPERACAO
CN = ${SITE}
[v3_req]
subjectAltName = @alt_names
[alt_names]
DNS.1 = ${SITE}
" > ${CONFIGFILE}
openssl req -out ${SERVIDOR^^}-${SITE}-${NUM}.csr -new -newkey rsa:2048 -sha256 -nodes -keyout ${SERVIDOR^^}-${SITE}-${NUM}.key -config ${CONFIGFILE}
ls -l ${SERVIDOR^^}-${SITE}-${NUM}.csr
cat ${SERVIDOR^^}-${SITE}-${NUM}.csr
zip ${SERVIDOR^^}-${SITE}-${NUM}.csr.zip ${SERVIDOR^^}-${SITE}-${NUM}.csr
