//
//  HobbyDetailTableViewCell.h
//  DungeonsCalculate
//
//  Created by 张真 on 2019/8/28.
//  Copyright © 2019 lionelzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultData.h"

NS_ASSUME_NONNULL_BEGIN

@interface HobbyDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgHero1;
@property (weak, nonatomic) IBOutlet UIImageView *imgHero2;
@property (weak, nonatomic) IBOutlet UIImageView *imgHero3;
@property (weak, nonatomic) IBOutlet UIImageView *imgHero4;
@property (weak, nonatomic) IBOutlet UILabel *lblRightHero1;
@property (weak, nonatomic) IBOutlet UILabel *lblRightHero2;

+(instancetype)HobbyDetailTableViewCell;

- (void)setDataWithSor:(ResultData *)result;

@end

NS_ASSUME_NONNULL_END
