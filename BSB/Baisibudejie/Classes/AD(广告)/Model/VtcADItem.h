//
//  VtcADItem.h
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/24.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VtcADItem : NSObject

/** 广告地址 */
@property (nonatomic, strong) NSString *w_picurl;

/** 点击广告跳转地址 */
@property (nonatomic, strong) NSString *ori_curl;

/** 点击广告跳转地址 */
@property (nonatomic, assign) CGFloat w;

/** 点击广告跳转地址 */
@property (nonatomic, assign) CGFloat h;



@end
