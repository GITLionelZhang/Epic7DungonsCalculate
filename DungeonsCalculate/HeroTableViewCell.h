//
//  HeroTableViewCell.h
//  GameWithMonsterList
//
//  Created by 张真 on 2017/9/13.
//  Copyright © 2017年 张真. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroTableViewCellDelegate.h"
#import "HeroData.h"


@interface HeroTableViewCell : UITableViewCell
{
}

@property(nonatomic,assign) id<HeroTableViewCellDelegate> delegate;

@property (nonatomic) int heroId;


/**
 初始化数据
 */
-(void)initData;

+(instancetype)HeroTableViewCell;
@property (nonatomic) HeroData *heroData;

@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;


/**
 更改收藏状态
 */
-(void)changeHeroFavorWithStatus:(BOOL)isFavor;

-(void)setDataWithSor:(HeroData *)data;

@end
