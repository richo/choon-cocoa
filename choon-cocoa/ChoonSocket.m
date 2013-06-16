//
//  ChoonSocket.m
//  choon-cocoa
//
//  Created by Richo Healey on 15/06/13.
//  Copyright (c) 2013 Richo Healey. All rights reserved.
//

#import "ChoonSocket.h"

#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <resolv.h>
#include <arpa/inet.h>

// Debug

#include <errno.h>

// TODO
#define SOCKERR(n, msg) exit(1);

@implementation ChoonSocket

#define BUFSIZE 1024

-(id)init {
    return self;
}

CFStringRef noop(void *r) { return NULL; }

-(void)connectTo:(char*) host port:(int)port {
    struct sockaddr_in serv_addr;
    struct hostent *addr;

    NSLog(@"Looking up %s", host);

    if ((addr = gethostbyname(host)) == NULL) {
        printf("\n Error : Could not resolve hostname\n");
        SOCKERR(1, "Couldn't create socket");
    }


    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(port);
    memcpy(&serv_addr.sin_addr, addr->h_addr_list[0], addr->h_length);

    if((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0)
    {
        printf("\n Error : Could not create socket \n");
        SOCKERR(1, "Couldn't create socket");

    }

    NSLog(@"Connecting to %s:%d", host, port);
    if( connect(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0)
    {
        printf("\n Error : Connect Failed: %d \n", errno);
        SOCKERR(1, "Couldn't connect socket");
    }

}

-(void)mainloop {
    char recvBuff[1024];
    int n = 0;

    memset(recvBuff, '0',sizeof(recvBuff));
    while ( (n = read(sockfd, recvBuff, sizeof(recvBuff)-1)) > 0)
    {
        recvBuff[n] = 0;
        printf(">>> %s\n", recvBuff);
    }

    if(n < 0)
    {
        printf("\n Read error \n");
    }
}

@end
