#!/bin/sh
#
#
### 配置路径
APP_DIR=~/javaservice/robotjavaservice
#//配置名称
APP_NAME=spring-boot-nlu-0.0.1-SNAPSHOT test
APP_CONF=$APP_DIR/application.properties

#set java home
export JAVA_HOME=/usr/lib/jdk/jdk1.8.0_191

usage() {
    echo "Usage: sh eju-micro-app.sh [start|stop|deploy]"
    exit 1
}

kills(){
    tpid=`ps -ef|grep $APP_NAME|grep -v grep|grep -v kill|awk '{print $2}'`
    if [ $tpid ]; then
        echo 'Kill Process!'
        kill -9 $tpid
    fi
}

start(){
    rm -f $APP_DIR/tpid
    #nohup java -jar myapp.jar --spring.config.location=application.yml > /dev/null 2>&1 &
    nohup java -jar $APP_DIR/"$APP_NAME".jar > ~/javaservice/robotjavaservice/roslog.txt 2>&1 &
    echo $! > $APP_DIR/tpid
    echo Start Success!
}

stop(){
        tpid1=`ps -ef|grep $APP_NAME|grep -v grep|grep -v kill|awk '{print $2}'`
    echo 'kill' ${tpid1}
        if [ $tpid1 ]; then
        echo 'Stop Process...'
        kill -9 $tpid1
    fi
}

check(){
    tpid=`ps -ef|grep $APP_NAME|grep -v grep|grep -v kill|awk '{print $2}'`
    if [ tpid ]; then
        echo 'App is running.'
    else
        echo 'App is NOT running.'
    fi
}

deploy() {
    kills
    rm -rf $APP_DIR/"$APPNAME".jar
    cp "$APP_NAME".jar $APP_DIR
}

case "$1" in
    "start")
        start
        ;;
    "stop")
        stop
        ;;
    "kill")
        kills
        ;;
    "deploy")
        deploy
        ;;
    *)
        usage
        ;;
esac
