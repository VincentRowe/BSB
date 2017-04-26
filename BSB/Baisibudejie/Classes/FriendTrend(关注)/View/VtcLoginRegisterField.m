//
//  VtcLoginRegisterField.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/3/3.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcLoginRegisterField.h"
#import "UITextField+VtcPlaceholder.h"

@implementation VtcLoginRegisterField

/**
 1.文本框光标变成白色
 2.文本框开始编辑的时候，占位文字颜色变成白色
 */

- (void)awakeFromNib {

    //1.设置光标的颜色为白色
    self.tintColor = [UIColor whiteColor];
    
    //2.文本框开始编辑的时候，占位文字颜色变成白色
    // 监听文本框编辑：1.设置代理 2.通知 3.target
    // 开始编辑
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    
    // 结束编辑
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    //设置占位文字颜色
    //快速设置占位文字颜色 => 文本框占位文字可能是label（通过小面包验证）=> 占位文字是Label => 拿到label => 查看label属性名（1.runtime 2.断点）
    //获取占位文字控件(KVC)
//    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
//    placeholderLabel.textColor = [UIColor lightGrayColor];
    
    //使用分类设置占位颜色
    self.placeholderColor = [UIColor lightGrayColor];
//    [self setVtc_Placeholder:@"你好"];

    //使用attributes设置占位文字颜色
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
//    
    
    [super awakeFromNib];
}

#pragma mark - 文本框开始编辑调用
- (void)textBegin {

    // 设置占位文字颜色变为白色
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];

//    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
//    placeholderLabel.textColor = [UIColor whiteColor];
    
    self.placeholderColor = [UIColor whiteColor];
}

#pragma mark - 当文本框结束编辑的时候调用
- (void)textEnd {
    
    //设置占位文字颜色为灰色
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
//    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
//    placeholderLabel.textColor = [UIColor lightGrayColor];
    
    self.placeholderColor = [UIColor lightGrayColor];
    
    
}

@end
