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
    [self initNotifier];
    [self initSocket];
}

-(void)initMenu{
    [statusMenu addItem:[[NSMenuItem alloc]
                         initWithTitle:@"Quiet"
                         action:@selector(toggle_quiet:)
                         keyEquivalent:@""]];

    [statusMenu addItem:[NSMenuItem separatorItem]];

    [statusMenu addItem:[[NSMenuItem alloc]
                         initWithTitle:@"Quit"
                         action:@selector(terminate:)
                         keyEquivalent:@""]];
}

-(void)toggle_quiet:(NSMenuItem*)sender{
    if (*_quiet) {
        NSLog(@"Setting to noisy");
        [sender setState: NSOffState];
        *_quiet = FALSE;
    } else {
        NSLog(@"Setting to quiet");
        [sender setState: NSOnState];
        *_quiet = TRUE;
    }
}

-(void)initNotifier{
    _quiet = malloc(sizeof(bool));
    *_quiet = FALSE;
    notifier = [[ChoonNotificationProxy alloc] init:_quiet];
}

-(void)initSocket{
    char *host = "app.choon.io";
    int port = 4949;

    ChoonSocket *socket = [[ChoonSocket alloc] init:notifier];
    NSLog(@"Dispatching the network thread");
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        // Call into our sync network handler
        [socket connectTo:host port:port main:TRUE];
    });
}

@end
