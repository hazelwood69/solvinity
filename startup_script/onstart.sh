logger "Azure Deployment: onstart.sh"
cd /tmp
mkdir docker && cd docker

if ! docker inspect -f {{.State.Running}} solvinity >/dev/null 2>&1; then
		docker run --name solvinity-nginx -P -d nginx fcd1fb01b14557c7c9d991238f2558ae2704d129cf9fb97bb4fadf673a58580d
        logger "Azure Deployment: run nginx"
else logger "From Azure Deployment: Container already up nothing to do"
fi
