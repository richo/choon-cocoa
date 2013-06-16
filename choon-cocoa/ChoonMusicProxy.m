//
//  ChoonMusicProxy.m
//  choon-cocoa
//
//  Created by Richo Healey on 17/06/13.
//  Copyright (c) 2013 Richo Healey. All rights reserved.
//

#import "ChoonMusicProxy.h"

@implementation ChoonMusicProxy

-(id) init {
    iTunes = [SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];
    return self;
}

-(void) next {
    [iTunes nextTrack];
}

-(void) prev {
    [iTunes previousTrack];
}


@end
