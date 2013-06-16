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
    // TODO, get an actual ID from somewhere. Use Pebble ID.. maybe.
    char *pebble_id = "XXXXXXXXXXXX";
    register_intent(sockfd, pebble_id);
}

void r_send(int sock, char *data, int len) {
    int n = 0, i = 0;
    while (n < len) {
        i = send(sock, data, len-n, 0);
        data += i;
        n += i;
    }
}

void register_intent(int sock, char* id) {
    char reg[16];
    snprintf(reg, 16, "reg %s", id);

    r_send(sock, reg, 16);
}

-(void)mainloop {
    // Bail if we're already holding a lock on this.

    char recvBuff[1];

    *recvBuff = 0;

    while (read(sockfd, recvBuff, 1) > 0)
    {
        switch(*recvBuff) {
        case 'n':
            system("~/.track next");
            break;
        case 'p':
            system("~/.track prev");
            break;
        }
    }

    // Update Icon, show we're disconnected, unlock another attempt to start this loop etc.
}

@end
