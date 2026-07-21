vpc_id                 = "vpc-0b327c73f2d0a27d2"
long_environment_name  = "test"
short_environment_name = "test"
weblogic_tg_name       = "test-weblogic-ff35"
weblogic_eis_tg_name   = "test-weblogic-eis-cf32f"
is_production          = false

services = {
  weblogic = {
    container_port           = 8080
    container_memory         = 4096
    container_cpu            = 2048
    task_count               = 4
    grace_period_seconds     = 480
  }

  weblogic-eis = {
    container_port           = 8080
    container_memory         = 2048
    container_cpu            = 1024
    task_count               = 1
    grace_period_seconds     = 600
  }
}

weblogic_params = {
  API_CLIENT_ID                     = "delius-ui-client"
  AWS_REGION                        = "eu-west-2"
  BREACH_NOTICE_API_URL             = "https://breach-notice-api-test.hmpps.service.justice.gov.uk"
  BREACH_NOTICE_UI_URL_FORMAT       = "https://breach-notice-test.hmpps.service.justice.gov.uk/breach-notice/%s"
  COOKIE_SECURE                     = "true"
  # DELIUS_API_URL                    = "" # Possibly no longer needed
  DMS_HOST                          = "hmpps-delius-alfresco-test.apps.live.cloud-platform.service.justice.gov.uk"
  DMS_OFFICE_URI_HOST               = "hmpps-delius-alfresco-test.apps.live.cloud-platform.service.justice.gov.uk"
  DMS_OFFICE_URI_PORT               = "443"
  DMS_PORT                          = "443"
  DMS_PROTOCOL                      = "https"
  EIS_USER_CONTEXT                  = "cn=EISUsers,ou=Users,dc=moj,dc=com"
  ELASTICSEARCH_URL                 = "https://probation-search-test.hmpps.service.justice.gov.uk/delius"
  GDPR_URL                          = "https://ndelius.test.probation.service.justice.gov.uk/gdpr/ui/homepage" # GDPR not deployed to CP yet, <URL>/gdpr/ui/homepage
  JDBC_CONNECTION_POOL_MAX_CAPACITY = "100"
  JDBC_CONNECTION_POOL_MIN_CAPACITY = "50"
  JDBC_URL                          = "jdbc:oracle:thin:@(DESCRIPTION=(LOAD_BALANCE=OFF)(FAILOVER=ON)(CONNECT_TIMEOUT=10)(RETRY_COUNT=3)(ADDRESS_LIST=(ADDRESS=(PROTOCOL=tcp)(HOST=delius-core-test-db-1.hmpps-test.modernisation-platform.internal)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=TSTNDA_TAF)))"
  JDBC_USERNAME                     = "delius_pool"
  LDAP_HOST                         = "ldap.test.delius-core.hmpps-test.modernisation-platform.service.justice.gov.uk"
  LDAP_PRINCIPAL                    = "cn=admin,dc=moj,dc=com"
  LOG_LEVEL_NDELIUS                 = "DEBUG"
  MERGE_API_URL                     = "https://delius-merge-api-test.hmpps.service.justice.gov.uk"
  MERGE_OAUTH_URL                   = "https://delius-user-management-test.hmpps.service.justice.gov.uk/umt/oauth/"
  MERGE_URL                         = "https://delius-merge-ui-test.hmpps.service.justice.gov.uk"
  NDELIUS_CLIENT_ID                 = "migrations_client_id"
  OAUTH_CALLBACK_URL                = "https://ndelius.test.delius-core.hmpps-test.modernisation-platform.service.justice.gov.uk/NDelius-war/delius/JSP/auth/token.jsp"
  OAUTH_CLIENT_ID                   = "delius-ui"
  OAUTH_DEFAULT_SCOPE               = "delius"
  OAUTH_LOGIN_ENABLED               = "false"
  OAUTH_LOGIN_NAME                  = ""
  OAUTH_TOKEN_VERIFICATION_URL      = "https://token-verification-api-test.prison.service.justice.gov.uk/token/verify"
  OAUTH_URL                         = "https://sign-in-test.hmpps.service.justice.gov.uk/auth"
  OFFENDER_SEARCH_API_URL           = "https://probation-offender-search-test.hmpps.service.justice.gov.uk"
  PASSWORD_RESET_URL                = "https://pwm.test.delius-core.hmpps-test.modernisation-platform.service.justice.gov.uk/public/forgottenpassword"
  PDFCREATION_TEMPLATES             = "shortFormatPreSentenceReport|paroleParom1Report|oralReport"
  PDFCREATION_URL                   = "https://ndelius-new-tech-pdf-generator-test.hmpps.service.justice.gov.uk/newTech"
  PREPARE_CASE_FOR_SENTENCE_URL     = "https://prepare-a-case-test.apps.live-1.cloud-platform.service.justice.gov.uk"
  PSR_SERVICE_URL                   = "https://pre-sentence-service-test.hmpps.service.justice.gov.uk"
  TRAINING_MODE_APP_NAME            = "National Delius - TEST USE ONLY"
  TZ                                = "Europe/London"
  USERMANAGEMENT_URL                = "https://delius-user-management-test.hmpps.service.justice.gov.uk/umt/"
  USER_CONTEXT                      = "ou=Users,dc=moj,dc=com"
  USER_MEM_ARGS                     = "-XX:MaxRAMPercentage=90.0"
}