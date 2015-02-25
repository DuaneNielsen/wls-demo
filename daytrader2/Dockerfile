FROM duanenielsen/daytrader

ADD .bashrc /root/.bashrc
ADD entrypoint.sh /
ADD IntroscopeAgent.profile /wily/core/config/IntroscopeAgent.profile
ADD tomcat-typical.pbl /wily/core/config/
ADD server.xml /wlp/usr/servers/Daytrader3Sample/server.xml

EXPOSE 9137
