//
//  P2MSSizableTextAttachment.m
//  IOSUtilities
//
//  Created by Pyae Phyo Myint Soe on 25/2/15.
//  Copyright (c) 2015 P2MS. All rights reserved.
//

#import "P2MSSizableTextAttachment.h"

@implementation P2MSSizableTextAttachment

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex{
    CGSize imageSize = [self.image size];
    if (CGSizeEqualToSize(self.boundingSize, CGSizeZero)) {
        return (CGRect){.origin.x = 0, .origin.y = 0, .size.width = imageSize.width, .size.height = imageSize.height};
    }
    CGFloat xFactor = self.boundingSize.width/imageSize.width;
    CGFloat yFactor = self.boundingSize.height/imageSize.height;
    CGFloat minFactor = MIN(xFactor, yFactor);
    return CGRectMake(0, 0, imageSize.width * minFactor, imageSize.height * minFactor);
}

@end
