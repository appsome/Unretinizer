//
//  AppDelegate.m
//  Unretinizer
//
//  Created by Wojtek Siudzinski on 12/5/12.
//  Copyright (c) 2012 Appsome. All rights reserved.
//

#import "AppDelegate.h"
#import "FoundApp.h"
#import "AppCellView.h"
#import "SOFileSizeFormatter.h"

@implementation AppDelegate

@synthesize progressIndicator, startButton, window, listView, totalSizeLabel;

#pragma mark App Delegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    foundApps = [NSMutableArray new];
    if([[NSUserDefaults standardUserDefaults] objectForKey: @"ApplePersistenceIgnoreState"] == nil) [[NSUserDefaults standardUserDefaults] setBool: YES forKey:@"ApplePersistenceIgnoreState"];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

#pragma mark General

- (void)scan {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *basePath = @"/Applications/Utilities";
	NSArray *contents = [manager contentsOfDirectoryAtPath:basePath error:nil];
    
    NSUInteger __block totalSize = 0;
	[contents enumerateObjectsUsingBlock:^(NSString *appFilename, NSUInteger idx, BOOL *stop) {
		if ([appFilename hasSuffix:@".app"]) {
            NSString *itemPath = [basePath stringByAppendingPathComponent:appFilename];

            NSDirectoryEnumerator *enumerator = [manager enumeratorAtURL:[NSURL fileURLWithPath:itemPath] includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles errorHandler:nil];
            
            NSURL *url;
            FoundApp *foundApp = [FoundApp new];
            
            while (url = [enumerator nextObject])
            {
                NSString *filename = [[url absoluteString] stringByReplacingOccurrencesOfString:@"file://localhost" withString:@""];
                if ([filename rangeOfString:@"@2x"].location != NSNotFound) {
                    [foundApp.retinaFiles addObject:filename];
                    foundApp.size += [[[NSFileManager defaultManager] attributesOfItemAtPath:filename error:nil] fileSize];
                    totalSize += foundApp.size;                    
                }
            };
            
            if (([foundApp.retinaFiles count] > 0) && (foundApp.size > 0)) {
                foundApp.path = itemPath;
                [foundApps addObject:foundApp];
            }
        }
	}];
    
    SOFileSizeFormatter *sizeFormatter = [SOFileSizeFormatter new];
    [sizeFormatter setMaximumFractionDigits:2];
    [totalSizeLabel setStringValue:[sizeFormatter stringFromInteger:totalSize]];
    
    isScanning = NO;
    
    [self performSelectorOnMainThread:@selector(showResults) withObject:nil waitUntilDone:NO];
}

- (IBAction)startScan:(id)sender {
    if (isScanning) {
        [progressIndicator stopAnimation:nil];
        [progressIndicator setHidden:YES];
        [startButton setTitle:@"Start scan..."];
        
        if (scanningThread) {
            [scanningThread cancel];
            scanningThread = nil;
        }
    } else {
        [progressIndicator setHidden:NO];
        [progressIndicator startAnimation:nil];
        [startButton setTitle:@"Stop scan"];
        
        scanningThread = [[NSThread alloc] initWithTarget:self selector:@selector(scan) object:nil];
        [scanningThread start];
    }
    isScanning = !isScanning;
}

- (void)showResults {
    [window setFrame:NSMakeRect(window.frame.origin.x, window.frame.origin.y, listView.frame.size.height, listView.frame.size.width) display:YES animate:YES];
    [window setContentView:listView];
}

#pragma mark NSTableView

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [foundApps count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    return [foundApps objectAtIndex:row];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    AppCellView *result = (AppCellView *)[tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    FoundApp *foundApp = [foundApps objectAtIndex:row];
    result.imageView.image = foundApp.icon;
    result.textField.stringValue = foundApp.displayName;
    SOFileSizeFormatter *sizeFormatter = [SOFileSizeFormatter new];
    [sizeFormatter setMaximumFractionDigits:2];
    result.sizeLabel.stringValue = [sizeFormatter stringFromInteger:foundApp.size];
    return result;
}
@end
