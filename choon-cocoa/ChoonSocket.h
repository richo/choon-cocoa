//
//  ChoonSocket.h
//  choon-cocoa
//
//  Created by Richo Healey on 15/06/13.
//  Copyright (c) 2013 Richo Healey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../socket.IO-objc/SocketIO.h"

@interface ChoonSocket : NSObject <SocketIODelegate> {
    SocketIO *socketIO;
}

- (id) init;
- (void) connectTo:(NSString*) host port:(NSInteger*)port;

//- (void) socketIODidConnect:(SocketIO *)socket;
//- (void) socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error;
//- (void) socketIO:(SocketIO *)socket didReceiveMessage:(SocketIOPacket *)packet;
//- (void) socketIO:(SocketIO *)socket didReceiveJSON:(SocketIOPacket *)packet;
//- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet;
//- (void) socketIO:(SocketIO *)socket didSendMessage:(SocketIOPacket *)packet;
//- (void) socketIO:(SocketIO *)socket onError:(NSError *)error;

@end
