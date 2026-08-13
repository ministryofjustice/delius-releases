vpc_id                 = "vpc-0d7bfee459b7bd221"
account_name           = "preproduction"
short_environment_name = "preprod"
weblogic_tg_name       = "preprod-weblogic-31cc"
weblogic_eis_tg_name   = "preprod-weblogic-eis-a7af"
is_production          = false

services = {
  weblogic = {
    container_port       = 8080
    container_memory     = 16384
    container_cpu        = 1024
    task_count           = 2
    grace_period_seconds = 480
  }

  weblogic-eis = {
    container_port       = 8080
    container_memory     = 16384
    container_cpu        = 1024
    task_count           = 2
    grace_period_seconds = 600
  }
}

weblogic_params = {
  API_CLIENT_ID                     = "delius-ui-client"
  AWS_REGION                        = "eu-west-2"
  BREACH_NOTICE_API_URL             = "https://breach-notice-api-preprod.hmpps.service.justice.gov.uk"
  BREACH_NOTICE_UI_URL_FORMAT       = "https://breach-notice-preprod.hmpps.service.justice.gov.uk/breach-notice/%s"
  COOKIE_SECURE                     = "true"
  DEEPLINK_BASE_URL                 = "https://ndelius.pre-prod.delius.probation.hmpps.dsd.io/NDelius-war/delius/JSP/deeplink.xhtml"
  DMS_HOST                          = "hmpps-delius-alfresco-preprod.apps.live.cloud-platform.service.justice.gov.uk"
  DMS_OFFICE_URI_HOST               = "hmpps-delius-alfresco-preprod.apps.live.cloud-platform.service.justice.gov.uk"
  DMS_OFFICE_URI_PORT               = "443"
  DMS_PORT                          = "443"
  DMS_PROTOCOL                      = "https"
  EIS_USER_CONTEXT                  = "cn=EISUsers,ou=Users,dc=moj,dc=com"
  ELASTICSEARCH_URL                 = "https://probation-search-preprod.hmpps.service.justice.gov.uk/delius"
  GDPR_URL                          = "https://delius-gdpr-ui-preprod.hmpps.service.justice.gov.uk/gdpr/ui/homepage" # Not resolving yet
  JDBC_CONNECTION_POOL_MAX_CAPACITY = "40"
  JDBC_CONNECTION_POOL_MIN_CAPACITY = "20"
  JDBC_URL                          = "jdbc:oracle:thin:@(DESCRIPTION=(LOAD_BALANCE=OFF)(FAILOVER=ON)(CONNECT_TIMEOUT=10)(RETRY_COUNT=3)(ADDRESS_LIST=(ADDRESS=(PROTOCOL=tcp)(HOST=delius-core-preprod-db-1.hmpps-preproduction.modernisation-platform.internal)(PORT=1521))(ADDRESS=(PROTOCOL=tcp)(HOST=delius-core-preprod-db-2.hmpps-preproduction.modernisation-platform.internal)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=PRENDA_TAF)))"
  JDBC_USERNAME                     = "delius_pool"
  LDAP_HOST                         = "ldap.preprod.delius-core.hmpps-preproduction.modernisation-platform.service.justice.gov.uk"
  LDAP_PRINCIPAL                    = "cn=admin,dc=moj,dc=com"
  LOG_LEVEL_NDELIUS                 = "DEBUG"
  MERGE_API_URL                     = "https://delius-merge-api-preprod.hmpps.service.justice.gov.uk" # Not resolving yet
  MERGE_OAUTH_URL                   = "https://delius-user-management-preprod.hmpps.service.justice.gov.uk/umt/oauth/" # Not resolving yet
  MERGE_URL                         = "https://delius-merge-ui-preprod.hmpps.service.justice.gov.uk" # Not resolving yet
  NDELIUS_CLIENT_ID                 = "NDelius"
  OAUTH_CALLBACK_URL                = "https://ndelius.preprod.delius-core.hmpps-test.modernisation-platform.service.justice.gov.uk/NDelius-war/delius/JSP/auth/token.jsp" # Not resolving yet
  OAUTH_CLIENT_ID                   = "delius-ui"
  OAUTH_DEFAULT_SCOPE               = "delius"
  OAUTH_LOGIN_ENABLED               = "false"
  OAUTH_LOGIN_NAME                  = ""
  OAUTH_TOKEN_VERIFICATION_URL      = "https://token-verification-api-preprod.prison.service.justice.gov.uk/token/verify"
  OAUTH_URL                         = "https://sign-in-preprod.hmpps.service.justice.gov.uk/auth"
  OFFENDER_SEARCH_API_URL           = "https://probation-offender-search-preprod.hmpps.service.justice.gov.uk"
  PASSWORD_RESET_URL                = "https://pwm.preprod.delius-core.hmpps-test.modernisation-platform.service.justice.gov.uk/public/forgottenpassword"
  PDFCREATION_TEMPLATES             = "shortFormatPreSentenceReport|paroleParom1Report|oralReport"
  PDFCREATION_URL                   = "https://ndelius-new-tech-pdf-generator-preprod.hmpps.service.justice.gov.uk/newTech"
  PREPARE_CASE_FOR_SENTENCE_URL     = "https://prepare-a-case-preprod.apps.live-1.cloud-platform.service.justice.gov.uk"
  TZ                                = "Europe/London"
  USERMANAGEMENT_URL                = "https://delius-user-management-preprod.hmpps.service.justice.gov.uk/umt/" # Not resolving yet
  USER_CONTEXT                      = "ou=Users,dc=moj,dc=com"
  USER_MEM_ARGS                     = "-XX:MaxRAMPercentage=90.0"
}
