//
//  ChoonAppDelegate.h
//  choon-cocoa
//
//  Created by Richo Healey on 14/06/13.
//  Copyright (c) 2013 Richo Healey. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ChoonAppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSMenu *statusMenu;
    NSStatusItem * statusItem;
}

-(void)initMenu;

@property (assign) IBOutlet NSWindow *window;

@end
