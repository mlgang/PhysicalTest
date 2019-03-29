//
//  ChangeView.m
//  PhysicalTest
//
//  Created by jay on 2019/3/28.
//  Copyright © 2019 jay. All rights reserved.
//

#import "ChangeView.h"

@interface ChangeView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,copy)NSArray *colorArr;
@property (nonatomic,copy)NSArray *colorWordArr;
@property (nonatomic,strong)NSMutableArray *checkArr;

@end

@implementation ChangeView

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self configUI];
    [self setData];
}
- (void)setData{
    _colorArr = @[[UIColor redColor],[UIColor orangeColor],[UIColor blackColor],[UIColor purpleColor]];
    _checkArr = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];
    _colorWordArr = @[@"玫瑰红",@"橘猫橙",@"深夜黑",@"水晶紫"];
}
- (void)configUI{
    _myTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"colorCell"];
    [self.view addSubview:_myTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _colorArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"colorCell"];
    cell.textLabel.text = [_colorWordArr objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [_colorArr objectAtIndex:indexPath.row];
    if ([[_checkArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[_checkArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
        for (int i = 0; i<_checkArr.count; i++) {
            [_checkArr replaceObjectAtIndex:i withObject:@"0"];
        }
        [_checkArr replaceObjectAtIndex:indexPath.row withObject:@"1"];
    }else{
        [_checkArr replaceObjectAtIndex:indexPath.row withObject:@"0"];
    }
    [tableView reloadData];
    UIColor *selectColor = [_colorArr objectAtIndex:indexPath.row];
    NSDictionary *infoDic= @{@"color":selectColor};
    NSNotification *noti = [NSNotification notificationWithName:@"changeColor" object:nil userInfo:infoDic];
    [[NSNotificationCenter defaultCenter] postNotification:noti];
    
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
