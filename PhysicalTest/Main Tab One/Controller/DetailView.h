//
//  DetailView.h
//  PhysicalTest
//
//  Created by jay on 2019/3/28.
//  Copyright © 2019 jay. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailView : UIViewController

@property (nonatomic,strong)UITableView *tableViewDetail;
@property (nonatomic,copy)NSString *explainStr;
@property (nonatomic,copy)NSString *stantardStr;

@end

NS_ASSUME_NONNULL_END
