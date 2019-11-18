//
//  HeroData.h
//  DungeonsCalculate
//
//  Created by 张真 on 2019/8/28.
//  Copyright © 2019 lionelzhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HeroData : NSObject

@property (nonatomic,strong) NSString *heroName;

@property (nonatomic,strong) NSString *heroCNName;

@property (nonatomic,strong) NSString *chatTopic1;

@property (nonatomic) int userId;

@property (nonatomic,strong) NSString *chatTopic2;

@property (nonatomic,strong) NSMutableDictionary *chatDict;

@end

