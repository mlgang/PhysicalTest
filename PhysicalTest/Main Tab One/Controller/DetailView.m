//
//  DetailView.m
//  PhysicalTest
//
//  Created by jay on 2019/3/28.
//  Copyright © 2019 jay. All rights reserved.
//

#import "DetailView.h"

@interface DetailView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DetailView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColorNotificationMethod:) name:@"changeColor" object:nil];
}
- (void)changeColorNotificationMethod:(NSNotification *)noti{
    UILabel *lableOne = [self.view viewWithTag:1031];
    UILabel *labelTwo = [self.view viewWithTag:1032];
    lableOne.backgroundColor = [noti.userInfo objectForKey:@"color"];
    labelTwo.backgroundColor = [noti.userInfo objectForKey:@"color"];
    
}
- (void)configUI{
    _tableViewDetail = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableViewDetail.delegate = self;
    _tableViewDetail.dataSource = self;
    _tableViewDetail.tableHeaderView = [self setStudentHeaderView];
    [_tableViewDetail registerClass:[UITableViewCell class] forCellReuseIdentifier:@"detailCell"];
    [self.view addSubview:_tableViewDetail];
}
#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"detailCell"];
    return cell;
}
- (UIView *)setStudentHeaderView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 300)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    //1
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth([UIScreen mainScreen].bounds)-20, 30)];
    label1.layer.cornerRadius = 3;
    label1.layer.masksToBounds = YES;
    label1.text = @"项目简介";
    label1.backgroundColor = [UIColor colorWithRed:0 green:191/255.f blue:242/255.f alpha:1];
    label1.tag = 1031;
    [bgView addSubview:label1];
    //2安排
    UILabel *label2 = [[UILabel alloc] init];
    label2.font = [UIFont systemFontOfSize:15];
    label2.numberOfLines = 0;
    label2.text = self.explainStr;
    label2.textColor = [UIColor colorWithRed:0 green:191/255.f blue:242/255.f alpha:1];
    CGRect rect = [label2.text boundingRectWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:label2.font} context:nil];
    label2.frame = CGRectMake(20, 30+10, CGRectGetWidth(rect), CGRectGetHeight(rect));
    //label2.backgroundColor = [UIColor greenColor];
    [bgView addSubview:label2];
    //3
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 30+10+10+label2.frame.size.height, CGRectGetWidth([UIScreen mainScreen].bounds)-20, 30)];
    label3.text = @"测量标准";
    label3.tag = 1032;
    label3.layer.cornerRadius = 3;
    label3.layer.masksToBounds = YES;
    label3.backgroundColor = [UIColor colorWithRed:0 green:191/255.f blue:242/255.f alpha:1];
    [bgView addSubview:label3];
    //4安排
    UILabel *label4 = [[UILabel alloc] init];
    label4.font = [UIFont systemFontOfSize:15];
    label4.numberOfLines = 0;
    label4.text = self.stantardStr;
    label4.textColor = [UIColor colorWithRed:0 green:191/255.f blue:242/255.f alpha:1];
    CGRect rect4 = [label4.text boundingRectWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:label4.font} context:nil];
    label4.frame = CGRectMake(20, 30+30+label2.frame.size.height+30, CGRectGetWidth(rect4), CGRectGetHeight(rect4));
    //label4.backgroundColor = [UIColor greenColor];
    [bgView addSubview:label4];
    
    bgView.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 60+40+label2.frame.size.height+label4.frame.size.height);
    
    return bgView;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeColor" object:nil];
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
