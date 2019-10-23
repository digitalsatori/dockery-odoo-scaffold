build-base-docs:
    @echo "---------------------------------------------------------------------"
    @echo "$(ccyellow)$(ccbold)$(cculine)Build the production image. It contains:$(ccend)$(ccyellow)$(ccbold)"
    @echo "  - Odoo Community Code"
    @echo "  - Odoo Enterprise Code (if configured)"
    @echo "  - Other vendored modules (\`vendor\` folder)"
    @echo "  - Project modules (\`src\` folder)"
    @echo "  - Customizations from the Dockerfile$(ccend)"
    @echo "---------------------------------------------------------------------$(ccend)"

build-devops-docs:
    @echo "---------------------------------------------------------------------"
    @echo "$(ccyellow)$(ccbold)$(cculine)Build the devops image as sibling to the production image.$(ccend)$(ccyellow)$(ccbold)"
    @echo "  - WDB for comfortable debugging."
    @echo "  - XOE's dodoo suite of DevOps extensions."
    @echo "  - Headless browser for JS tests."
    @echo "  - Some advanced module templates."
    @echo "  - For details, visit: https://git.io/fjOtu$(ccend)"
    @echo "---------------------------------------------------------------------$(ccend)"


### Transform operations

transform-docs:
    @echo "---------------------------------------------------------------------"
    @echo "$(ccyellow)$(ccbold)$(cculine)Apply code transforms to your current working directory.$(ccend)$(ccyellow)$(ccbold)"
    @echo "  - Transforms are applied within the container context."
    @echo "  - Host volume (./src) is bind-mounted in read-write mode."
    @echo "  - Therefore, changes reflect in your host's working directory."
    @echo "---------------------------------------------------------------------$(ccend)"


### Patching operations

patch-docs:
    @echo "---------------------------------------------------------------------"
    @echo "$(ccyellow)$(ccbold)$(cculine)Apply patches to your current working directory.$(ccend)$(ccyellow)$(ccbold)"
    @echo "  - Patches are applied within the container context."
    @echo "  - Host volumes are bind-mounted in read-write mode."
    @echo "  - Therefore, changes reflect in your host's working directory."
    @echo "  - Pay attention to the $(ccgreen)green texts$(ccyellow) to see which patch is applied where."
    @echo "---------------------------------------------------------------------$(ccend)"


### General info


info:
    @echo ""
    @echo "$(ccyellow)$(ccbold)$(cculine)Info about dockery-odoo.$(ccend)$(ccyellow)$(ccbold)"
    @echo ""
    @sleep 3
    @echo "  ▸ Shout it out loud: $(ccgreen)dockery-odoo is extremely cool!$(ccyellow)"
    @sleep 3
    @echo "  ▸ Look arround you. Did anybody hear your joyful outburst? 🤩"
    @echo ""
    @sleep 3
    @echo "In medias res ..."
    @echo ""
    @sleep 3
    @echo "  Shortly, we run $(ccend)$(ccyellow)make create$(ccbold). Sit back, relax and $(ccgreen)watch carefully.$(ccend)"
    @echo ""
    @echo ""
    @sleep 5
    make create
    @echo ""
    @echo ""
    @echo "$(ccbold)$(ccred)Whoow!$(ccyellow) Lots of stuff going on... "
    @echo ""
    @sleep 3
    @echo "Take your time. Go through the logs. And when you're ready..."
    @echo ""
    make help

alias:
    @echo "alias dc=\"docker-compose\""
    @echo "complete -F _docker_compose dc"
    @echo "alias dcu=\"docker-compose up\""
    @echo "alias dcd=\"docker-compose down\""
    @echo "alias dcr=\"docker-compose run\""

