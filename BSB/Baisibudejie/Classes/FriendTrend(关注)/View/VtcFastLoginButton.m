//
//  VtcFastLoginButton.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/3/3.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcFastLoginButton.h"

@implementation VtcFastLoginButton

- (void)layoutSubviews {

    [super layoutSubviews];
    
    //设置图片的位置
    self.imageView.vtc_y = 0;
    self.imageView.vtc_centerX = self.vtc_width * 0.5;
    
    //设置标题的位置
    self.titleLabel.vtc_y = self.vtc_height - self.titleLabel.vtc_height;
    //计算文字的宽度，设置label的宽度
    [self.titleLabel sizeToFit];
    self.titleLabel.vtc_centerX = self.vtc_width * 0.5;
    
    
}

@end
