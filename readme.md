#1.Open cloud shell  and export and set the project

export PROJECT_ID="liveability-final"   
gcloud config set project ${PROJECT_ID}
git clone https://github.com/liveabilityment360/mvp-liveability-setup

#2.bash to create service account for cloud build
cd mvp-liveability-setup
bash CloudBuild_SvcAccount_Setup.sh

#3.Create trigger for intial setup. Use "initial_account_setup_cloudbuild.yaml"
#4. Create trigger for terraform. "Use terraform-cloudbuild.yaml"
#5.create trigger for tables.Use "ddl_cloudbuild.yaml"
#6.create trigger for datastream. Use "datastream_cloudbuild.yaml"

till here we will be setting up before the demo

In demo
----------
1.Click the trigger for inital setup
2, click the trigger for terraform
3.click the trigger for table creation
4. Click the trigger for datastream


Now run dataflow (not able to figure out how to use cloud composer to trigger till now)
--------------------
cd ..
cd mvp-liveability-setup
cd dataflow
bash dataflow_run.sh

Then in the already set up project
--------------------
show DBT, datastudio and geoviz
Then show the result in app sheet too


If the git clone asks for username and pwd
-----------------------------------------
Username for github =liveabilityment360
password=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




