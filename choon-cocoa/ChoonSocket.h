//
//  ChoonSocket.h
//  choon-cocoa
//
//  Created by Richo Healey on 15/06/13.
//  Copyright (c) 2013 Richo Healey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChoonSocket : NSObject {
    int sockfd;
}

- (id) init;
- (void) connectTo:(char*) host port:(int)port;
- (void) mainloop;

@end
