//
//  HeroTableViewCell.m
//  GameWithMonsterList
//
//  Created by 张真 on 2017/9/13.
//  Copyright © 2017年 张真. All rights reserved.
//

#import "HeroTableViewCell.h"

@implementation HeroTableViewCell


//实现类方法
 +(instancetype)HeroTableViewCell {
     
     return [[[NSBundle mainBundle] loadNibNamed:@"HeroTableViewCell" owner:nil options:nil] lastObject];
     
 }

/**
 初始化数据
 */
-(void)initData
{
}

-(void)clickBtn
{
    NSLog(@"fdaklfjdal");
}

/**
 更改收藏状态
 */
-(void)changeHeroFavorWithStatus:(BOOL)isFavor
{
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UISwitch class]])
    {
        return NO;
    }
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

-(void)setDataWithSor:(HeroData *)data
{
    self.lblUserName.font = [UIFont fontWithName:@"Arial" size:18];
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    self.heroData = data;
    self.imgAvatar.image = [UIImage imageNamed:[data.heroName lowercaseString] ];
    self.lblUserName.text = data.heroCNName;
    
}

@end
