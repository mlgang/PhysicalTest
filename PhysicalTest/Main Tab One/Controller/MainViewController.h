//
//  MainViewController.h
//  PhysicalTest
//
//  Created by jay on 2019/3/27.
//  Copyright © 2019 jay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController

@property (nonatomic,strong)UITableView *myTable;
@property (nonatomic,copy)NSArray *titArr;
@property (nonatomic,strong)NSMutableArray *scoreArr;
@property (nonatomic,strong)UserModel *user;

@end

NS_ASSUME_NONNULL_END
