//
//  UIBarButtonItem+VtcItem.h
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/23.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (VtcItem)

#pragma mark - 快速创建UIBarButtonItem
+ (UIBarButtonItem *)itemWithNormalImageName:(UIImage *)imageName highlightedImageName:(UIImage *)hightlightedImageName target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithNormalImageName:(UIImage *)normalImageName selectedImageName:(UIImage *)selectedImageName target:(id)target action:(SEL)action;

#pragma mark - 快速创建返回按钮
+ (UIBarButtonItem *)backWithNormalImageName:(UIImage *)normalImageName highlightedImageName:(UIImage *)hightlightedImageName target:(id)target action:(SEL)action title:(NSString *)title;

+ (UIBarButtonItem *)backWithNormalImageName:(UIImage *)normalImageName selectedImageName:(UIImage *)selectedImageName target:(id)target action:(SEL)action title:(NSString *)title;
@end
