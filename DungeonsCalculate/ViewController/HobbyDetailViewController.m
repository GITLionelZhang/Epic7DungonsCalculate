//
//  HobbyDetailViewController.m
//  DungeonsCalculate
//
//  Created by 张真 on 2019/8/28.
//  Copyright © 2019 lionelzhang. All rights reserved.
//

#import "HobbyDetailViewController.h"

@interface HobbyDetailViewController ()

@end

@implementation HobbyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"HobbyDetail"];
    if(arr == nil)
    {
        arr =[[NSMutableArray alloc]init];
    }
    resultList = [[NSMutableArray alloc]init];
    for(int i = 0 ; i < arr.count ;i++)
    {
        ResultData *resultData = [ResultData new];
        NSString *str = arr[i];
        NSArray *dataArr = [str componentsSeparatedByString:@"|"];
        NSArray *heroList = [dataArr[0] componentsSeparatedByString:@"_"];
        resultData.hero1 = heroList[0];
        resultData.hero2 = heroList[1];
        resultData.hero3 = heroList[2];
        resultData.hero4 = heroList[3];
        
        NSArray *resultArr = [dataArr[1] componentsSeparatedByString:@"_"];
        resultData.result1 = resultArr[0];
        resultData.result2 = resultArr[1];
        
        [resultList addObject:resultData];
    }
    
    self.tvHobbyList.delegate = self;
    self.tvHobbyList.dataSource = self;
     self.tvHobbyList.userInteractionEnabled = YES;
    // Do any additional setup after loading the view.
}



- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = [NSString stringWithFormat:@"Hero%d",indexPath.row];
    
    HobbyDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        //这里换成自己定义的cell,并调用类方法加载xib文件
        cell = [[HobbyDetailTableViewCell HobbyDetailTableViewCell] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    [cell setDataWithSor:resultList[indexPath.row]];
    return cell;
}

-(void)clickFavor:(UISwitch*)sw
{
    NSLog(@"");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return resultList.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"HobbyDetail"];
        NSMutableArray *newArr = [[NSMutableArray alloc]initWithArray:arr];
        [newArr removeObjectAtIndex:indexPath.row];
        //存入数组并同步
        [[NSUserDefaults standardUserDefaults] setObject:newArr forKey:@"HobbyDetail"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [resultList removeObjectAtIndex:indexPath.row];
        [self.tvHobbyList reloadData];
        NSLog(@"");
    }
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
