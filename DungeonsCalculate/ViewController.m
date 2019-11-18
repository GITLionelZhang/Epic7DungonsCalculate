//
//  ViewController.m
//  DungeonsCalculate
//
//  Created by 张真 on 2019/8/28.
//  Copyright © 2019 lionelzhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"resource" ofType:@"txt"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *dataArr = [content componentsSeparatedByString:@"_"];
    heroList = [[NSMutableArray alloc]init];
    
    searchList = [[NSMutableArray alloc]init];
    
    selectedList = [[NSMutableDictionary alloc]init];
    
    count = 0;
    
    for(int i = 0 ; i < dataArr.count -1 ; i++)
    {
        NSArray *dataDetail = [dataArr[i] componentsSeparatedByString:@"|"];
        
        NSArray *heroBase = [dataDetail[0] componentsSeparatedByString:@","];
        
        NSArray *chatArr = [dataDetail[1] componentsSeparatedByString:@","];
        
        HeroData *heroData = [[HeroData alloc]init];
        heroData.userId = i;
        heroData.heroName = [heroBase[0] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        heroData.heroCNName = [heroBase[1] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        heroData.chatTopic1 = heroBase[2];
        heroData.chatTopic2 = heroBase[3];
        imgList = [[NSArray alloc]initWithObjects:self.imgHero1,self.imgHero2,self.imgHero3,self.imgHero4, nil];
        
        heroData.chatDict= [[NSMutableDictionary alloc]init];
        
        for(int j = 0 ; j < chatArr.count - 1;j+=2)
        {
            NSMutableArray *chatList = [chatArr[j] componentsSeparatedByString:@"（"];
            chatList[1] = [chatList[1] stringByReplacingOccurrencesOfString:@"）" withString:@""];
            
            [heroData.chatDict setObject:[NSString stringWithFormat:@"%@,%@",chatList[1],chatArr[j+1]] forKey:chatList[0]];
        }
        
        [heroList addObject:heroData];
        
        NSLog(@"");
    }
    
    self.tvHeroList.delegate = self;
    self.tvHeroList.dataSource = self;
    self.sbHero.delegate = self;
    
    //存入数组并同步
//                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"HobbyDetail"];
//
//                [[NSUserDefaults standardUserDefaults] synchronize];
    
     self.tvHeroList.userInteractionEnabled = YES;
    
    [self.btnClear addTarget:self action:@selector(clearResult:) forControlEvents:UIControlEventTouchDown];
    [self.btnMyFav addTarget:self action:@selector(myFav:) forControlEvents:UIControlEventTouchDown];
    [self.btnAddFav addTarget:self action:@selector(addFav:) forControlEvents:UIControlEventTouchDown];
    [self.btnCuiHuaJi addTarget:self action:@selector(showCuiHuaJi:) forControlEvents:UIControlEventTouchDown];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if(img != nil)
    {
       [img removeFromSuperview];
    }
    if(toolbar != nil)
    {
        [toolbar removeFromSuperview];
    }
}

- (void)showCuiHuaJi:(UIButton *)btn
{
    if(img == nil)
    {
        UIImage *sorImg = [UIImage imageNamed:@"cuihuaji"];
        
        float nowWidth = self.view.frame.size.width;
        float nowHeight = nowWidth/sorImg.size.width * sorImg.size.height;
        img = [[UIImageView alloc]init];
        img.image = sorImg;
        img.frame = CGRectMake(0, (self.view.frame.size.height - nowHeight)/2.0f, nowWidth, nowHeight);
        
         toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        //样式
        toolbar.barStyle = UIBarStyleBlackTranslucent;//半透明
        //透明度
        toolbar.alpha = 1.0f;
    }
    [self.view addSubview:toolbar];
    [self.view addSubview:img];
}

- (void)clearResult:(UIButton *)btn
{
    for(int i = 0 ; i < imgList.count ; i++)
    {
        ((UIImageView *)imgList[i]).image = [UIImage imageNamed:@"bg"];
    }
    count = 0;
    selectedList = [[NSMutableDictionary alloc]init];
}

- (void)myFav:(UIButton *)btn
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HobbyDetailViewController *receive = [storyboard instantiateViewControllerWithIdentifier:@"HobbyDetailViewController"];
    [self.navigationController pushViewController:receive animated:YES];
}

