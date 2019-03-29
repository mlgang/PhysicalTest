//
//  PersonView.m
//  PhysicalTest
//
//  Created by jay on 2019/3/29.
//  Copyright © 2019 jay. All rights reserved.
//

#import "PersonView.h"

@interface PersonView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTable;
@property (nonatomic,copy)NSArray *nameArr;
@property (nonatomic,strong)NSMutableArray *contentArr;

@end

@implementation PersonView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self setData];
}
- (void)setData{
    _nameArr = @[@"姓名:",@"身高:",@"体重:",@"肺活量:",@"50米跑:",@"坐位体前屈:",@"立定跳远:",@"1000米跑:",@"引体向上:",@"总分:"];
    _contentArr = [NSMutableArray arrayWithObjects:self.name,self.height,self.weight,self.capacity,self.five,self.sitDown,self.standing,self.kilometers,self.chining,self.score, nil];
}
- (void)configUI{
    _myTable = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _myTable.delegate = self;
    _myTable.dataSource = self;
    [_myTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"personCell"];
    [self.view addSubview:_myTable];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _nameArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"personCell"];
    cell.textLabel.text = [_nameArr objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [_contentArr objectAtIndex:indexPath.row];
    return cell;
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
