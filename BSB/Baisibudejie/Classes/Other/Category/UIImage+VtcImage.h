//
//  UIImage+VtcImage.h
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/21.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (VtcImage)

+ (instancetype)imageOriginalWithName:(NSString *)imageName;


- (instancetype)vtc_circleImage;

+ (instancetype)vtc_circleImageWithImage:(NSString *)imageName;
@end
