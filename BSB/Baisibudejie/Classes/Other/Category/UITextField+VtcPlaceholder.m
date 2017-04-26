 //
//  UITextField+VtcPlaceholder.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/3/3.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "UITextField+VtcPlaceholder.h"
#import <objc/message.h>

@implementation UITextField (VtcPlaceholder)

+ (void)load {

    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    
    Method setVtc_PlaceholderMethod = class_getInstanceMethod(self, @selector(setVtc_Placeholder:));
    
    method_exchangeImplementations(setPlaceholderMethod, setVtc_PlaceholderMethod);
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {

    //给成员属性赋值，runtime给系统的类添加成员属性
    //添加成员属性
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //设置占位文字颜色
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor {

    return objc_getAssociatedObject(self, @"placeholderColor");
}

// 设置占位文字，
// 设置占位文字颜色
- (void)setVtc_Placeholder:(NSString *)placeholder {

    [self setVtc_Placeholder:placeholder];
//    self.placeholder = placeholder;
    self.placeholderColor = self.placeholderColor;
}

@end
