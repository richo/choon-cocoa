//
//  ChoonMusicProxy.h
//  choon-cocoa
//
//  Created by Richo Healey on 17/06/13.
//  Copyright (c) 2013 Richo Healey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iTunes.h"

@interface ChoonMusicProxy : NSObject {
    iTunesApplication *iTunes;
}

-(id) init;

-(void) next;
-(void) prev;

@end
