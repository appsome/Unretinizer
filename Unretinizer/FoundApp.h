//
//  FoundApp.h
//  Unretinizer
//
//  Created by Wojtek Siudzinski on 12/5/12.
//  Copyright (c) 2012 Appsome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoundApp : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) BOOL *isChecked;
@property (nonatomic, strong) NSMutableArray *retinaFiles;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, readonly) NSImage *icon;
@property (nonatomic, readonly) NSString *displayName;

@end
