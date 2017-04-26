//
//  VtcFastLoginView.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/3/3.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcFastLoginView.h"

@implementation VtcFastLoginView


+ (instancetype)fastLoginView {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
