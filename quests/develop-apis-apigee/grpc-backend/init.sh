# retrieve GOOGLE_PROJECT_ID
MYDIR="$(dirname "$0")"
source "${MYDIR}/config.sh"

if [[ -z "${GOOGLE_PROJECT_ID}" ]]; then
  echo "GOOGLE_PROJECT_ID not set"
  exit 1
fi

# enable Cloud Run APIs
gcloud services enable run.googleapis.com

# create service account for Cloud Run service
gcloud iam service-accounts create simplebank-grpc \
  --display-name="Simplebank(gRPC) service account" \
  --project=${GOOGLE_PROJECT_ID}

# add permission to access firestore (datastore in firestore mode)
gcloud projects add-iam-policy-binding ${GOOGLE_PROJECT_ID} \
  --member="serviceAccount:simplebank-grpc@${GOOGLE_PROJECT_ID}.iam.gserviceaccount.com" \
  --role="roles/datastore.user"
