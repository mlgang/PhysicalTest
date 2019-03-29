//
//  ViewController.m
//  PhysicalTest
//
//  Created by jay on 2019/3/27.
//  Copyright © 2019 jay. All rights reserved.
//

#import "ViewController.h"
#import "ToolObjc.h"
#import <Masonry.h>
#import "NetworkTool.h"
#import "UserModel.h"
#import <MBProgressHUD.h>
#import "SingleObj.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()

@property (nonatomic,strong)CMPedometer *pedometer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}
- (void)getStepCount{
    SingleObj *obj = [SingleObj share];
    
    //步数。。。
    _pedometer = [[CMPedometer alloc] init];// pedometer 计步器
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    //开始日期
    NSDate *startDate = [calendar dateFromComponents:components];
    //结束日期
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    
    //判断记步功能
    if ([CMPedometer isStepCountingAvailable]) {
        [_pedometer queryPedometerDataFromDate:startDate toDate:endDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            if (error) {
                NSLog(@"error==%@",error);
            }else{
                NSLog(@"bu shu == %@",pedometerData.numberOfSteps);
                NSLog(@"ju li == %@",pedometerData.distance);
                obj.stepsNumber = [pedometerData.numberOfSteps floatValue];
                obj.distance = [pedometerData.distance floatValue];
                //NSLog(@"%@-%@",[pedometerData.numberOfSteps stringValue],obj.distance);
            }
        }];
    }else{
        NSLog(@"don't avaiable");
    }
}
- (void)configUI{
    _bgImageView = [[UIImageView alloc] init];
    _bgImageView.frame = [[UIScreen mainScreen] bounds];
    _bgImageView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_bgImageView];
    //---------up
    UIView *upView = [[UIView alloc] init];
    //upView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:upView];
    [upView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(-50);
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.height.mas_equalTo(50);
    }];
    _headImageView = [[UIImageView alloc] init];
    _headImageView.image = [UIImage imageNamed:@"account"];
    [upView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(upView);
        make.left.equalTo(upView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    _accountTextField = [[UITextField alloc] init];
    _accountTextField.backgroundColor = [UIColor whiteColor];
    _accountTextField.layer.cornerRadius = 5;
    _accountTextField.layer.masksToBounds = YES;
    _accountTextField.placeholder = @"请输入账号";
    [upView addSubview:_accountTextField];
    [_accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upView);
        make.left.equalTo(self.headImageView.mas_right).offset(5);
        make.right.equalTo(upView);
        make.height.equalTo(upView);
    }];
    //---------down
    UIView *downView = [[UIView alloc] init];
    //downView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:downView];
    [downView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upView.mas_bottom).offset(10);
        make.left.right.equalTo(upView);
        make.height.mas_equalTo(50);
    }];
    _pwdImageView = [[UIImageView alloc] init];
    _pwdImageView.image = [UIImage imageNamed:@"mima"];
    [downView addSubview:_pwdImageView];
    [_pwdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(downView);
        make.left.equalTo(downView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    _pwdTextField = [[UITextField alloc] init];
    _pwdTextField.backgroundColor = [UIColor whiteColor];
    _pwdTextField.layer.cornerRadius = 5;
    _pwdTextField.layer.masksToBounds = YES;
    _pwdTextField.placeholder = @"请输入密码";
    [downView addSubview:_pwdTextField];
    [_pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(downView);
        make.left.equalTo(self.pwdImageView.mas_right).offset(5);
        make.right.equalTo(downView);
        make.height.equalTo(downView);
    }];
    //提交按钮
    UIButton *subButton = [UIButton buttonWithType:UIButtonTypeCustom];
    subButton.backgroundColor = [UIColor lightGrayColor];
    subButton.layer.cornerRadius = 10;
    [subButton setTitle:@"登录" forState:UIControlStateNormal];
    subButton.layer.masksToBounds = YES;
    [self.view addSubview:subButton];
    [subButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(downView.mas_bottom).offset(20);
        make.left.right.equalTo(downView);
        make.height.mas_equalTo(44);
    }];
}
- (void)btnClick{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    
    if (_accountTextField.text.length <=0) {
        hud.label.text = @"账号不能为空";
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:0.7];
        return;
    }
    if (_pwdTextField.text.length <=0) {
        hud.label.text = @"密码不能为空";
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:0.7];
        return;
    }
    [NetworkTool loginWithName:_accountTextField.text andPassword:_pwdTextField.text completionBlock:^(NSDictionary * _Nonnull dic) {
        UserModel *user = [[UserModel alloc] initWithDic:dic];

        if ([user.result isEqualToString:@"ture"]) {
            hud.label.text = @"登录成功";
            hud.removeFromSuperViewOnHide = YES;
            [hud hideAnimated:YES afterDelay:0.7];
            [ToolObjc gotoMainViewControllerWithUser:user];
        }else{
            hud.label.text = @"账号或密码错误";
            hud.removeFromSuperViewOnHide = YES;
            [hud hideAnimated:YES afterDelay:0.7];
        }
    }];
    //[ToolObjc gotoMainViewController];
}

@end
