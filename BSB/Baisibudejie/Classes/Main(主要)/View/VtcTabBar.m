//
//  VtcTabBar.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/21.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcTabBar.h"

@interface VtcTabBar ()
@property (nonatomic, weak) UIButton *publishButton;

@property (nonatomic, weak) UIControl *previousClickTabBarButton;
@end

@implementation VtcTabBar

- (UIButton *)publishButton {

    if (_publishButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        
        [self addSubview:btn];
        _publishButton = btn;
    }
    return _publishButton;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    
    NSInteger count = self.items.count;
    //跳转tabBarButton的位置
    CGFloat btnW = self.vtc_width / (count + 1);
    CGFloat btnH = self.vtc_height;
    CGFloat x = 0;
    int index = 0;
//    NSLog(@"%@",self.subviews);
    
    //遍历控件 调整布局
    for (UIControl *tabbarButton in self.subviews) {
        //私有类：打印出来有类，但是巧不出来，说明这个类是系统私有类
        //使用反编译，通过字符串访问class
        if ([tabbarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            //设置previousClickTabBarButton默认值位为最前面的按钮
            if (index == 0 && self.previousClickTabBarButton == nil) {
                self.previousClickTabBarButton = tabbarButton;
            }
            
            if (index == 2) {
                index += 1;
            }
            x = index *btnW;
            tabbarButton.frame = CGRectMake(x, 0, btnW, btnH);
            
            index++;
            
            // 监听点击
            //UIControlEventTouchDownRepeat:在短时间内连续点击按钮
            [tabbarButton addTarget:self action:@selector(tabBatButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
    }
    
    // 调整发布按钮位置
    self.publishButton.center = CGPointMake(self.vtc_width * 0.5, self.vtc_height * 0.5);
}
#pragma mark - tabBarButton的点击
- (void)tabBatButtonClick:(UIControl *)tabBarButton {

    if (self.previousClickTabBarButton == tabBarButton) {
//        VtcFunc;
        
        // 发出通知，告诉外界tabBarButton被重复点击了
        [[NSNotificationCenter defaultCenter] postNotificationName:VtcTabBarButtonDidRepeatClickNotification object:nil];
    }
    
    self.previousClickTabBarButton = tabBarButton;
}

@end
