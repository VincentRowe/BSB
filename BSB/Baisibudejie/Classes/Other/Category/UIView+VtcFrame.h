//
//  UIView+VtcFrame.h
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/22.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (VtcFrame)

/**
 写分类的时候注意：一定要避免跟其他开发者产生冲突
 */
@property CGFloat vtc_x;
@property CGFloat vtc_y;

@property CGFloat vtc_centerX;
@property CGFloat vtc_centerY;

@property CGFloat vtc_width;
@property CGFloat vtc_height;


@end
