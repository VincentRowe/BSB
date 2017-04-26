//
//  UIBarButtonItem+VtcItem.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/23.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "UIBarButtonItem+VtcItem.h"

@implementation UIBarButtonItem (VtcItem)

#pragma mark - 快速创建UIBarButtonItem
+ (UIBarButtonItem *)itemWithNormalImageName:(UIImage *)normalImageName highlightedImageName:(UIImage *)hightlightedImageName target:(id)target action:(SEL)action{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:normalImageName forState:UIControlStateNormal];
    [btn setImage:hightlightedImageName forState:UIControlStateHighlighted];
    
    [btn sizeToFit];
    
    // 问题：把UIButton包装成UIBarButtonItem，就导致按钮点击区域扩大
    // 解决：
    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    [containView addSubview:btn];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:containView];
}

+ (UIBarButtonItem *)itemWithNormalImageName:(UIImage *)normalImageName selectedImageName:(UIImage *)selectedImageName target:(id)target action:(SEL)action {

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:normalImageName forState:UIControlStateNormal];
    [btn setImage:selectedImageName forState:UIControlStateSelected];
    
    [btn sizeToFit];
    
    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    [containView addSubview:btn];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:containView];
}

#pragma mark - 快速创建返回按钮
+ (UIBarButtonItem *)backWithNormalImageName:(UIImage *)normalImageName highlightedImageName:(UIImage *)hightlightedImageName target:(id)target action:(SEL)action title:(NSString *)title{
    
    // 设置导航条左边按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [backButton setImage:normalImageName forState:UIControlStateNormal];
    [backButton setImage:hightlightedImageName forState:UIControlStateHighlighted];
    
    [backButton sizeToFit];
    
//    backButton.backgroundColor = [UIColor orangeColor];
//    
//    UIView *containView = [[UIView alloc] initWithFrame:backButton.bounds];
//    containView.backgroundColor = [UIColor orangeColor];
//    [containView addSubview:backButton];

    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

+ (UIBarButtonItem *)backWithNormalImageName:(UIImage *)normalImageName selectedImageName:(UIImage *)selectedImageName target:(id)target action:(SEL)action title:(NSString *)title{
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [backButton setImage:normalImageName forState:UIControlStateNormal];
    [backButton setImage:selectedImageName forState:UIControlStateSelected];
    
    [backButton sizeToFit];
    
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    backButton.backgroundColor = [UIColor orangeColor];
    
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
}
@end