help:
    @echo "$(ccbold)$(ccyellow)$(cculine)Useful alias for docker-compose:$(ccend)"
    @echo ""
    @echo "   $(ccyellow)alias dc=\"docker-compose\" $(ccgreen)"
    @echo "   $(ccyellow)alias dcu=\"docker-compose up\" $(ccgreen)"
    @echo "   $(ccyellow)alias dcd=\"docker-compose down\" $(ccgreen)"
    @echo "   $(ccyellow)alias dcr=\"docker-compose run\" $(ccgreen)"
    @echo ""
    @echo "   $(ccyellow)make alias >> ~/.bash_aliases $(ccgreen)"
    @echo ""
    @echo "$(ccbold)$(ccyellow)$(cculine)Kick off odoo:$(ccend)"
    @echo ""
    @echo "   $(ccyellow)dcr init $(ccgreen)                       ▸ create dev db"
    @echo "   $(ccyellow)dcu odoo $(ccgreen)                       ▸ start up odoo"
    @echo "   $(ccyellow)dcr rmdb $(ccgreen)                       ▸ remove dev db"
    @echo "   $(ccyellow)make restore $(ccgreen)                   ▸ restore a db"
    @echo "   $(ccyellow)dcd $(ccgreen)                            ▸ tear down project"
    @echo ""
    @echo "$(ccbold)$(ccyellow)$(cculine)Other useful odoo commands:$(ccend)"
    @echo ""
    @echo "   $(ccyellow)dcr odoo -d <DB> -u <MOD>$(ccgreen)       ▸ standard odoo"
    @echo "   $(ccyellow)dcr odoo shell $(ccgreen)                 ▸ access an odoo shell"
    @echo "   $(ccyellow)dcr scaffold $(ccgreen)                   ▸ scaffold a module"
    @echo "   $(ccyellow)dcr dodoo pytest $(ccgreen)               ▸ run your pytests"
    @echo "   $(ccyellow)dcr dodoo --help $(ccgreen)               ▸ say hello to dodoo"
    @echo ""
    @echo "$(ccbold)$(ccyellow)$(cculine)Other maintenance commands:$(ccend)"
    @echo ""
    @echo "   $(ccyellow)make help $(ccgreen)                      ▸ this little cheatsheet"
    @echo "   $(ccyellow)make create $(ccgreen)                    ▸ rebuild your environment"
    @echo "   $(ccyellow)make pull $(ccgreen)                      ▸ pull from images"
    @echo "   $(ccyellow)make build $(ccgreen)                     ▸ build your images"
    @echo "   $(ccyellow)make patch $(ccgreen)                     ▸ patch your workdir"
    @echo "   $(ccyellow)make update $(ccgreen)                    ▸ pull in scaffold changes"
    @echo "   $(ccyellow)make transform $(ccgreen)                 ▸ apply code transformations (mig)"
    @echo "   $(ccyellow)make lint $(ccgreen)                      ▸ apply pre-commit linting"
    @echo ""
    @echo "$(ccbold)$(ccyellow)$(cculine)Git Cheatsheet:$(ccend)"
    @echo ""
    @echo "   $(ccyellow)git submodule update --remote $(ccgreen)  ▸ upgrade submodules to their tracking branch"
    @echo "   $(ccyellow)odooup whitelist $(ccgreen)               ▸ white list deps for \`src\`"
    @echo "   $(ccyellow)odooup repo $(ccgreen)                    ▸ odoo patch management"
    @echo ""
    @echo "$(ccbold)$(ccyellow)$(cculine)Common urls:$(ccend)"
    @echo ""
    @echo "   $(ccyellow)http://odoo.localhost $(ccgreen)          ▸ odoo webapp"
    @echo "   $(ccyellow)http://mail.localhost $(ccgreen)          ▸ mailhog mailsink"
    @echo "   $(ccyellow)http://wdb.localhost $(ccgreen)           ▸ wdb debugger"
    @echo "   $(ccyellow)http://files.localhost $(ccgreen)         ▸ volume browser, if enabled"
    @echo ""
    @echo "$(ccbold)$(ccyellow)And there is more: have a look at ./Makefile and ./docker-compose.yml$(ccend)"
    @echo ""
    @echo "QED.    ▢"
    @echo ""
    @echo ""
