//
//  MeView.m
//  PhysicalTest
//
//  Created by jay on 2019/3/27.
//  Copyright © 2019 jay. All rights reserved.
//

#import "MeView.h"
#import "ToolObjc.h"
#import "AboutUsView.h"
#import "SingleObj.h"
#import <CoreLocation/CoreLocation.h>
#import "ChangeView.h"

@interface MeView ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager *locationManager;

@end

@implementation MeView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
    [self setData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColorNotificationMethod:) name:@"changeColor" object:nil];
}
- (void)changeColorNotificationMethod:(NSNotification *)noti{
    UIView *bgView = [self.view viewWithTag:1024];
    bgView.backgroundColor = [noti.userInfo objectForKey:@"color"];
}
- (void)configUI{
    _myTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.tableHeaderView = [self setTableViewHeader];
    [self.view addSubview:_myTableView];
}
- (void)setData{
    _someArr = @[@"关于我们",@"清理缓存",@"获取当前位置信息",@"换肤",@"退出登陆"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _someArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strCell = @"myCell";
    UITableViewCell *cell = [_myTableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [_someArr objectAtIndex:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UIView *)setTableViewHeader{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220)];
    //bgView.backgroundColor = [UIColor colorWithRed:0 green:191/255.f blue:242/255.f alpha:1];
    bgView.backgroundColor = [UIColor orangeColor];
    bgView.tag = 1024;
    UIButton *albumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    albumBtn.tag = 1001;
    albumBtn.backgroundColor = [UIColor greenColor];
    albumBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-150)/2, 20, 150, 150);
    albumBtn.layer.cornerRadius = 75;
    albumBtn.layer.masksToBounds = true;
    [albumBtn addTarget:self action:@selector(buttonClickAlbum) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/image"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        [albumBtn setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
    }else{
        [albumBtn setImage:[UIImage imageNamed:@"mine_portrait"] forState:UIControlStateNormal];
    }
    [bgView addSubview:albumBtn];
    
    UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 190, CGRectGetWidth([UIScreen mainScreen].bounds), 20)];
    stepLabel.textAlignment = NSTextAlignmentCenter;
    stepLabel.font = [UIFont systemFontOfSize:16];
    stepLabel.textColor = [UIColor whiteColor];
    stepLabel.text = [NSString stringWithFormat:@"今日步数：%.0f | 总公里数：%.2fkm",[SingleObj share].stepsNumber,[SingleObj share].distance/1000];
    [bgView addSubview:stepLabel];
    
    return bgView;
}
- (void)buttonClickAlbum{
    
    NSLog(@"album");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AboutUsView *vc = [[AboutUsView alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"当前缓存%.2fM,是否清理",[self readCacheSize]] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"ok");
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了取消");
        }];
        
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
    }else if (indexPath.row == 2){
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        //设置定位精度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager startUpdatingLocation];
    }else if (indexPath.row == 3){
        ChangeView *vc = [[ChangeView alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否退出登录" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [ToolObjc gotoLoginViewControlelr];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了取消");
        }];
        
        [alert addAction:action1];
        [alert addAction:action2];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations{
    CLLocation *newLocation = locations[0];
    //CLLocationCoordinate2D oCoordinate = newLocation.coordinate;
    [self.locationManager stopUpdatingLocation];
    
    //创建地理位置解码编辑器对象
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *place in placemarks) {
            //NSDictionary *location = [place addressDictionary];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"当前位于" message:[NSString stringWithFormat:@"%@,%@,%@",place.locality,place.subLocality,place.thoroughfare] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了取消");
            }];
            
            [alert addAction:action1];
            [alert addAction:action2];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //    获取本地沙盒路径
    //NSLog(@"%@",NSHomeDirectory());
    NSData *imageData = UIImageJPEGRepresentation(image, 0);
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/image"];
    //    存入本地
    [imageData writeToFile:path atomically:YES];
    UIButton *albumBtn = (UIButton *)[self.view viewWithTag:1001];
    [albumBtn setImage:image forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - clear cache
//沙盒目录下有三个文件夹Documents、Library（下面有Caches和Preferences目录）、tmp
- (float)readCacheSize{
    //获取library路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return [self folderSizeAtPath:cachePath];
}
- (float)folderSizeAtPath:(NSString *)folderPath{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}
- (long long)fileSizeAtPath:(NSString *)filePath{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
- (void)clearFile{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    for (NSString *p in files) {
        NSError *error = nil;
        NSString *fileAbsolutePath = [cachePath stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:fileAbsolutePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:fileAbsolutePath error:&error];
        }
    }
    float cacheSize = [self readCacheSize]*1024;
    NSLog(@"qing li -- %f",cacheSize);
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