- (void)addFav:(UIButton *)btn
{
    [self calculateResult];
    if(resultList != nil && resultList.count >=2)
    {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"结果为\n%@\n%@\n是否添加到收藏吗？",((ResultSortData *)resultList[0]).result,((ResultSortData *)resultList[1]).result] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancelAc = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //点击取消要执行的代码
        }];
        UIAlertAction *comfirmAc = [UIAlertAction actionWithTitle:@"添加收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self clearResult:self.btnClear];
            NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"HobbyDetail"];
            if(arr == nil)
            {
                arr =[[NSMutableArray alloc]init];
            }
            
            NSMutableString *result = [NSMutableString stringWithFormat:@"%@_%@_%@_%@|%@_%@",((HeroData *)heroTempList[0]).heroName,((HeroData *)heroTempList[1]).heroName,((HeroData *)heroTempList[2]).heroName,((HeroData *)heroTempList[3]).heroName,((ResultSortData *)resultList[0]).result,((ResultSortData *)resultList[1]).result];
            
            BOOL isexist = NO;
            for(int i = 0 ; i < arr.count ;i++)
            {
                if([arr[i] isEqualToString:result])
                {
                    isexist = YES;
                }
            }
            NSMutableArray* newArr = [[NSMutableArray alloc]initWithArray:arr];
            
            if(!isexist)
            {
                [newArr addObject:result];
                //存入数组并同步
                [[NSUserDefaults standardUserDefaults] setObject:newArr forKey:@"HobbyDetail"];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            
            //读取存入的数组 打印
//            ViewController *view3 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"showDetail"];
//            [self presentViewController:view3 animated:YES completion:nil];
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            HobbyDetailViewController *receive = [storyboard instantiateViewControllerWithIdentifier:@"HobbyDetailViewController"];
            [self.navigationController pushViewController:receive animated:YES];
            
            NSLog(@"%@",arr);
        }];
        [alertVC addAction:cancelAc];
        [alertVC addAction:comfirmAc];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if([searchText isEqualToString:@""])
    {
        isSearch = NO;
        [self.tvHeroList reloadData];
    }
    
    searchList = [[NSMutableArray alloc]init];
    isSearch = YES;
    for(int i = 0; i< heroList.count;i++)
    {
        HeroData* heroData = heroList[i];
        if([[heroData.heroCNName lowercaseString] containsString:[searchText lowercaseString]] || [[heroData.heroName lowercaseString] containsString:[searchText lowercaseString]])
        {
            [searchList addObject:heroData];
        }
    }
    
    [self.tvHeroList reloadData];
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.sbHero resignFirstResponder];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = [NSString stringWithFormat:@"Hero%d",indexPath.row];
    
    HeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        //这里换成自己定义的cell,并调用类方法加载xib文件
        cell = [[HeroTableViewCell HeroTableViewCell] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        [cell initData];
        cell.delegate = self;
    }
    if(isSearch)
    {
        if(searchList.count > indexPath.row)
        {
            [cell setDataWithSor:searchList[indexPath.row]];
        }
    }
    else
    {
        if(heroList.count > indexPath.row)
        {
            [cell setDataWithSor:heroList[indexPath.row]];
        }
    }
    return cell;
}

-(void)clickFavor:(UISwitch*)sw
{
    NSLog(@"");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(count >=4)
        return;
    NSString *result;
    
    HeroData *heroData;
    if(isSearch)
        heroData = searchList[indexPath.row];
    else
        heroData = heroList[indexPath.row];
    if([selectedList objectForKey:[NSString stringWithFormat:@"%d",heroData.userId]] != nil)
        return;
    [selectedList setObject:@"" forKey:[NSString stringWithFormat:@"%d",heroData.userId]];
    
    ((UIImageView *) imgList[count]).image = [UIImage imageNamed:[heroData.heroName lowercaseString]];
    
     count++;
    result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isSearch)
        return searchList.count;
    return heroList.count;
}

- (void)calculateResult
{
    heroTempList = [[NSMutableArray alloc]init];
    for( NSString *key in selectedList)
    {
        [heroTempList addObject:heroList[[key intValue]]];
    }
    
    resultList = [[NSMutableArray alloc]init];
    
    for(int i = 0; i < heroTempList.count ;i++)
    {
        HeroData *baseHeroData = heroTempList[i];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        NSMutableString *result = [[NSMutableString alloc]init];
        int score1 = 0;
        int score2 = 0;
        
        NSString *chatTopicCN1;
        NSString *chatTopicCN2;
        for(int j = 0 ; j < heroTempList.count;j++)
        {
            if(i == j)
                continue;
            HeroData *compareHeroData = heroTempList[j];
            
            NSString *tempStr1 = [compareHeroData.chatDict objectForKey:baseHeroData.chatTopic1];
            NSArray *tempArr1= [tempStr1 componentsSeparatedByString:@","];
            
            chatTopicCN1 = tempArr1[0];
            score1 += [tempArr1[1] intValue];
            
            NSString *tempStr2 = [compareHeroData.chatDict objectForKey:baseHeroData.chatTopic2];
            NSArray *tempArr2 = [tempStr2 componentsSeparatedByString:@","];
            chatTopicCN2 = tempArr2[0];
            score2 += [tempArr2[1] intValue];
            NSLog(@"");
        }
        
        NSMutableString *resultKey = [NSString stringWithFormat:@"%@,%@,%d",baseHeroData.heroCNName,chatTopicCN1,score1];
        ResultSortData *resultSortData = [[ResultSortData alloc]init];
        resultSortData.result = resultKey;
        resultSortData.value = score1;
        [resultList addObject:resultSortData];
        resultKey = [NSString stringWithFormat:@"%@,%@,%d",baseHeroData.heroCNName,chatTopicCN2,score2];
        ResultSortData *resultSortData1 = [[ResultSortData alloc]init];
        resultSortData1.result = resultKey;
        resultSortData1.value = score2;
        [resultList addObject:resultSortData1];
        
    }
    
    [resultList sortUsingComparator:^NSComparisonResult(ResultSortData * obj1, ResultSortData* obj2) {
        return obj2.value - obj1.value;
    }];
    if(resultList.count >=2)
    {
        NSArray *tmpArr1 = [((ResultSortData *)resultList[0]).result componentsSeparatedByString:@","];
        NSArray *tmpArr2 = [((ResultSortData *)resultList[1]).result componentsSeparatedByString:@","];
        if([tmpArr1[1] isEqualToString:tmpArr2[1]])
        {
            [resultList removeObjectAtIndex:1];
        }
    }

    NSLog(@"");
}


@end
