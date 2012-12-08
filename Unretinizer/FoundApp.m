//
//  FoundApp.m
//  Unretinizer
//
//  Created by Wojtek Siudzinski on 12/5/12.
//  Copyright (c) 2012 Appsome. All rights reserved.
//

#import "FoundApp.h"

@implementation FoundApp

@synthesize name, size, isChecked, retinaFiles;
@synthesize path = _path;
@synthesize icon = _icon;
@synthesize displayName = _displayName;

- (id)init {
    self = [super init];
    if (self) {
        retinaFiles = [NSMutableArray new];
    }
    
    return self;
}

- (NSImage *)icon {
	if (_icon) return _icon;
	_icon = [[NSWorkspace sharedWorkspace] iconForFile:self.path];
	return _icon;
}

- (NSString *)displayName {
	if (_displayName) return _displayName;
	_displayName = [[NSFileManager defaultManager] displayNameAtPath:self.path];
	return _displayName;
}

@end
