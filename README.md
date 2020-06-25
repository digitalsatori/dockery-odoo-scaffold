This is ~our odoo scaffolding repository~ **your future odoo project**.

1. Install [`just`](https://github.com/casey/just#installation), the task runner
2. `git clone git@github.com:OdooOps/dockery-odoo-scaffold.git ~/odoo/myproject`
3. Modify the `.env` file. (replace {{ something }} by its value i.e. {{ DEFAULT_BRANCH }} --> 13.0)
4. Run `just --list` and let it be your guide.
5. Read through the files, and understand what they do.
6. `git submodule add` under odoo the odoo repository (github.com/odoo/odoo or OCB)
7. `git submodule add` under vendor additional repositories (OCA, community modules, odoo enterprise goes there too)
8. add under src the modules you are working on.
