//
//  UIImage+UIColor.m
//  detailTabelView
//
//  Created by I on 2017/5/4.
//  Copyright © 2017年 QT. All rights reserved.
//

#import "UIImage+UIColor.h"

@implementation UIImage (UIColor)

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
    
}

@end
