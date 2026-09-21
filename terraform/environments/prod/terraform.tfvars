vpc_id                 = "vpc-0a16bb6858dd27aea"
account_name           = "production"
short_environment_name = "prod"
weblogic_tg_name       = "prod-weblogic-ea81"
weblogic_eis_tg_name   = "prod-weblogic-eis-72bd"
is_production          = true

services = {
  weblogic = {
    container_port       = 8080
    container_memory     = 8192
    container_cpu        = 1024
    task_count           = 30
    grace_period_seconds = 480
  }

  weblogic-eis = {
    container_port       = 8080
    container_memory     = 8192
    container_cpu        = 1024
    task_count           = 2
    grace_period_seconds = 600
  }
}

weblogic_params = {
  API_CLIENT_ID                     = "delius-ui-client"
  AWS_REGION                        = "eu-west-2"
  BREACH_NOTICE_API_URL             = "https://breach-notice-api.hmpps.service.justice.gov.uk"
  BREACH_NOTICE_UI_URL_FORMAT       = "https://breach-notice.hmpps.service.justice.gov.uk/breach-notice/%s"
  COOKIE_SECURE                     = "true"
  DEEPLINK_BASE_URL                 = "https://ndelius.probation.service.justice.gov.uk/NDelius-war/delius/JSP/deeplink.xhtml"
  DMS_HOST                          = "hmpps-delius-alfresco-prod.apps.live.cloud-platform.service.justice.gov.uk"
  DMS_OFFICE_URI_HOST               = "hmpps-delius-alfresco-prod.apps.live.cloud-platform.service.justice.gov.uk"
  DMS_OFFICE_URI_PORT               = "443"
  DMS_PORT                          = "443"
  DMS_PROTOCOL                      = "https"
  EIS_USER_CONTEXT                  = "cn=EISUsers,ou=Users,dc=moj,dc=com"
  ELASTICSEARCH_URL                 = "https://probation-search.hmpps.service.justice.gov.uk/delius"
  GDPR_URL                          = "https://delius-gdpr-ui-prod.hmpps.service.justice.gov.uk/gdpr/ui/" # Not Deployed
  JDBC_CONNECTION_POOL_MAX_CAPACITY = "40"
  JDBC_CONNECTION_POOL_MIN_CAPACITY = "20"
  JDBC_URL                          = "jdbc:oracle:thin:@(DESCRIPTION=(LOAD_BALANCE=OFF)(FAILOVER=ON)(CONNECT_TIMEOUT=10)(RETRY_COUNT=3)(ADDRESS_LIST=(ADDRESS=(PROTOCOL=tcp)(HOST=delius-core-prod-db-1.hmpps-production.modernisation-platform.internal)(PORT=1521))(ADDRESS=(PROTOCOL=tcp)(HOST=delius-core-prod-db-1.hmpps-production.modernisation-platform.internal)(PORT=1521))(ADDRESS=(PROTOCOL=tcp)(HOST=delius-core-prod-db-1.hmpps-production.modernisation-platform.internal)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=PRDNDA_TAF)))"
  JDBC_USERNAME                     = "delius_pool"
  LDAP_HOST                         = "ldap.prod.delius-core.hmpps-production.modernisation-platform.service.justice.gov.uk"
  LDAP_PRINCIPAL                    = "cn=admin,dc=moj,dc=com"
  LOG_LEVEL_NDELIUS                 = "INFO"
  MERGE_API_URL                     = "https://delius-merge-api-prod.hmpps.service.justice.gov.uk/merge/api/" # Not Deployed
  MERGE_OAUTH_URL                   = "https://delius-user-management-prod.hmpps.service.justice.gov.uk/umt/" # Not Deployed
  MERGE_URL                         = "https://delius-merge-ui-prod.hmpps.service.justice.gov.uk/merge/ui/" # Not Deployed
  NDELIUS_CLIENT_ID                 = "NDelius"
  OAUTH_CALLBACK_URL                = "https://ndelius.probation.service.justice.gov.uk/NDelius-war/delius/JSP/auth/token.jsp"
  OAUTH_CLIENT_ID                   = "delius-ui"
  OAUTH_DEFAULT_SCOPE               = "delius"
  OAUTH_LOGIN_ENABLED               = "false"
  OAUTH_LOGIN_NAME                  = ""
  OAUTH_TOKEN_VERIFICATION_URL      = "https://token-verification-api.prison.service.justice.gov.uk/token/verify"
  OAUTH_URL                         = "https://sign-in.hmpps.service.justice.gov.uk/auth"
  OFFENDER_SEARCH_API_URL           = "https://probation-offender-search.hmpps.service.justice.gov.uk"
  PASSWORD_RESET_URL                = "https://pwm.prod.delius-core.hmpps-production.modernisation-platform.service.justice.gov.uk/public/forgottenpassword"
  PDFCREATION_TEMPLATES             = "shortFormatPreSentenceReport|paroleParom1Report|oralReport"
  PDFCREATION_URL                   = "https://ndelius-new-tech.hmpps.service.justice.gov.uk/newTech"
  PREPARE_CASE_FOR_SENTENCE_URL     = "https://prepare-a-case-prod.apps.live-1.cloud-platform.service.justice.gov.uk/"
  PSR_SERVICE_URL                   = "https://pre-sentence-service.hmpps.service.justice.gov.uk/api/v1/report"
  PSR_UI_URL_FORMAT                 = "https://pre-sentence-service.hmpps.service.justice.gov.uk/psr/%s"
  SUICIDE_RISK_API_URL              = "https://suicide-risk-form-api.hmpps.service.justice.gov.uk"
  SUICIDE_RISK_UI_URL_FORMAT        = "https://suicide-risk-form.hmpps.service.justice.gov.uk/suicide-risk/%s"
  TZ                                = "Europe/London"
  USERMANAGEMENT_URL                = "https://delius-user-management-prod.hmpps.service.justice.gov.uk/umt/" # Not Deployed
  USER_CONTEXT                      = "ou=Users,dc=moj,dc=com"
  USER_MEM_ARGS                     = "-XX:MaxRAMPercentage=90.0"
}
