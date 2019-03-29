//
//  NotificationController.m
//  PhysicalTest
//
//  Created by jay on 2019/3/29.
//  Copyright © 2019 jay. All rights reserved.
//

#import "NotificationController.h"

@interface NotificationController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTabView;

@end

@implementation NotificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
   // NSString *title = [[[self.arr objectAtIndex:0] objectForKey:@"content"] stringByRemovingPercentEncoding];
}
- (void)configUI{
    _myTabView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _myTabView.delegate = self;
    _myTabView.dataSource = self;
    [_myTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"nofiCell"];
    [self.view addSubview:_myTabView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"nofiCell"];
    cell.textLabel.text = [[[self.arr objectAtIndex:indexPath.row] objectForKey:@"title"] stringByRemovingPercentEncoding];
    cell.detailTextLabel.text =[[[self.arr objectAtIndex:indexPath.row] objectForKey:@"time"] stringByRemovingPercentEncoding];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"通知" message:[[[self.arr objectAtIndex:indexPath.row] objectForKey:@"content"] stringByRemovingPercentEncoding] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    
    [alert addAction:action1];
    [alert addAction:action2];
    
    [self presentViewController:alert animated:YES completion:nil];
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
