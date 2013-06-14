//
//  ChoonAppDelegate.m
//  choon-cocoa
//
//  Created by Richo Healey on 14/06/13.
//  Copyright (c) 2013 Richo Healey. All rights reserved.
//

#import "ChoonAppDelegate.h"

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
}

-(void)initMenu{
    [statusMenu addItem:[[NSMenuItem alloc]
                         initWithTitle:@"Quit"
                         action:@selector(terminate:)
                         keyEquivalent:@""]];
}

@end
