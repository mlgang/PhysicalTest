//
//  ToolObjc.h
//  PhysicalTest
//
//  Created by jay on 2019/3/27.
//  Copyright © 2019 jay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToolObjc : NSObject

+ (void)gotoMainViewControllerWithUser:(UserModel *)user;
+ (void)gotoLoginViewControlelr;

@end

NS_ASSUME_NONNULL_END
