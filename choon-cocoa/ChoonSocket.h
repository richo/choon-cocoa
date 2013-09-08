//
//  ChoonSocket.h
//  choon-cocoa
//
//  Created by Richo Healey on 15/06/13.
//  Copyright (c) 2013 Richo Healey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChoonMusicProxy.h"
#import "ChoonNotificationProxy.h"


@interface ChoonSocket : NSObject {
    int sockfd;
    ChoonMusicProxy* music;
    ChoonNotificationProxy* notifier;
}

- (id) init:(ChoonNotificationProxy*)_notifier proxy:(ChoonMusicProxy*)proxy;
- (void) connectTo:(char*) host port:(int)port main:(bool)main;
- (void) mainloop;

@end
