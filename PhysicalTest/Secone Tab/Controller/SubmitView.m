//
//  SubmitView.m
//  PhysicalTest
//
//  Created by jay on 2019/3/27.
//  Copyright © 2019 jay. All rights reserved.
//

#import "SubmitView.h"
#import "SubmitTableViewCell.h"
#import "NetworkTool.h"
#import <MBProgressHUD.h>

@interface SubmitView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,copy)NSArray *nameArr;
@property (nonatomic,strong)NSMutableArray *infoArr;
@property (nonatomic,assign)BOOL isCeping;

@end

@implementation SubmitView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createSegMentController];
    [self configUI];
    [self setData];
}
//创建导航栏分栏控件
-(void)createSegMentController{
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"在线测评",@"体质评估",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(0, 0, 180, 30);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor orangeColor];
    [segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    [self.navigationItem setTitleView:segmentedControl];
}
-(void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender{
    NSInteger selecIndex = sender.selectedSegmentIndex;
    switch(selecIndex){
        case 0:
            {
                _nameArr = @[@"身高：",@"体重：",@"肺活量：",@"50米跑：",@"坐位体前屈：",@"立定跳远：",@"引体向上：",@"1000米跑："];
                _infoArr = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
                _isCeping = NO;
                [_myTableView reloadData];
                
            }
            break;
            
        case 1:
            {
                _nameArr = @[@"您的身高：",@"您的体重：",@"上楼梯时的状态：\n1-10分",@"一次俯卧撑次数：",@"一次标准卷腹次数：",@"深蹲次数：",@"坐位体前屈成绩：",@"1000米跑成绩："];
                _infoArr = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
                _isCeping = YES;
                [_myTableView reloadData];
            }
            break;
            
        default:
            break;
    }
}
- (void)setData{
    _nameArr = @[@"身高：",@"体重：",@"肺活量：",@"50米跑：",@"坐位体前屈：",@"立定跳远：",@"引体向上：",@"1000米跑："];
    _infoArr = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
    _isCeping = NO;
}
- (void)configUI{
    _myTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.tableFooterView = [self getTableFooter];
    [_myTableView registerClass:[SubmitTableViewCell class] forCellReuseIdentifier:@"subCell"];
    [self.view addSubview:_myTableView];
}
- (UIView *)getTableFooter{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor orangeColor];
    btn.frame = CGRectMake(10, 5, CGRectGetWidth([UIScreen mainScreen].bounds)-20, 40);
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    
    
    return bgView;
}
- (void)btnClick{
    NSEnumerator *enumerator  = [_infoArr objectEnumerator];
    NSString *str;
    while (str = [enumerator nextObject]) {
        if (str.length <= 0) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"请填写完整";
            hud.removeFromSuperViewOnHide = YES;
            [hud hideAnimated:YES afterDelay:0.7];
            return;
        }
    }
    if (!_isCeping) {
        self.scorLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        [NetworkTool updateMyinfoWithArray:_infoArr completionBlock:^(NSDictionary * _Nonnull dic) {
            NSLog(@"%@",dic);
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"提交成功";
            hud.removeFromSuperViewOnHide = YES;
            [hud hideAnimated:YES afterDelay:0.7];
            
            self.scorLab.text = [NSString stringWithFormat:@"测评得分：%@",[dic objectForKey:@"score"]];
            self.scorLab.font = [UIFont boldSystemFontOfSize:40];
            self.scorLab.textAlignment = NSTextAlignmentCenter;
            self.myTableView.tableHeaderView = self.scorLab;
        }];
    }else{
        [NetworkTool getHealthTestResultWithArray:_infoArr completionBlock:^(NSDictionary * _Nonnull dic) {
            if ([[dic objectForKey:@"status"] isEqualToString:@"success"]) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"评估结果" message:[[dic objectForKey:@"commet"] stringByRemovingPercentEncoding] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alert addAction:action1];
                [alert addAction:action2];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
    
}
#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _nameArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SubmitTableViewCell *cell = [[SubmitTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"subCell"];
    cell.titleLab.text = [_nameArr objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!_isCeping) {
        cell.fillTextField.keyboardType = UIKeyboardTypePhonePad;
    }else{
        cell.fillTextField.keyboardType = UIKeyboardTypeDefault;
    }
    __weak typeof(self) weakSelf = self;
    if ([[[_infoArr objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        cell.fillTextField.placeholder = [_nameArr objectAtIndex:indexPath.row];
    }else{
        cell.fillTextField.text = [_infoArr objectAtIndex:indexPath.row];
    }
    cell.textBlock = ^(NSString * _Nonnull myText) {
        [weakSelf.infoArr replaceObjectAtIndex:indexPath.row withObject:myText];
        [weakSelf.myTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
