//
//  UIImageAdditions.h
//  munduIM
//
//  Created by Vinay Chavan on 12/08/10.
//  Copyright 2010 Geodesic. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (RoundedCorner)
- (UIImage*)imageWithRoundedCorner:(int)corner;
@end

@interface UIImage (Resize)
- (UIImage*)imageWithSize:(CGSize)targetSize;
- (UIImage*)imageByAspectFillForSize:(CGSize)targetSize;
@end

@interface UIImage (Mask)
- (UIImage*)imageWithMask:(UIImage*)mask;
@end

