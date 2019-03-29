//
//  RankView.m
//  PhysicalTest
//
//  Created by jay on 2019/3/29.
//  Copyright © 2019 jay. All rights reserved.
//

#import "RankView.h"
#import "PersonView.h"

@interface RankView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTable;

@end

@implementation RankView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}
- (void)configUI{
    _myTable = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _myTable.delegate = self;
    _myTable.dataSource = self;
    [_myTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"rankCell"];
    [self.view addSubview:_myTable];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"rankCell"];
    cell.textLabel.text = [[[self.arr objectAtIndex:indexPath.row] objectForKey:@"name"] stringByRemovingPercentEncoding];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"总得分：%@",[[self.arr objectAtIndex:indexPath.row] objectForKey:@"score"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonView *vc = [[PersonView alloc] init];
    vc.name = [[self.arr objectAtIndex:indexPath.row] objectForKey:@"name"];
    vc.height = [[self.arr objectAtIndex:indexPath.row] objectForKey:@"stature"];
    vc.weight = [[self.arr objectAtIndex:indexPath.row] objectForKey:@"weight"];
    vc.capacity = [[self.arr objectAtIndex:indexPath.row] objectForKey:@"vital_capacity"];
    vc.five = [[self.arr objectAtIndex:indexPath.row] objectForKey:@"50_meters"];
    vc.sitDown = [[self.arr objectAtIndex:indexPath.row] objectForKey:@"sit_and_reach"];
    vc.standing = [[self.arr objectAtIndex:indexPath.row] objectForKey:@"standing_long_jump"];
    vc.kilometers = [[self.arr objectAtIndex:indexPath.row] objectForKey:@"1000_meters"];
    vc.chining = [[self.arr objectAtIndex:indexPath.row] objectForKey:@"chinning"];
    vc.score = [[self.arr objectAtIndex:indexPath.row] objectForKey:@"score"];
    [self.navigationController pushViewController:vc animated:YES];
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
