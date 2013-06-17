//
//  ChoonSocket.h
//  choon-cocoa
//
//  Created by Richo Healey on 15/06/13.
//  Copyright (c) 2013 Richo Healey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChoonMusicProxy.h"

@interface ChoonSocket : NSObject {
    int sockfd;
    ChoonMusicProxy* music;
}

- (id) init;
- (void) connectTo:(char*) host port:(int)port main:(bool)main;
- (void) mainloop;

@end
