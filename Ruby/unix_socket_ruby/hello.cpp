#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <netdb.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <sys/stat.h>

//设备地址，以实际为准
#define DEVIP "172.16.0.139"
//设备web远程端口，默认80，以实际为准
#define WEBPORT 80
//缓冲区最大字节数
#define MAXDATASIZE 10240

int main(int argc, char *argv[])
{
    int sockfd, numbytes;
    int apilen;
    char buf[MAXDATASIZE];
    char apistr[256];
    struct hostent *he;
    struct sockaddr_in server_addr;
    
    if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
        perror("socket error");
        exit(1);
    }
    memset(&server_addr, 0, sizeof(struct sockaddr_in));
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(WEBPORT);
    server_addr.sin_addr.s_addr = inet_addr(DEVIP);
    if(connect(sockfd, (struct sockaddr *)&server_addr, sizeof(struct sockaddr)) == -1) {
        perror("connect error");
        close(sockfd);
        exit(1);
    }
    
    memset(apistr,0,256);
    strcpy(apistr, "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<Control attribute=\"Query\">\n<DeviceInfo/>\n</Control>\n");
    apilen = strlen(apistr);
    memset(buf, 0, MAXDATASIZE);
    sprintf(buf, "POST /xml HTTP/1.1\nContent-Type:text/html\nHost:%s:%d\nContent-Length:%d\n\n%s",DEVIP,WEBPORT,apilen,apistr);
    
    numbytes = send(sockfd, buf, strlen(buf), 0);
    printf("send:\n");
    printf("%s\n",buf);
    
    memset(buf, 0, MAXDATASIZE);
    numbytes = recv(sockfd,buf, MAXDATASIZE,0);
    if(numbytes<=0){
        printf("recv failure\n");
        close(sockfd);
        exit(1);
    }
    printf("recv:\n");
    printf("%s\n",buf);
    
    close(sockfd);
    return 0;
}
