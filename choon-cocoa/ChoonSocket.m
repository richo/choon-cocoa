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
#include <stdlib.h>
#include <setjmp.h>
#include <unistd.h>


// Debug

#include <errno.h>

// TODO
#define SOCKERR(n, msg) \
    do { \
        if((main) && (*buf != NULL)) {\
            sleep(5);\
            longjmp(*buf, n);\
        } else {\
            exit(n);\
        }\
    } while(0);


@implementation ChoonSocket

#define BUFSIZE 1024
static jmp_buf *buf = NULL;

-(id)init:(ChoonNotificationProxy*)_notifier proxy:(ChoonMusicProxy*)proxy{
    music = proxy;
    notifier = _notifier;
    return self;
}

CFStringRef noop(void *r) { return NULL; }

-(void)connectTo:(char*) host port:(int)port main:(bool)main {
    struct sockaddr_in serv_addr;
    struct hostent *addr;
    char *pebble_id = get_pebble_id();

    if (main) {
        buf = malloc(sizeof(jmp_buf));
        if (setjmp(*buf) > 0)
            // We've been here before
            [notifier deliver:@"Attempting to reconnect" withBody:[NSString stringWithFormat:@"%s", host]];
    }
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
    register_intent(sockfd, pebble_id);
    [notifier deliver:@"Successfully connected" withBody:[NSString stringWithFormat:@"%s", host]];
    if (main)
        [self mainloop];
}

char* get_pebble_id(void) {
    char *pebble_id = malloc(13), *path, *home_path;
    FILE *fh;
    if ((home_path = getenv("HOME")) != NULL)
        asprintf(&path, "%s/.choon", home_path);
    else
        path = ".choon";

    if ((fh = fopen(path, "r")) == NULL) {
        printf("Couldn't open your .choon, using dummy data");
        goto error;
    };
    if (fread(pebble_id, 12, 1, fh) < 1) {
        printf("couldn't read your pebble id, using dummy data");
        goto error;
    }
    if(home_path != NULL) {
        free(path);
    }
    if (0) {
    error:
        strcpy(pebble_id, "XXXXXXXXXXXX");
    }
    pebble_id[12] = 0;
    return pebble_id;
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
    char reg[17];
    snprintf(reg, 17, "reg %s", id);

    r_send(sock, reg, 16);
}

-(void)mainloop {
    // Bail if we're already holding a lock on this.
    char recvBuff[1];

    NSLog(@"Connecting");

    *recvBuff = 0;

    while (read(sockfd, recvBuff, 1) > 0)
    {
        switch(*recvBuff) {
        case 'n':
            [music next];
            break;
        case 'p':
            [music prev];
            break;
        case 't':
            [music toggle_play];
            break;
        }
    }
    NSLog(@"Disconnected from server");
    if (buf != NULL)
        longjmp(*buf, 1);

    // Update Icon, show we're disconnected, unlock another attempt to start this loop etc.
}

@end
