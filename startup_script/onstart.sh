DOCKERFILECONTENT="FROM nginx
COPY static-content /usr/share/nginx/html"
SIMPLEHTML="<html> 
<head></head>
<body>Hello World!!!</body>
</html>
"
cd /tmp
mkdir nginx_up && mkdir nginx_up/static-content
cd nginx_up

touch static-content/helloworld.html
echo "$SIMPLEHTML" > static-content/helloworld.html

touch Dockerfile
echo "$DOCKERFILECONTENT" > Dockerfile

docker pull nginx

if ! docker inspect -f {{.State.Running}} solvinity >/dev/null 2>&1; then
        docker run --name solvinity-nginx -d -p 80:80 solvinity-nginx
else logger "From Azure Deployment: Container already up nothing to do"
fi

cd /
rm -Rf /tmp/nginx_up
