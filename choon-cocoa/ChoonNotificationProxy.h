//
//  ChoonNotificationProxy.h
//  choon-cocoa
//
//  Created by Richo Healey on 17/06/13.
//  Copyright (c) 2013 Richo Healey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChoonNotificationProxy : NSObject {
    bool *_quiet;
}

-(id) init:(bool *)quiet;
-(void) deliver:(NSString*)title withBody:(NSString*)body;

@end
