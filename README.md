# onms-deploy-scripts
OpenNMS deploy scripts for development

Open deploy.sh and edit the variables:

    export DEV_ROOT="/path/to/your/dev/directory"
    export DEV_USER="dev-user"
    export DEV_GROUP="dev-group"
    export OPENNMS_ROOT="/path/to/your/deployment"
    export POSTGRES_BINARIES="/path/to/your/postgres/binaries"
    
You also need to provide your Postgresql password in `deploy-cfg/include/cleandb.sh`:

    export "PGPASSWORD=secret"
    
