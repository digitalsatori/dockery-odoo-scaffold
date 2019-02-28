#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "\n${RED}First we build the production image. It contains:${NC}\n"
echo -e "\t${GREEN}- Odoo Community Code${NC}"
echo -e "\t${GREEN}- Odoo Enterprise Code (if configured)${NC}"
echo -e "\t${GREEN}- Vendored modules${NC}"
echo -e "\t${GREEN}- Your project modules (\`src\` folder)${NC}"
echo -e "\t${GREEN}- Your further customizations from the Dockerfile${NC}\n"

if [ "$1" = "nocache" ]; then
    docker build --tag "${IMAGE}:base-${ODOO_VERSION}" --no-cache  --build-arg "FROM_IMAGE=${FROM}:${ODOO_VERSION}-base"   "${DIR}/../."
else
    docker build --tag "${IMAGE}:base-${ODOO_VERSION}" --build-arg "FROM_IMAGE=${FROM}:${ODOO_VERSION}-base"   "${DIR}/../."
fi

echo -e "\n${RED}Now we build the devops image as sibling to the production image.\n"
echo -e "\t${GREEN}- Provides Odoo Server API extensions for DevOps.${NC}"
echo -e "\t${GREEN}- Remote build context maintained by XOE.${NC}"
echo -e "\t${GREEN}- Therefore, as devops image evolves, just rebuild.${NC}"
echo -e "\t${GREEN}- For details, visit: https://git.io/fpMvT${NC}\n"

if [ "$1" = "nocache" ]; then
    docker build --tag "${IMAGE}:devops-${ODOO_VERSION}" --no-cache  --build-arg "FROM_IMAGE=${FROM}:${ODOO_VERSION}-devops" "${DIR}/../."
else
    docker build --tag "${IMAGE}:devops-${ODOO_VERSION}" --build-arg "FROM_IMAGE=${FROM}:${ODOO_VERSION}-devops" "${DIR}/../."
fi

echo -e "\n${RED}First time? Next, do:${NC}\n"
echo -e "\t${GREEN}- apply patches to your local workdir: \`make patch\`;${NC}"
echo -e "\t${GREEN}- scaffold your first module in \`src\`: \`docker-compose run scaffold\`;\n${NC}"
