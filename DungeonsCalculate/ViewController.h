//
//  ViewController.h
//  DungeonsCalculate
//
//  Created by 张真 on 2019/8/28.
//  Copyright © 2019 lionelzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroData.h"
#import "HeroTableViewCell.h"
#import "ResultSortData.h"
#import "ViewController/HobbyDetailViewController.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,HeroTableViewCellDelegate>
{
    NSMutableArray *heroList;
    
    NSMutableArray *searchList;
    
    BOOL isSearch;
    
    int count;
    
    NSMutableDictionary *selectedList;
    
    NSMutableArray *resultList;
    NSMutableArray *heroTempList;
    NSArray *imgList;
    
    UIImageView *img;
    
    UIToolbar *toolbar;
}
@property (weak, nonatomic) IBOutlet UITableView *tvHeroList;

@property (weak, nonatomic) IBOutlet UISearchBar *sbHero;
@property (weak, nonatomic) IBOutlet UIButton *btnMyFav;
@property (weak, nonatomic) IBOutlet UIButton *btnClear;
@property (weak, nonatomic) IBOutlet UIButton *btnAddFav;
@property (weak, nonatomic) IBOutlet UIImageView *imgHero1;
@property (weak, nonatomic) IBOutlet UIImageView *imgHero2;
@property (weak, nonatomic) IBOutlet UIImageView *imgHero3;
@property (weak, nonatomic) IBOutlet UIImageView *imgHero4;
@property (weak, nonatomic) IBOutlet UIButton *btnCuiHuaJi;

@end

