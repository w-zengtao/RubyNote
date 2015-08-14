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

int main(int argc, char * argv[])
{
    int listenfd;
    int connfd;
    
    struct sockaddr_in servaddr;
    
    if ((listenfd = socket(AF_INET, SOCK_STREAM, 0)) == -1)
    {
        perror("socket error");
        exit(1);
    }
	
	bzero(&servaddr, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
    servaddr.sin_port = htons(50001);
    
    // 服务端首先要绑定一个host上的一个端口 bind
    // 然后对这个端口进行监听 也就是 listen

    bind(listenfd, (struct sockaddr *)&servaddr, sizeof(servaddr));
    listen(listenfd, 10);

    // 调用成功的时候返回一个新的连接socket
    // 该socket唯一标识了被接受的这个连接，服务器可通过读写该socket来与客户端通信

    connfd = accept(listenfd, (struct sockaddr *)NULL, NULL);

    int n;
    char recvline[1024];
    while((n = read(connfd, recvline, 1024)) > 0)
    {
    	recvline[n] = 0;
    	printf("%s\n", recvline);
    }

    close(connfd);
    close(listenfd);

    return 1;
}