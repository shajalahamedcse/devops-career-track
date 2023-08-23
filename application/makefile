image_name:=shajalahamedcse/web
tag:=v1.1
container_name:=web
build:
	@ docker build -t ${image_name}:${tag} .
run:
	@ docker run --name ${container_name} -d -p 8080:80 ${image_name}:${tag}
b:
	@ chmod +x hello.sh 
	@ ./hello.sh

files:=hello.sh hello1.sh hello2.sh
chmod:
	@ chmod +x ${files}
run1:
	@ ./hello.sh
	@ ./hello1.sh
