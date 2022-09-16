# Scripts for rolling back the project resources.
export PROJECT_ID="liveability-final"
export LOCATION="australia-southeast1"
export SERVICE_ACCOUNT_ID="sa-liveability-final"

export MYSQL_INSTANCE="liveability-mysql-instance"
export MYSQL_PORT="3306"
export MYSQL_USER="datastream"
export MYSQL_PASS="12345678"


#Parameters for the Datastream Connection Profile generation.
export MYSQL_CONN_PROFILE="liveability-mysql-conprofile"
export GCS_CONN_PROFILE="liveability-gcs-conprofile"
export GCS_DS_PATH_PREFIX="/data/stream_data/"
export DS_PUBSUB_TOPIC="liveability-pubsub-topic"
export DS_PUBSUB_SUBSCRIPTION="liveability-pubsub-subscription"
export DS_DIR_PATH="data/stream_data/"
export DS_DATAFLOW_REPLICATION="liveability-dataflow-replication"

#Parameters for the Datastream creation.
export DS_MYSQL_GCS_NAME="liveability-mysql-to-gcs-stream"
export DS_SOURCE_JSON="mysql_source_user_activities_config.json"
export DS_TARGET_JSON="gcs_destination_user_activities_config.json"



export BQ_DATASET="liveability"

# Sets the project in the shell
gcloud config set project ${PROJECT_ID}

# Cancelling Dataflow job
gcloud dataflow jobs cancel ${DS_DATAFLOW_REPLICATION} --force --region=${LOCATION}

# Rollback the Datastream set up
gcloud datastream streams delete ${DS_MYSQL_GCS_NAME} --location=${LOCATION}
gcloud datastream connection-profiles delete ${GCS_CONN_PROFILE} --location=${LOCATION}
gcloud datastream connection-profiles delete ${MYSQL_CONN_PROFILE} --location=${LOCATION}

# Removes the pubsub notification on GCS bucket.
gsutil notification delete projects/_/buckets/${PROJECT_ID}/notificationConfigs/*

# Removes the pubsub topic and subsctiption.
gcloud pubsub subscriptions delete ${DS_PUBSUB_SUBSCRIPTION}
gcloud pubsub topics delete ${DS_PUBSUB_TOPIC}

# Delete the cloud sql instance
gcloud sql instances delete ${MYSQL_INSTANCE}



bq rm "liveability"

#Clean up the GCS bucket and its contents.
gsutil rm -r "gs://${PROJECT_ID}"
gsutil rb -f "gs://${PROJECT_ID}"

# To remove the service accounts we have.
gcloud iam service-accounts delete ${SERVICE_ACCOUNT_ID}@${PROJECT_ID}.iam.gserviceaccount.com

# Remove the project itself
#gcloud projects delete "${PROJECT_ID}"