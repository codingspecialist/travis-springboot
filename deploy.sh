#!/bin/bash

echo "1. 환경 설정하기"
REPOSITORY=/home/ubuntu/webapp
DEPLOY_DIRECTORY=/home/ubuntu/deploy
PROJECT_NAME=blog-server-repository
JAR_NAME=$REPOSITORY/$PROJECT_NAME/blog-server-repository.jar

echo "2. 현재 구동중인 애플리케이션 pid 확인해서 강제종료하기"

CURRENT_PID=$(pgrep -fl $PROJECT_NAME | grep java | awk '{print $1}')

echo "$CURRENT_PID"

if [ -z "$CURRENT_PID" ]; then
   echo "> 현재 구동 중인 애플리케이션이 없으므로 종료하지 않습니다."
else
   echo "> kill -15 $CURRENT_PID"
   kill -15 $CURRENT_PID
   sleep 5
fi

echo "3. jar 파일  복사하기"

rm -rf $REPOSITORY/$PROJECT_NAME
mkdir $REPOSITORY/$PROJECT_NAME
cp $DEPLOY_DIRECTORY/build/libs/*.jar $REPOSITORY/$PROJECT_NAME/blog-server-repository.jar

echo "4. jar파일 실행권한 주고 nohup 으로 실행하기 - 출력 재지정(Redirect) 안하면 오류남!!"

chmod +x $JAR_NAME
nohup java -jar -Dspring.profiles.active=prod -Dfile.encoding=UTF-8  $JAR_NAME > $REPOSITORY/$PROJECT_NAME/nohup.out 2>&1 &
# nohup java -jar $JAR_NAME > $REPOSITORY/$PROJECT_NAME/nohup.out 2>&1 &