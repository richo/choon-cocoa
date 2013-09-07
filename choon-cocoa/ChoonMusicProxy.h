//
//  ChoonMusicProxy.h
//  choon-cocoa
//
//  Created by Richo Healey on 17/06/13.
//  Copyright (c) 2013 Richo Healey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iTunes.h"
#import "Spotify.h"

typedef enum {
    PROXY_ITUNES,
    PROXY_SPOTIFY
} PROXY_TYPE;

@interface ChoonMusicProxy : NSObject {
    iTunesApplication *iTunes;
    SpotifyApplication *Spotify;
    id current;
}

-(id) init;

-(void) next;
-(void) prev;
-(void) toggle_play;
-(void) setCurrent:(PROXY_TYPE)client;

@end
