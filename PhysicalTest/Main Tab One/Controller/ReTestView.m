//
//  ReTestView.m
//  PhysicalTest
//
//  Created by jay on 2019/3/29.
//  Copyright © 2019 jay. All rights reserved.
//

#import "ReTestView.h"
#import "SubmitTableViewCell.h"
#import "NetworkTool.h"
#import <MBProgressHUD.h>

@interface ReTestView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTabView;
@property (nonatomic,copy)NSArray *titleArr;
@property (nonatomic,strong)NSMutableArray *contArr;

@end

@implementation ReTestView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self setData];
}
- (void)setData{
    //申请补考
    if ([self.whichString isEqualToString:@"1"]) {
        _titleArr = @[@"姓名：",@"学号：",@"所在班级：",@"班主任姓名：",@"补考科目",@"科目分数：",];
        _contArr = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"", nil];
    }else{//重考
        _titleArr = @[@"姓名：",@"学号：",@"所在班级：",@"班主任姓名：",@"重考科目",@"科目分数：",@"重考原因："];
        _contArr = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"", nil];
    }
    
}
- (void)configUI{
    _myTabView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _myTabView.delegate = self;
    _myTabView.dataSource = self;
    _myTabView.tableFooterView = [self getTableFooterView];
    [_myTabView registerClass:[SubmitTableViewCell class] forCellReuseIdentifier:@"testCell"];
    [self.view addSubview:_myTabView];
}
- (UIView *)getTableFooterView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    bgView.tag = 1022;
    //bgView.backgroundColor = [UIColor orangeColor];
    //补考
    UIButton *btnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnOne setTitle:@"提交" forState:UIControlStateNormal];
    [btnOne setTitleColor:[UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1] forState:UIControlStateNormal];
    btnOne.backgroundColor = [UIColor orangeColor];
    btnOne.layer.cornerRadius = 5;
    btnOne.layer.masksToBounds = YES;
    btnOne.frame = CGRectMake(10, 10, CGRectGetWidth([UIScreen mainScreen].bounds)-20, 40);
    [btnOne addTarget:self action:@selector(btnOneMethod) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btnOne];
    
    return bgView;
}
- (void)btnOneMethod{
    NSEnumerator *enumerator  = [_contArr objectEnumerator];
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
    if ([self.whichString isEqualToString:@"1"]) {//提交补考
        [NetworkTool getRetestWithArray:_contArr completionBlock:^(NSDictionary * _Nonnull dic) {
            if ([[dic objectForKey:@"status"] isEqualToString:@"success"]) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"提交成功";
                hud.removeFromSuperViewOnHide = YES;
                [hud hideAnimated:YES afterDelay:0.7];
            }else{
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"提交失败";
                hud.removeFromSuperViewOnHide = YES;
                [hud hideAnimated:YES afterDelay:0.7];
            }
        }];
    }else{//提交重考
        [NetworkTool getNewTestWithArray:_contArr completionBlock:^(NSDictionary * _Nonnull dic) {
            if ([[dic objectForKey:@"status"] isEqualToString:@"success"]) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"提交成功";
                hud.removeFromSuperViewOnHide = YES;
                [hud hideAnimated:YES afterDelay:0.7];
            }else{
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"提交失败";
                hud.removeFromSuperViewOnHide = YES;
                [hud hideAnimated:YES afterDelay:0.7];
            }
        }];
    }
}
#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SubmitTableViewCell *cell = [[SubmitTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"nofiCell"];
    cell.titleLab.text = [_titleArr objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.fillTextField.keyboardType = UIKeyboardTypeDefault;
    __weak typeof(self) weakSelf = self;
    if ([[[_contArr objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        cell.fillTextField.placeholder = [_titleArr objectAtIndex:indexPath.row];
    }else{
        cell.fillTextField.text = [_contArr objectAtIndex:indexPath.row];
    }
    cell.textBlock = ^(NSString * _Nonnull myText) {
        [weakSelf.contArr replaceObjectAtIndex:indexPath.row withObject:myText];
        [weakSelf.myTabView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"44");
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
