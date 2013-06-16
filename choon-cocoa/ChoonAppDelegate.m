//
//  ChoonAppDelegate.m
//  choon-cocoa
//
//  Created by Richo Healey on 14/06/13.
//  Copyright (c) 2013 Richo Healey. All rights reserved.
//

#import "ChoonAppDelegate.h"
#import "ChoonSocket.h"

#import <dispatch/dispatch.h>

@implementation ChoonAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

-(void)awakeFromNib{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];


    //NSBundle *bundle = [NSBundle mainBundle];
    //NSString *path = [bundle pathForResource:@"crowbar" ofType:@"tif"];
    //NSImage *menuIcon= [[NSImage alloc] initWithContentsOfFile:path];
    //[statusItem setImage:menuIcon];

    [statusItem setTitle:@"Choon"];
    [statusItem setHighlightMode:YES];

    [self initMenu];
    [self initSocket];
}

-(void)initMenu{
    [statusMenu addItem:[[NSMenuItem alloc]
                         initWithTitle:@"Quit"
                         action:@selector(terminate:)
                         keyEquivalent:@""]];
}

-(void)initSocket{
    char *host = "localhost";
    int port = 4949;

    ChoonSocket *socket = [[ChoonSocket alloc] init];
    NSLog(@"Dispatching the network thread");
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        // Call into our sync network handler
        [socket connectTo:host port:port];
        [socket mainloop];
    });
}

@end
