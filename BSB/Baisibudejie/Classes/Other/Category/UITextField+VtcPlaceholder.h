//
//  UITextField+VtcPlaceholder.h
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/3/3.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (VtcPlaceholder)

@property UIColor *placeholderColor;

- (void)setVtc_Placeholder:(NSString *)placeholder;
@end
