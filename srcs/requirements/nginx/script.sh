docker build -t inception . >/dev/null 2>&1
if [ $? -eq 0  ]; then
	echo "Inception part is build"
else
	echo "ERROR:"
	echo "-----"
	echo " "
	docker build -t inception .
	echo " "
	echo "-----"
	echo "sole this problem, Inceptin has a problem"
	exit 1
fi

echo "Launch with -it ? (y/n)"
read answer
if [ "$answer" = "y" ]; then
	echo "Use 'exit' to stop container"
	docker run -it inception
else
	docker run inception
fi

