//
//  ChoonAppDelegate.h
//  choon-cocoa
//
//  Created by Richo Healey on 14/06/13.
//  Copyright (c) 2013 Richo Healey. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ChoonNotificationProxy.h"

@interface ChoonAppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSMenu *statusMenu;
    NSStatusItem * statusItem;
    ChoonNotificationProxy *notifier;
    bool* _quiet;
}

-(void)initMenu;
-(void)initNotifier;
-(void)initSocket;

-(void)toggle_quiet:(NSMenuItem*)sender;

@property (assign) IBOutlet NSWindow *window;

@end
