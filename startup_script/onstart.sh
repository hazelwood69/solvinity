DOCKERFILECONTENT="FROM nginx
COPY static-content /usr/share/nginx/html"

cd /tmp
mkdir nginx_up && mkdir nginx_up/static-content
cd nginx_up
git clone https://github.com/BlackrockDigital/startbootstrap-grayscale.git static-content
touch Dockerfile
echo "$DOCKERFILECONTENT" > Dockerfile

if ! docker inspect -f {{.State.Running}} grayscale >/dev/null 2>&1; then
        docker build -t grayscale-nginx .
        docker run --name grayscale -d -p 80:80 grayscale-nginx
else logger "From Azure Deployment: Container grayscale already up nothing to do"
fi

cd /
rm -Rf /tmp/nginx_up
