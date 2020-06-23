# use with https://github.com/casey/just

backupfolder := ".backups"

alias p := pull
alias b := build
alias t := test
alias d := delete
alias i := init
alias r := restore
alias st := start
alias sp := stop

# ======================================
# General repo maintenance
# ======================================

# pull upstream images
pull:
    docker pull ${FROMPRODIMAGE}
    docker pull ${FROMDEVOPSIMAGE}

# build local images
build:
    docker build \
        --tag ${PRODIMAGE} \
        --build-arg "FROM_IMAGE=${FROMPRODIMAGE}" \
        .
    docker build \
        --tag ${DEVOPSIMAGE} \
        --build-arg "FROM_IMAGE=${FROMDEVOPSIMAGE}" \
        .

# apply patches
patch:
    #!/bin/sh
    dirty=$(git submodule --quiet foreach git status --porcelain)
    [ dirty ] && exit 1
    docker run \
        --entrypoint "" \
        --user $(id -u):$(id -g) \
        --volume './vendor:/mnt/vendor' \
        --volume './patches.d:/mnt/patches.d' \
        ${REPO}:${DEVOPSIMAGE} \
        /usr/local/bin/apply-patches.sh \
        "/mnt/patches.d/" "/mnt/"

# update repo tooling (only) from scaffold repo
update:
    git remote add scaffold https://github.com/OdooOps/dockery-odoo-scaffold.git 2> /dev/null || true
    git pull scaffold master


# ======================================
# Start & stop
# ======================================

# start local development instance
start:
    docker-compose up --no-start
    docker-compose up -d odoo-longpolling
    docker-compose up -d odoo
    docker-compose logs -f

# stop local development instance
stop:
    docker-compose stop

# ======================================
# Quality assurance
# ======================================

# migrate code from older versions
migrate modules from:
    #!/bin/sh
    dirty=$(git status --porcelain | grep 'src/')
    [ dirty ] && exit 1
    docker run \
        --volume "./src:/mnt/src" \
        --user $(id -u):$(id -g) \
        --entrypoint "" \
        ${REPO}:${DEVOPSIMAGE} odoo-module-migrator \
        --directory "/mnt/src" \
        --no-commit \
        --force-black \
        --modules {{ modules }} \
        --init-version-name {{ from }} \
        --target-version-name ${ODOO_VERSION}

# run tests
test:
    docker-compose run \
    odoo --test-enable --without-demo=False --stop-after-init --logfile /var/log/dodoo/tests/

# use the dodoo command
dodoo cmd="":
    docker-compose run \
    --entrypoint="/entrypoint.sh dodoo" odoo {{ cmd }}



# ======================================
# Database helpers
# ======================================

# initialize db
init db modules:
    docker-compose run \
    --entrypoint="/entrypoint.sh dodoo init" odoo -n{{ db }} -m{{modules}}

# delete db
delete db:
    docker-compose run \
    --entrypoint="dropdb -hdb -Uodoo" odoo {{ db }}

# restore database
restore file:
    #!/bin/sh
    dbdocker=$(docker-compose ps -q db)
    [ ! dbdocker ] && docker-compose up -d db && dbdocker=$(docker-compose ps -q db)
    docker exec -i \
        ${dbdocker} pg_restore \
        -U odoo \
        --create \
        --clean \
        --no-acl \
        --no-owner \
        -d postgres < {{ backupfolder }}/{{ file }}

# encrypt backup
encrypt file:
    tar cz -C {{ backupfolder }} {{ file }} | openssl enc -aes-256-cbc -e -pbkdf2 > {{ backupfolder }}/{{ file }}.tar.gz.enc

# decrypt backup
decrypt file:
    openssl enc -aes-256-cbc -pbkdf2 -d -in {{ file }} | tar xz -C {{ backupfolder }}

# ======================================
# Setup tools
# ======================================

# Install tooling (bobtemplates, )
get_tools:
# Install Bobtemplates.odoo
    pip install bobtemplates.odoo

# ======================================
# Bobtemplates odoo
# ======================================
# ref https://github.com/acsone/bobtemplates.odoo

# New addon using bobtemplates.odoo
new_addon:
    cd {{invocation_directory()}}; mrbob bobtemplates.odoo:addon

# New model using bobtemplates.odoo
new_model:
    cd {{invocation_directory()}}; mrbob bobtemplates.odoo:model

# New test using bobtemplates.odoo
new_test:
    cd {{invocation_directory()}}; mrbob bobtemplates.odoo:test

# New wizard using bobtemplates.odoo
new_wizard:
    cd {{invocation_directory()}}; mrbob bobtemplates.odoo:wizard
