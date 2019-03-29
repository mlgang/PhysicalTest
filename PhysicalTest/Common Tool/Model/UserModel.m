//
//  UserModel.m
//  PhysicalTest
//
//  Created by jay on 2019/3/28.
//  Copyright © 2019 jay. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.result = [dic objectForKey:@"resault"];
        self.height = [dic objectForKey:@"stature"];
        self.weight = [dic objectForKey:@"weight"];
        self.chining = [dic objectForKey:@"vital_capacity"];
        self.capacity = [dic objectForKey:@"chinning"];
        self.jump = [dic objectForKey:@"standing_long_jump"];
        self.kilometer = [dic objectForKey:@"1000_meters"];
        self.fiveMeters = [dic objectForKey:@"50_meters"];
        self.sitAndDown = [dic objectForKey:@"sit_and_reach"];
        self.score = [dic objectForKey:@"score"];
    }
    return self;
}

@end
