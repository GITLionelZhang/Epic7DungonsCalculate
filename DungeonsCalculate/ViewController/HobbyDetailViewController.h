//
//  HobbyDetailViewController.h
//  DungeonsCalculate
//
//  Created by 张真 on 2019/8/28.
//  Copyright © 2019 lionelzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HobbyDetailTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HobbyDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *resultList;
}
@property (weak, nonatomic) IBOutlet UITableView *tvHobbyList;

@end

NS_ASSUME_NONNULL_END
