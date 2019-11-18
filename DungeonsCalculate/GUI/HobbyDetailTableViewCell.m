//
//  HobbyDetailTableViewCell.m
//  DungeonsCalculate
//
//  Created by 张真 on 2019/8/28.
//  Copyright © 2019 lionelzhang. All rights reserved.
//

#import "HobbyDetailTableViewCell.h"

@implementation HobbyDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//实现类方法
+(instancetype)HobbyDetailTableViewCell {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"HobbyDetailTableViewCell" owner:nil options:nil] lastObject];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataWithSor:(ResultData *)result
{
    self.imgHero1.image = [UIImage imageNamed:[result.hero1 lowercaseString]];
    self.imgHero2.image = [UIImage imageNamed:[result.hero2 lowercaseString]];
    self.imgHero3.image = [UIImage imageNamed:[result.hero3 lowercaseString]];
    self.imgHero4.image = [UIImage imageNamed:[result.hero4 lowercaseString]];
    
    self.lblRightHero1.text = result.result1;
    self.lblRightHero2.text = result.result2;
}

@end
