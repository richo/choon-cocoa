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
    Spotify = [SBApplication applicationWithBundleIdentifier:@"com.spotify.client"];
    current = iTunes;
    return self;
}

-(void) setCurrent:(PROXY_TYPE)client {
    switch(client) {
        case PROXY_ITUNES:
            current = iTunes;
            break;
        case PROXY_SPOTIFY:
            current = Spotify;
            break;
    }
}

-(void) next {
    [current nextTrack];
}

-(void) prev {
    [current previousTrack];
}

-(void) toggle_play {
    [current playpause];
}


@end
