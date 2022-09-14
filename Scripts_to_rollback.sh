# Scripts for rolling back the project resources.
export PROJECT_ID="mvp-liveability"
export LOCATION="australia-southeast1"
export BQ_DATASET="liveability"

 #13.Export the values for cloud sql
export MYSQL_INSTANCE="aus-liveability-demo-mysql"
export MYSQL_PORT="3306"
export MYSQL_USER="datastream"
export MYSQL_PASS="12345678"

#14.Parameters for the Datastream Connection Profile generation.
export MYSQL_CONN_PROFILE="liveability-mysql-cp"
export GCS_CONN_PROFILE="liveability-gcs-cp"
export GCS_DS_PATH_PREFIX="/data/stream_data/"
export DS_PUBSUB_TOPIC="liveability-topic"
export DS_PUBSUB_SUBSCRIPTION="liveability-subscription"
export DS_DIR_PATH="data/stream_data/"

#15.Parameters for the Datastream creation.
export DS_MYSQL_GCS_NAME="liveability-mysql-gcs-stream"
export DS_SOURCE_JSON="mysql_source_user_activities_config.json"
export DS_TARGET_JSON="gcs_destination_user_activities_config.json"



# Rollback the Datastream set up
gcloud datastream streams delete ${DS_MYSQL_GCS_NAME} --location=${LOCATION}
gcloud datastream connection-profiles delete ${GCS_CONN_PROFILE} --location=${LOCATION}
gcloud datastream connection-profiles delete ${MYSQL_CONN_PROFILE} --location=${LOCATION}

# Removes the pubsub topic and subsctiption.
gcloud pubsub subscriptions delete ${DS_PUBSUB_SUBSCRIPTION}
gcloud pubsub topics delete ${DS_PUBSUB_TOPIC}




# Sets the project in the shell
gcloud config set project ${PROJECT_ID}

# To remove the service accounts we have.
gcloud iam service-accounts delete ${SERVICE_ACCOUNT_ID}@${PROJECT_ID}.iam.gserviceaccount.com

#Clean up the GCS bucket.
gsutil rm -r "gs://${PROJECT_ID}"

# Remove the project itself
gcloud projects delete "${PROJECT_ID}"