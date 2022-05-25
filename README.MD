# Delius Releases

> :memo: This is a work-in-progress and is subject to change.

Automated deployment pipeline for the National Delius probation case management system, built by Unilink to improve the speed and quality of releases.

View the status of the latest release here: **TODO add link**

## Pipeline

**TODO add screenshot**

The pipeline orchestrates the following actions:
* Each week, Unilink will build the Delius image and verify it in their system test environments.
* Once the build has been signed off internally, Unilink will release it by tagging this repository.
* The release will be automatically deployed to the MOJ development environments (`delius-core-dev`, `delius-core-sandpit`, `delius-mis-dev`).
* A Slack notification will be sent to the NDST channel to request approval for deployment to the MOJ test environments.
* Once approved, the release will be automatically deployed to the MOJ test environments (`delius-test`, `delius-perf`, `delius-training-test`) and then wait for further approval.
* The Delius functional and performance tests will be executed against the release.
* Once approved, the release will be automatically deployed to the MOJ pre-production environments (`delius-preprod`, `delius-training`).

## Monitoring
The pipeline for each release can be monitored in CircleCI: **TODO add link**.

Any deployment failures will be reported to the NDST Slack channel.

## Support
If you have any questions, please ask in the NDST Slack channel.  Or feel free to create an issue in this repository.