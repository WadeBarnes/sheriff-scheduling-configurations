#!/bin/bash
#
source "$(dirname ${0})/common.sh"

#%
#% OpenShift Schema Spy Helper
#%
#%   Intended to recycle schema spy when changes are detected.
#%   Targets incl.: 'dev'
#%
#% Usage:
#%
#%   ${THIS_FILE} [TARGET] [-apply]
#%
#% Examples:
#%
#%   Provide `dev` as target environment. Defaults to a dry-run.
#%   ${THIS_FILE} dev
#%
#%   Apply when satisfied.
#%   ${THIS_FILE} dev -apply
#%

# Target project override for Dev, Test or Prod deployments
#
PROJ_TARGET="${PROJ_TARGET:-${PROJ_PREFIX}-${TARGET}}"

# Parameters and mode variables
#
INSTANCE_ID=${INSTANCE_ID:-}

# Scale down before scaling back up
#
OC_BACKUP="oc scale dc ${PROJ_TARGET} --replicas=0 && oc scale dc ${PROJ_TARGET} --replicas=1"

# Execute commands
#
if [ "${APPLY}" ]; then
  eval "${OC_BACKUP}"
fi

# Provide oc command instruction
#
display_helper "${OC_BACKUP}"
