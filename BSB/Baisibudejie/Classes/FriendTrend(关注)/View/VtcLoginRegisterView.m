//
//  VtcLoginRegisterView.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/28.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcLoginRegisterView.h"

@interface VtcLoginRegisterView ()

@property (weak, nonatomic) IBOutlet UIButton *loginRegisterBtn;

@end

@implementation VtcLoginRegisterView

+ (instancetype)loginView {

    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype)registerView {

    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    
    UIImage *image = self.loginRegisterBtn.currentBackgroundImage;
    
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
    //让图片背景不要拉伸
    [self.loginRegisterBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    [super awakeFromNib];
}

@end
