#!/usr/bin/env bash
set -eo pipefail

function git_config() {
  git config --global user.name '[bot] delius-releases'
  git config --global user.email 'hmpps-engineering-jenkins@digital.justice.gov.uk'
}

function push_changes() {
  git add "$environment/ansible/group_vars/all.yml"
  git add "$environment/ansible/group_vars/ldap.yml"
  git commit -m "Deploy Delius v$version ${rbac_version:+and RBAC v$rbac_version }to $environment" \
             -m 'This was triggered by an automated deployment from https://github.com/ministryofjustice/delius-releases'
  git pull --rebase &&
  git push --set-upstream origin master
}

function update_versions() {
  # update ndelius_version
  sed -i "s/^ndelius_version:.*/ndelius_version: "'"'"$version"'"'"/" "$environment/ansible/group_vars/all.yml"

  # update or set rbac_version
  if [ -n "$rbac_version" ]; then
    if grep -q 'rbac_version:' "$environment/ansible/group_vars/ldap.yml"; then
      sed -i "s/rbac_version:.*/rbac_version: "'"'"$rbac_version"'"'"/" "$environment/ansible/group_vars/ldap.yml"
    else
      echo -e "---\nldap_config:\n  rbac_version: $rbac_version" > "$environment/ansible/group_vars/ldap.yml"
    fi
  fi
}

# clone the configuration repo
git_config
git clone "https://$token@github.com/ministryofjustice/hmpps-env-configs.git" env_configs
cd env_configs

# get short environment name
HMPPS_BUILD_WORK_DIR=$GITHUB_WORKSPACE source "$environment/$environment.properties"
echo "short_environment_name=$TG_SHORT_ENVIRONMENT_NAME" | tee -a "$GITHUB_OUTPUT"

# get current version
current_version=$(sed -En 's/^ndelius_version:\s+"(.+?)"$/\1/p' "$environment/ansible/group_vars/all.yml")
version_changed=$(if [ "$current_version" == "$version" ]; then echo false; else echo true; fi)
echo "current_version=$current_version" | tee -a "$GITHUB_OUTPUT"
echo "version_changed=$version_changed" | tee -a "$GITHUB_OUTPUT"

# update the version in config
if [ "$version_changed" == "false" ]; then
  echo "No changes. $version == $current_version"
else
  update_versions
  push_changes
fi