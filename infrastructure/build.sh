./up.py $1 | docker-compose -f - build alfresco
./up.py $1 | docker-compose -f - build sorl
./up.py $1 | docker-compose -f - build libreoffice
./up.py $1 | docker-compose -f - build share
./up.py $1 | docker-compose -f - build wso2


