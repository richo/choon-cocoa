//
//  ChoonSocket.m
//  choon-cocoa
//
//  Created by Richo Healey on 15/06/13.
//  Copyright (c) 2013 Richo Healey. All rights reserved.
//

#import "ChoonSocket.h"

@implementation ChoonSocket

-(id)init {
    socketIO = [[SocketIO alloc] initWithDelegate:self];
    return self;
}

-(void)connectTo:(NSString *)host port:(NSInteger *)port {
    // Shuddup xcode I know what I'm doing.
    [socketIO connectToHost:host onPort:port];
}

@end
