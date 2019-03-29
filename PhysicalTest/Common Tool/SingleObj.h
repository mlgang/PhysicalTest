//
//  SingleObj.h
//  GraduateProj
//
//  Created by jay on 2019/2/19.
//  Copyright © 2019 mlg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingleObj : NSObject

@property (nonatomic,assign) float stepsNumber;
@property (nonatomic,assign) float distance;

@property (nonatomic,strong)UIColor *myColor;

+ (instancetype)share;

@end

NS_ASSUME_NONNULL_END
