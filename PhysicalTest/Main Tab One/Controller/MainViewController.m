//
//  MainViewController.m
//  PhysicalTest
//
//  Created by jay on 2019/3/27.
//  Copyright © 2019 jay. All rights reserved.
//

#import "MainViewController.h"
#import "DetailView.h"
#import "NotificationController.h"
#import "ReTestView.h"
#import "RankView.h"
#import "NetworkTool.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
    [self setData];
    UIButton *notiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [notiBtn setTitle:@"通知" forState:UIControlStateNormal];
    [notiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [notiBtn addTarget:self action:@selector(btnClickMethod) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:notiBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColorNotificationMethod:) name:@"changeColor" object:nil];
}
- (void)btnClickMethod{
    [NetworkTool getNotificationCompletionBlock:^(NSDictionary * _Nonnull dic) {
        if ([[dic objectForKey:@"status"] isEqualToString:@"success"]) {
            NSArray *arrNo = [dic objectForKey:@"notification"];
            NotificationController *vc = [[NotificationController alloc] init];
            vc.arr = arrNo;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    
}
- (void)changeColorNotificationMethod:(NSNotification *)noti{
    UIView *bgView = [self.view viewWithTag:1022];
    UILabel *headLabel = [self.view viewWithTag:1023];
    bgView.backgroundColor = [noti.userInfo objectForKey:@"color"];
    headLabel.textColor = [noti.userInfo objectForKey:@"color"];
}
- (void)configUI{
    _myTable = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _myTable.delegate = self;
    _myTable.dataSource = self;
    _myTable.tableHeaderView = [self getMyTableHeaderView];
    _myTable.tableFooterView = [self getTableFooterView];
    [_myTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"oneCell"];
    [self.view addSubview:_myTable];
}
- (UIView *)getMyTableHeaderView{

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 230)];
    bgView.tag = 1022;
    bgView.backgroundColor = [UIColor orangeColor];
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 230)];
    [bgImageView setImage:[UIImage imageNamed:@"bgImage"]];
    [bgView addSubview:bgImageView];
    
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.bounds)-150)/2, 20, 150, 150)];
    headLabel.backgroundColor = [UIColor whiteColor];
    headLabel.layer.cornerRadius = 75;
    headLabel.layer.masksToBounds = YES;
    headLabel.font = [UIFont boldSystemFontOfSize:40];
    headLabel.textColor = [UIColor orangeColor];
    headLabel.tag = 1023;
    headLabel.numberOfLines = 0;
    headLabel.text = [NSString stringWithFormat:@"%@分",self.user.score];
    headLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:headLabel];
    
    UIButton *rankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rankBtn setTitle:@"查看班级排名" forState:UIControlStateNormal];
    [rankBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    rankBtn.frame = CGRectMake((CGRectGetWidth(self.view.bounds)-150)/2, 180, 150, 30);
    rankBtn.backgroundColor = [UIColor whiteColor];
    rankBtn.layer.cornerRadius = 5;
    rankBtn.layer.masksToBounds = YES;
    [rankBtn addTarget:self action:@selector(rankBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:rankBtn];
    return bgView;
}
- (UIView *)getTableFooterView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120)];
    bgView.tag = 1022;
    //bgView.backgroundColor = [UIColor orangeColor];
    //补考
    UIButton *btnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnOne setTitle:@"申请补考" forState:UIControlStateNormal];
    [btnOne setTitleColor:[UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1] forState:UIControlStateNormal];
    btnOne.backgroundColor = [UIColor orangeColor];
    btnOne.layer.cornerRadius = 5;
    btnOne.layer.masksToBounds = YES;
    btnOne.frame = CGRectMake(10, 10, CGRectGetWidth([UIScreen mainScreen].bounds)-20, 40);
    [btnOne addTarget:self action:@selector(btnOneMethod) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btnOne];
    //重考
    UIButton *btnTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnTwo setTitle:@"申请重新考试" forState:UIControlStateNormal];
    [btnTwo setTitleColor:[UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1] forState:UIControlStateNormal];
    btnTwo.backgroundColor = [UIColor orangeColor];
    btnTwo.layer.cornerRadius = 5;
    btnTwo.layer.masksToBounds = YES;
    btnTwo.frame = CGRectMake(10, 60, CGRectGetWidth([UIScreen mainScreen].bounds)-20, 40);
    [btnTwo addTarget:self action:@selector(btnTwoMethod) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btnTwo];
    
    return bgView;
}
#pragma mark - btn
- (void)rankBtnClick{
    [NetworkTool getRankcompletionBlock:^(NSDictionary * _Nonnull dic) {
        if ([[dic objectForKey:@"status"] isEqualToString:@"success"]) {
            RankView *vc = [[RankView alloc] init];
            vc.arr = [dic objectForKey:@"rank"];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    
}
- (void)btnOneMethod{
    ReTestView *vc = [[ReTestView alloc] init];
    vc.whichString = @"1";
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)btnTwoMethod{
    ReTestView *vc = [[ReTestView alloc] init];
    vc.whichString = @"2";
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"oneCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [_titArr objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [_scoreArr objectAtIndex:indexPath.row];
    if (indexPath.row >1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailView *vc = [[DetailView alloc] init];
    if (indexPath.row > 1) {
        switch (indexPath.row) {
            case 2:
            {
                vc.explainStr = @"BMI指数，用体重公斤数除以身高米数平方得出的数字，是目前国际上常用的衡量人体胖瘦程度以及是否健康的一个标准。";
                vc.stantardStr = @"体质指数（BMI）=体重（kg）➗身高⌃2（m）";
            }
                break;
            case 3:
            {
                vc.explainStr = @"指在不限时间的情况下，一次最大吸气后再尽最大能力所呼出的气体量，这代表肺一次最大的机能活动量，是反映人体生长发育水平的重要机能指标之一。";
                vc.stantardStr = @"受试者呈自然站立位，手握文式管手柄，使导压软管在文式管上方，头部略向后仰，尽力深吸气直到不能吸气为止；然后，将嘴对准口嘴缓慢地呼气，直到不能呼气为止。此时，显示屏上显示的数值即为肺活量值。测试2次，测试人员记录最大值，以毫升为单位，不保留小数。2次测试间隔时间不超过15秒。";
            }
                break;
            case 4:
            {
                vc.explainStr = @"是一个能体现快速跑能力和反应能力的体育项目。";
                vc.stantardStr = @"测试前，应在平坦地面上画长50米、宽1.22米的直线跑道若干条，跑道线要清晰。设一端为起点线，另一端为终点线。受试者至少2人一组，站立式起跑；当听到起跑信号后，立即起跑，全力跑向终点线。";
            }
                break;
            case 5:
            {
                vc.explainStr = @"是大中小学体质健康测试项目，测试目的是测量在静止状态下的躯干、腰、髋等关节可能达到的活动幅度，主要反映这些部位的关节、韧带和肌肉的伸展性和弹性及身体柔韧素质的发展水平。";
                vc.stantardStr = @"受试者面向仪器，坐在软垫上，两腿向前伸直；两足跟并拢，蹬在测试仪的挡板上，脚尖自然分开约10—15厘米。测试时，受试者双手并拢，掌心向下平伸，膝关节伸直，身体前屈，用双手中指指尖匀速推动游标平滑前行，直到不能推动为止。受试者共测试2次，测试人员记录最大值，以厘米为单位，精确到小数点后1位。使用电子测试仪时，受试者按照要求推动游标，显示屏显示测试数值。";
            }
                break;
            case 6:
            {
                vc.explainStr = @"不用助跑从立定姿势开始的跳远，反映人体下肢爆发力水平。";
                vc.stantardStr = @"受试者两脚自然分开，站在起跳线后，双脚原地同时起跳。丈量起跳线后缘至最近着地点后缘之间的垂直距离。测试3次，记录最好成绩。以厘米为单位，保留1位小数。";
            }
                break;
            case 7:
            {
                vc.explainStr = @"主要测试上肢肌肉力量的发展水平，为男性上肢力量的考查项目，是自身力量克服自身重力的悬垂力量练习。是最基本的锻炼背部的方法，也是衡量男性体质的重要参考标准和项目之一。";
                vc.stantardStr = @"受试者面向单杠，自然站立；然后跃起正手握杠，双手分开与肩同宽，身体呈直臂悬垂姿势。待身体停止晃动后，两臂同时用力，向上引体；引体时，身体不得有任何附加动作。当下颌超过横杠上缘时，还原，呈直臂悬垂姿势，为完成1次。测试人员记录受试者完成的次数。以次为单位。";
            }
                break;
            case 8:
            {
                vc.explainStr = @"长时间的连续肌肉活动，主要反映人体耐力水平。";
                vc.stantardStr = @"受试者至少2人一组，站立式起跑。当听到起跑信号后，立即起跑，全力跑向终点线。发令员站在起点线的侧面，在发出起跑信号的同时，挥动发令旗。计时员位于终点线的侧面，视发令旗挥动的同时，开表计时；当受试者跑完全程，胸部到达终点线的垂直面时停表。记录以秒为单位，保留小数点后1位。小数点后第2位数按非“0”进“1”的原则进位。";
            }
                break;
                
            default:
                break;
        }
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeColor" object:nil];
}
- (void)setData{
    _titArr = @[@"身高：",@"体重：",@"BMI：",@"肺活量：",@"50米跑：",@"坐位体前屈：",@"立定跳远：",@"引体向上：",@"1000米跑："];
    _scoreArr = [NSMutableArray arrayWithCapacity:8];
    if (self.user.height == nil) {
        _scoreArr[0] = @"暂无";
    }else{
        _scoreArr[0] = self.user.height;
    }
    if (self.user.weight == nil) {
        _scoreArr[1] = @"暂无";
    }else{
        _scoreArr[1] = self.user.weight;
    }
    if (@"23" == nil) {
        _scoreArr[2] = @"暂无";
    }else{
        _scoreArr[2] = @"23";
    }
    if (self.user.chining == nil) {
        _scoreArr[3] = @"暂无";
    }else{
        _scoreArr[3] = self.user.chining;
    }
    if (self.user.fiveMeters == nil) {
        _scoreArr[4] = @"暂无";
    }else{
        _scoreArr[4] = self.user.fiveMeters;
    }
    if (self.user.sitAndDown == nil) {
        _scoreArr[5] = @"暂无";
    }else{
        _scoreArr[5] = self.user.sitAndDown;
    }
    if (self.user.jump == nil) {
        _scoreArr[6] = @"暂无";
    }else{
        _scoreArr[6] = self.user.jump;
    }
    if (self.user.capacity == nil) {
        _scoreArr[7] = @"暂无";
    }else{
        _scoreArr[7] = self.user.capacity;
    }
    if (self.user.kilometer == nil) {
        _scoreArr[8] = @"暂无";
    }else{
        _scoreArr[8] = self.user.kilometer;
    }
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
