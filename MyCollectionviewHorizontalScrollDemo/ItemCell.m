//
//  ItemCell.m
//  MyCollectionviewHorizontalScrollDemo
//
//  Created by yf on 2019/2/18.
//  Copyright © 2019年 yf. All rights reserved.
//

#import "ItemCell.h"
#import "Masonry/Masonry.h"

@implementation ItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        [self stepSubView];
    }
    return self;
}

-(void)stepSubView
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"111";
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.contentView);
    }];
}

@end
