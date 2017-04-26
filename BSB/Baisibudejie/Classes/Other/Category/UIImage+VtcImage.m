//
//  UIImage+VtcImage.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/21.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "UIImage+VtcImage.h"

@implementation UIImage (VtcImage)

+ (instancetype)imageOriginalWithName:(NSString *)imageName {

    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return image;
}

- (instancetype)vtc_circleImage {
    
    //1.开启图形上下文
    //比例因素：当前点与像素比例
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    // 2.描述裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    // 3.设置裁剪区域
    [path addClip];
    
    // 4.画图片
    [self drawAtPoint:CGPointZero];
    
    // 5.取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)vtc_circleImageWithImage:(NSString *)imageName {
    
    return [[self imageNamed:imageName] vtc_circleImage];
}

@end
