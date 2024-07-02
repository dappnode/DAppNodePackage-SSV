#!/bin/sh

OPERATOR_CONFIG_DIR=${OPERATOR_DATA_DIR}/config
DKG_LOGS_DIR=${DKG_DATA_DIR}/logs
DKG_OUTPUT_DIR=${DKG_DATA_DIR}/output
DKG_CERT_DIR=${DKG_DATA_DIR}/ssl

PRIVATE_KEY_FILE=${OPERATOR_CONFIG_DIR}/encrypted_private_key.json
PRIVATE_KEY_PASSWORD_FILE=${OPERATOR_CONFIG_DIR}/private_key_password
OPERATOR_ID_FILE=${OPERATOR_CONFIG_DIR}/operator_id.txt
DKG_CONFIG_FILE=${DKG_CONFIG_DIR}/dkg-config.yml
DKG_LOG_FILE=${DKG_LOGS_DIR}/dkg.log

CERT_FILE="$DKG_CERT_DIR/tls.crt"
KEY_FILE="$DKG_CERT_DIR/tls.key"

create_directories() {
    mkdir -p "${DKG_CONFIG_DIR}" "${DKG_LOGS_DIR}" "${DKG_OUTPUT_DIR}"
}

wait_for_private_key() {
    echo "[INFO] Waiting for the operator service to create the private key file..."
    while [ ! -f "${PRIVATE_KEY_FILE}" ]; do
        echo "[INFO] Waiting for ${PRIVATE_KEY_FILE} to be created..."
        inotifywait -e create -qq "$(dirname "${PRIVATE_KEY_FILE}")"
    done

    echo "[INFO] Private key file found."

    if [ ! -f "${PRIVATE_KEY_PASSWORD_FILE}" ]; then
        echo "[ERROR] ${PRIVATE_KEY_PASSWORD_FILE} not found. Cannot continue without the private key password file. Restarting dkg service..."
        exit 1 # To avoid restart loop
    fi
}

get_operator_id() {
    if [ -z "${OPERATOR_ID}" ]; then

        # Read operator ID from the file if it exists and is not empty
        if [ -f "${OPERATOR_ID_FILE}" ] && [ -s "${OPERATOR_ID_FILE}" ]; then
            OPERATOR_ID=$(cat "${OPERATOR_ID_FILE}")
            echo "[INFO] Using OPERATOR_ID from the file: ${OPERATOR_ID}"
        else
            fetch_operator_id_from_api
        fi
    else
        echo "[INFO] Using provided OPERATOR_ID: ${OPERATOR_ID}"
        echo "${OPERATOR_ID}" >"${OPERATOR_ID_FILE}"
    fi
}

fetch_operator_id_from_api() {
    echo "[INFO] OPERATOR_ID not provided. Fetching OPERATOR_ID from the API..."

    PUBLIC_KEY=$(jq -r '.pubKey' "${PRIVATE_KEY_FILE}")

    # If the PUBLIC_KEY is empty, try extracting using the '.publicKey' field (for previous SSV versions)
    if [ -z "$PUBLIC_KEY" ] || [ "$PUBLIC_KEY" = "null" ]; then
        PUBLIC_KEY=$(jq -r '.publicKey' "${PRIVATE_KEY_FILE}")
    fi

    # Fetch the operator ID using the public key (retry 50 times with a delay of 10mins)
    RESPONSE=$(curl --retry 50 --retry-delay 600 "https://api.ssv.network/api/v4/${NETWORK}/operators/public_key/${PUBLIC_KEY}")

    OPERATOR_ID=$(echo "${RESPONSE}" | jq -r '.data.id')

    # Check if OPERATOR_ID is successfully retrieved
    if [ -z "${OPERATOR_ID}" ] || [ "${OPERATOR_ID}" = "null" ]; then
        echo "[ERROR] Failed to fetch OPERATOR_ID from the API. Is your operator registered on the SSV network?"
        echo "[INFO] Once registered, set OPERATOR_ID in the package config to perform the DKG or restart the dkg service to retry fetching it from the SSV API."
        sleep 10m # To allow restoring backup
        exit 0
    else
        echo "[INFO] Successfully fetched OPERATOR_ID: ${OPERATOR_ID}"
        echo "${OPERATOR_ID}" >"${OPERATOR_ID_FILE}"
    fi
}

generate_tls_cert() {
    echo "[INFO] Generating TLS certificates..."

    mkdir -p "$DKG_CERT_DIR"

    # Generate a self-signed SSL certificate only if it doesn't exist
    if [ ! -f "$CERT_FILE" ] || [ ! -f "$KEY_FILE" ]; then
        echo "[INFO] Certificate or key file not found. Generating new SSL certificate and key."
        openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
            -keyout "$KEY_FILE" -out "$CERT_FILE" \
            -subj "/C=IL/ST=Tel Aviv/L=Tel Aviv/O=Coin-Dash Ltd/CN=*.ssvlabs.io"
    else
        echo "[INFO] Existing SSL certificate and key found. Using them."
    fi
}

start_dkg() {
    exec /bin/ssv-dkg start-operator \
        --operatorID "${OPERATOR_ID}" \
        --configPath "${DKG_CONFIG_FILE}" \
        --logFilePath "${DKG_LOG_FILE}" \
        --logLevel "${LOG_LEVEL}" \
        --outputPath "${DKG_OUTPUT_DIR}" \
        --port "${DKG_PORT}" \
        --privKey "${PRIVATE_KEY_FILE}" \
        --privKeyPassword "${PRIVATE_KEY_PASSWORD_FILE}" \
        --serverTLSCertPath "${CERT_FILE}" \
        --serverTLSKeyPath "${KEY_FILE}"
}

main() {
    create_directories
    wait_for_private_key
    get_operator_id
    generate_tls_cert
    start_dkg
}

main
