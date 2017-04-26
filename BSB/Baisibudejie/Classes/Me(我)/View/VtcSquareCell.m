//
//  VtcSquareCell.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/3/4.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcSquareCell.h"
#import <UIImageView+WebCache.h>

#import "VtcSquareItem.h"

@interface VtcSquareCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;

@end

@implementation VtcSquareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(VtcSquareItem *)item {

    _item = item;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    self.nameView.text = item.name;
}

@end
