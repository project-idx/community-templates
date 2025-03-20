# Google Cloud Run Function
Created by [Theo Linnemann](https://www.theolinnemann.com)

## Enabling Roo Code for Vibes Driven Development with Gemini

1. Get a free API key from [Google AI Studio](https://aistudio.google.com/apikey)

2. Open up Roo on the left side by clicking the icon that looks like a rocket ship.

3. Select Google Gemini from the drop down. 

4. Copy and paste the API key into the API Key field.

5. Select gemini-2.0-pro-exp from the Model drop down.

6. Tell Roo what kind of Cloud Run Function you'd like to build!

## Getting Started

You can begin debugging by running the following command:

```bash
functions-framework --target my_cloud_function --debug
```


## Deployment Basics

You can perform your first deployment by running the following commands. First initialize your gcloud cli and just follow the steps. If you're not sure which region to pick, select the closest one to you or just us-central1.

```bash
gcloud init

gcloud run deploy python-http-function \
      --source . \
      --function my_first_cloud_function \
      --base-image python312 \
      --region REGION \
      --allow-unauthenticated
```

For more information about deployments you can [check out the documentation here](https://cloud.google.com/run/docs/quickstarts/functions/deploy-functions-gcloud?#python).

## Next Steps

You can find more information about the basics of using the function-framework in the [public GitHub repo here](https://github.com/GoogleCloudPlatform/functions-framework-python).

## Try it out!
<a href="https://idx.google.com/new?template=https://github.com/project-idx/community-templates/tree/main/cloud-run-function">
  <picture>
    <source
      media="(prefers-color-scheme: dark)"
      srcset="https://cdn.idx.dev/btn/open_dark_32.svg">
    <source
      media="(prefers-color-scheme: light)"
      srcset="https://cdn.idx.dev/btn/open_light_32.svg">
    <img
      height="32"
      alt="Open in IDX"
      src="https://cdn.idx.dev/btn/open_purple_32.svg">
  </picture>
</a>