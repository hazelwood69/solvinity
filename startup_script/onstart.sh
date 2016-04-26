logger "Azure Deployment: onstart.sh"
cd /tmp
mkdir docker && cd docker
docker pull nginx
if ! docker inspect -f {{.State.Running}} solvinity >/dev/null 2>&1; then
		docker build -t nginx .
        docker run --name solvinity-nginx -d -p 80:80 solvinity-nginx
        logger "Azure Deployment: run nginx"
else logger "From Azure Deployment: Container already up nothing to do"
fi

cd /
rm -Rf /tmp/docker
