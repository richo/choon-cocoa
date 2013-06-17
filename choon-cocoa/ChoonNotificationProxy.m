//
//  ChoonNotificationProxy.m
//  choon-cocoa
//
//  Created by Richo Healey on 17/06/13.
//  Copyright (c) 2013 Richo Healey. All rights reserved.
//

#import "ChoonNotificationProxy.h"

@implementation ChoonNotificationProxy

-(id)init:(bool*)quiet {
    _quiet = quiet;
    return self;
}

-(void)deliver:(NSString*)title withBody:(NSString*)body {
    if (*_quiet)
        return;
    NSUserNotification *note =  [[NSUserNotification alloc] init];
    note.title = title;
    if (body != NULL) {
        note.informativeText = body;
    }
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification: note];
}

@end
