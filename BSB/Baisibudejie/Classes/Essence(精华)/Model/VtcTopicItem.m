//
//  VtcTopicItem.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/4/7.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcTopicItem.h"

@implementation VtcTopicItem

- (CGFloat)cellHeight {
    
    // 如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    
    // 文字的Y值
    _cellHeight += 55;
    
    // 文字的高度
    CGSize textMaxSize = CGSizeMake(VtcScreenWidth - 2 * VtcMargin, MAXFLOAT);
    
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + VtcMargin;
    
    // 工具条
    _cellHeight += 35 + VtcMargin;
    
    return _cellHeight;
}

@end
