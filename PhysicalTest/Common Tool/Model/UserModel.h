//
//  UserModel.h
//  PhysicalTest
//
//  Created by jay on 2019/3/28.
//  Copyright © 2019 jay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property (nonatomic,copy)NSString *result;

@property (nonatomic,copy)NSString *weight;//体重
@property (nonatomic,copy)NSString *height;//身高
@property (nonatomic,copy)NSString *fiveMeters;//50米
@property (nonatomic,copy)NSString *sitAndDown;//仰卧起坐
@property (nonatomic,copy)NSString *jump;//立定跳远
@property (nonatomic,copy)NSString *kilometer;//1000米
@property (nonatomic,copy)NSString *chining;//肺活量
@property (nonatomic,copy)NSString *capacity;//引体向上
@property (nonatomic,copy)NSString *score;//总分

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
