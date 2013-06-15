//
//  ChoonSocket.m
//  choon-cocoa
//
//  Created by Richo Healey on 15/06/13.
//  Copyright (c) 2013 Richo Healey. All rights reserved.
//

#import "ChoonSocket.h"
#define WS_OUR_NAME @"whargharblericho"
#include <unistd.h>

@implementation ChoonSocket

-(id)init {
    socketIO = [[SocketIO alloc] initWithDelegate:self];
    return self;
}

-(void)connectTo:(NSString *)host port:(NSInteger *)port {
    NSLog(@"stuff");
    // Shuddup xcode I know what I'm doing.
    [socketIO connectToHost:host onPort:port];
    [socketIO sendMessage:@"json"];
    [socketIO sendMessage:@"json"];
    [socketIO sendMessage:@"json"];
    [socketIO sendMessage:@"json"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:WS_OUR_NAME forKey:@"reg"];
    
    [socketIO sendEvent:@"events" withData:dict];
    NSLog(@"Sent a message");

}

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSLog(@"didReceiveEvent()");
    
    SocketIOCallback cb = ^(id argsData) {
        NSDictionary *response = argsData;
        // do something with response
        NSLog(@"ack arrived: %@", response);
    };
    [socketIO sendMessage:@"hello back!" withAcknowledge:cb];
}

- (void) socketIO:(SocketIO *)socket didReceiveMessage:(SocketIOPacket *)packet
{
    NSLog(@"didReceiveMessage() >>> data: %@", @"Butts");
}

-(void)socketIODidConnect:(SocketIO *)socket {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"reg" forKey:WS_OUR_NAME];
    
    NSLog(@"Butts");
    [socketIO sendEvent:@"json" withData:dict];
    NSLog(@"Moarbutts");
}

@end