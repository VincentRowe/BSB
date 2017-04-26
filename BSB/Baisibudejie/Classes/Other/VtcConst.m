//
//  VtcConst.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/3/6.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcConst.h"

/** UITabBar的高度 */
CGFloat const VtcTabBarH = 49;

/** 导航栏的最大Y值 */
CGFloat const VtcNavMaxY = 64;

/** 统一边距 */
CGFloat const VtcMargin = 10;

/** 标题栏的高度 */
CGFloat const VtcTitlesViewH = 35;

/** 基本URL(统一的请求路径) */
UIKIT_EXTERN NSString *const VtcCommonURL = @"http://api.budejie.com/api/api_open.php";

/** TabBarButton被重复点击的通知 */
NSString * const VtcTabBarButtonDidRepeatClickNotification = @"VtcTabBarButtonDidRepeatClickNotification";

/** TitleButton被重复点击的通知 */
NSString * const VtcTitleButtonDidRepeatClickNotification = @"VtcTitleButtonDidRepeatClickNotification";
