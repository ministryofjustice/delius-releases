vpc_id                 = "vpc-0d7bfee459b7bd221"
account_name           = "preproduction"
short_environment_name = "stage"
weblogic_tg_name       = "stage-weblogic-0c18"
weblogic_eis_tg_name   = "stage-weblogic-eis-999a"
is_production          = false

services = {
  weblogic = {
    container_port                     = 8080
    container_memory                   = 4096
    container_cpu                      = 2048
    task_count                         = 2
    grace_period_seconds               = 480
    deployment_minimum_healthy_percent = 50
  }

  weblogic-eis = {
    container_port       = 8080
    container_memory     = 2048
    container_cpu        = 1024
    task_count           = 0
    grace_period_seconds = 600
  }
}

weblogic_params = {
  API_CLIENT_ID     = "delius-ui-client"
  AWS_REGION        = "eu-west-2"
  COOKIE_SECURE     = "true"
  DEEPLINK_BASE_URL = "https://ndelius.stage.probation.service.justice.gov.uk/NDelius-war/delius/JSP/deeplink.xhtml"
  # DELIUS_API_URL                    = "" #Possibly Needed
  DMS_HOST                          = "hmpps-delius-alfresco-stage.apps.live.cloud-platform.service.justice.gov.uk"
  DMS_OFFICE_URI_HOST               = "hmpps-delius-alfresco-stage.apps.live.cloud-platform.service.justice.gov.uk"
  DMS_OFFICE_URI_PORT               = "443"
  DMS_PORT                          = "443"
  DMS_PROTOCOL                      = "https"
  EIS_USER_CONTEXT                  = "cn=EISUsers,ou=Users,dc=moj,dc=com"
  ELASTICSEARCH_URL                 = "https://probation-search-preprod.hmpps.service.justice.gov.uk/delius"
  GDPR_URL                          = "https://delius-gdpr-ui-stage.hmpps.service.justice.gov.uk/gdpr/ui/homepage"
  JDBC_CONNECTION_POOL_MAX_CAPACITY = "40"
  JDBC_CONNECTION_POOL_MIN_CAPACITY = "20"
  JDBC_URL                          = "jdbc:oracle:thin:@(DESCRIPTION=(LOAD_BALANCE=OFF)(FAILOVER=ON)(CONNECT_TIMEOUT=10)(RETRY_COUNT=3)(ADDRESS_LIST=(ADDRESS=(PROTOCOL=tcp)(HOST=delius-core-stage-db-1.hmpps-preproduction.modernisation-platform.internal)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=STGNDA_TAF)))"
  JDBC_USERNAME                     = "delius_pool"
  LDAP_HOST                         = "ldap.stage.delius-core.hmpps-preproduction.modernisation-platform.service.justice.gov.uk"
  LDAP_PRINCIPAL                    = "cn=admin,dc=moj,dc=com"
  LOG_LEVEL_NDELIUS                 = "INFO"
  MERGE_API_URL                     = "https://delius-merge-api-stage.hmpps.service.justice.gov.uk"
  MERGE_OAUTH_URL                   = "https://delius-user-management-stage.hmpps.service.justice.gov.uk/umt/oauth/"
  MERGE_URL                         = "https://delius-merge-ui-stage.hmpps.service.justice.gov.uk"
  NDELIUS_CLIENT_ID                 = "NDelius"
  OAUTH_URL                         = "https://sign-in-preprod.hmpps.service.justice.gov.uk/auth"
  PASSWORD_RESET_URL                = "https://password-reset.stage.probation.service.justice.gov.uk/public/forgottenpassword"
  PDFCREATION_TEMPLATES             = "shortFormatPreSentenceReport|paroleParom1Report|oralReport"
  PDFCREATION_URL                   = "https://ndelius-new-tech-pdf-generator-stage.hmpps.service.justice.gov.uk/newTech"
  PREPARE_CASE_FOR_SENTENCE_URL     = "https://prepare-a-case-preprod.apps.live-1.cloud-platform.service.justice.gov.uk"
  TZ                                = "Europe/London"
  USERMANAGEMENT_URL                = "https://delius-user-management-stage.hmpps.service.justice.gov.uk/umt/"
  USER_CONTEXT                      = "ou=Users,dc=moj,dc=com"
  USER_MEM_ARGS                     = "-XX:MaxRAMPercentage=90.0"
}
