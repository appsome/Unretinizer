//
//  AppDelegate.h
//  Unretinizer
//
//  Created by Wojtek Siudzinski on 12/5/12.
//  Copyright (c) 2012 Appsome. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate,NSTableViewDataSource,NSTableViewDelegate> {
    BOOL isScanning;
    NSMutableArray *foundApps;
    NSThread *scanningThread;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, strong) IBOutlet NSProgressIndicator *progressIndicator;
@property (nonatomic, strong) IBOutlet NSButton *startButton;
@property (nonatomic, strong) IBOutlet NSView *listView;
@property (nonatomic, strong) IBOutlet NSTextField *totalSizeLabel;

@end
