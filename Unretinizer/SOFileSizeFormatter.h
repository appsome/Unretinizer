//
//  SOFileSizeFormatter.h
//  Unretinizer
//
//  Created by Wojtek Siudzinski on 12/6/12.
//  Copyright (c) 2012 Appsome. All rights reserved.
//
//  Based on: http://stackoverflow.com/a/4716523/83055

#import <Foundation/Foundation.h>

@interface SOFileSizeFormatter : NSNumberFormatter
{
    @private
    BOOL useBaseTenUnits;
}

/** Flag signaling whether to calculate file size in binary units (1024) or base ten units (1000).  Default is binary units. */
@property (nonatomic, readwrite, assign, getter=isUsingBaseTenUnits) BOOL useBaseTenUnits;

- (NSString *) stringFromNumber:(NSNumber *)number;
- (NSString *) stringFromInteger:(NSInteger)integer;

@end
