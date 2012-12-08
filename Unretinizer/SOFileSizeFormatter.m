//
//  SOFileSizeFormatter.m
//  Unretinizer
//
//  Created by Wojtek Siudzinski on 12/6/12.
//  Copyright (c) 2012 Appsome. All rights reserved.
//

#import "SOFileSizeFormatter.h"

static const char sUnits[] = { '\0', 'K', 'M', 'G', 'T', 'P', 'E', 'Z', 'Y' };
static int sMaxUnits = sizeof sUnits - 1;

@implementation SOFileSizeFormatter

@synthesize useBaseTenUnits;

- (NSString *) stringFromNumber:(NSNumber *)number
{
    int multiplier = useBaseTenUnits ? 1000 : 1024;
    int exponent = 0;
    
    double bytes = [number doubleValue];
    
    while ((bytes >= multiplier) && (exponent < sMaxUnits)) {
        bytes /= multiplier;
        exponent++;
    }
    
    return [NSString stringWithFormat:@"%@ %cB", [super stringFromNumber: [NSNumber numberWithDouble: bytes]], sUnits[exponent]];
}

- (NSString *) stringFromInteger:(NSInteger)integer
{
    return [self stringFromNumber:[NSNumber numberWithInteger:integer]];
}

@end
