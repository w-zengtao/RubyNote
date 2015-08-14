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

int main(int argc, char *argv[])
{
    int sockfd;
    struct sockaddr_in servaddr;
    
    if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
        perror("socket error");
        exit(1);
    }
   
    bzero(&servaddr, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(50001);
    servaddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    
    if(connect(sockfd, (struct sockaddr *)&servaddr, sizeof(struct sockaddr)) == -1) {
        perror("connect error");
        close(sockfd);
        exit(1);
    }
    
    char sendline[100];
    sprintf(sendline, "Hello, world!");

 // 下面的函数应该使用异常处理
    write(sockfd, sendline, strlen(sendline));
    close(sockfd);
    
    return 1;
}

// write / send

// read / recv

// bind   
// listen 监听一个socket
// accept 接受连接  从listen监听的队列中接受一个连接
// connect 客户端发起连接