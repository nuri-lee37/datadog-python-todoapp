# Datadog GCP Cloud Run Serverless App Monitoring
This is a todoapp which consists of python flask web framework, gcp cloudrun and datadog serverless agent.

![GCP Datadog Integration Architecture](https://github.com/nuri-lee37/datadog-python-todoapp/assets/144660787/ddb82bad-9cff-4e30-836f-a63df9b45560 "GCP Datadog Integration Architecture")

### 1. Build GCP cloudrun app
1. Build the app docker image
gcloud builds submit --tag gcr.io/<your gcp project id>/datadog-python-todoapp:v0.01

2. Deploy the cloudrun app
gcloud run deploy datadog-python-todoapp --image gcr.io/<your gcp project id>/datadog-python-todoapp:v0.01 --allow-unauthenticated

### 2. Connecting the app with Datadog GCP Integration for Serverless Observability
Configure GCP Integration by referring to this [guide](https://docs.datadoghq.com/integrations/google_cloud_platform/). 

By completing the GCP integration, you can monitor your serverless application under the Datadog Infrastructure -> Serverless menu. You can refer to this [introduction](https://www.datadoghq.com/blog/collect-traces-logs-from-cloud-run-with-datadog/) for GCP serverless monitoring introduction. 

### 3. GCP Serverless Datadog agent implementation for APM 
1. Datadog APM implementation for GCP Serverless app
The app Dockerfile already contains the serverless application APM integration part. You can refer to this [guide](https://docs.datadoghq.com/serverless/google_cloud_run)

2. Unified Service Taggig
You can change `DD_ENV` and `DD_SERVICE` from the Dockerfile. The unified service tagging consists of env, service and version that you can customize. You can refer to this [guide](https://docs.datadoghq.com/getting_started/tagging/unified_service_tagging/?tab=docker)

### 4. GCP Log integration with Datadog
You can send your GCP logs to Datadog by using Pub/Sub method. You can refer to this [guide](https://docs.datadoghq.com/integrations/google_cloud_platform/#log-collection)

Here, you need to specify which log you want to send to Datadog. For example, if you want to send this todoapp cloud run log, you can create an inclusion filter like below. You can change the `resource.labels.location` based on your application region. Please read the "3 . Create a log sink to publish logs to the Pub/Sub topic" from the guide.

```
(resource.type = "cloud_run_revision"
resource.labels.service_name = "datadog-python-todoapp"
resource.labels.location = "asia-northeast3")
```

### 5. Datadog RUM Browser SDK integration
1. RUM browser sdk cdn-sync method
If you check the templates/base.html file, you can replace the RUM clientToken, applicationId and service based on your RUM application. Here, the app uses the CDN sync method for RUM. You can refer to this [guide](https://docs.datadoghq.com/real_user_monitoring/browser/#cdn-sync)

2. Session Replay
You can enable the session replay. This is already enabled on this todoapp. If you check the templates/base.html file, you can find `window.DD_RUM.startSessionReplayRecording();` --> this is the way to enable the feature. You can refer to this [guide](https://docs.datadoghq.com/real_user_monitoring/session_replay/#usage) for more information.

### 6. Datadog GCP Serverless Monitoring Dashboard
You can also check sample GCP serverless monitoring dashboards for cloudrun services. Please refer to this [introduction](https://www.datadoghq.com/blog/google-serverless-application-monitoring-datadog/).











