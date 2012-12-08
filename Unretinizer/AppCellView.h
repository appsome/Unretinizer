//
//  AppCellView.h
//  Unretinizer
//
//  Created by Wojtek Siudzinski on 12/6/12.
//  Copyright (c) 2012 Appsome. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppCellView : NSTableCellView

@property (nonatomic, retain) IBOutlet NSTextField *sizeLabel;
@property (nonatomic, retain) IBOutlet NSButton *checkBox;

@end
