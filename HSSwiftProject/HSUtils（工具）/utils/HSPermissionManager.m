//
//  HSPermissionManager.m
//  JSEDU
//
//  Created by 金石 on 2018/7/3.
//  Copyright © 2018年 孔祥刚. All rights reserved.
//

#import "HSPermissionManager.h"
#import <CoreLocation/CoreLocation.h>           //定位
#import <AddressBook/AddressBook.h>             //通讯录
#import <Photos/Photos.h>                       //获取相册状态权限
#import <AVFoundation/AVFoundation.h>           //相机麦克风权限
#import <EventKit/EventKit.h>                   //日历\备提醒事项权限
#import <Contacts/Contacts.h>                   //通讯录权限
#import <SafariServices/SafariServices.h>
#import <Speech/Speech.h>                       //语音识别
//#import <HealthKit/HealthKit.h>                 //运动与健身
#import <MediaPlayer/MediaPlayer.h>             //媒体资料库
#import <UserNotifications/UserNotifications.h> //推送权限
#import <CoreBluetooth/CoreBluetooth.h>         //蓝牙权限
#import <Speech/Speech.h>                       //语音识别


static NSString *authorityStr =@"authority";


typedef NS_ENUM(NSInteger, JDAuthorizationStatus) {
    JDAuthorizationStatusNotDetermined = 0,
    JDAuthorizationStatusRestricted,
    JDAuthorizationStatusDenied,
    JDAuthorizationStatusAuthorized,
};

@interface HSPermissionManager ()
@property (nonatomic , strong) CLLocationManager *locationManager;
@end

@implementation HSPermissionManager


+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static HSPermissionManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [HSPermissionManager new];
    });
    return manager;
}

#pragma mark -- 一次性请求所有权限
- (void)requestAllAuthority{
    
    //只请求一次
    NSUserDefaults *defaut =[NSUserDefaults standardUserDefaults];
    NSString *authority = [defaut objectForKey:authorityStr];
    if (authority) return;
    [defaut setObject:authorityStr forKey:authorityStr];
    
    if (![self isObtainPhPhotoAuthority]) {
        [self obtainPHPhotoAuthorizedStaus];                //相册权限
    }

    if (![self isObtainAVVideoAuthority]) {
        
        [self obtainAVMediaVideoAuthorizedStatus];                    //相机
    }
    
    
    if (![self isObtainLocationAuthority]) {
        
        [self obtainCLLocationAlwaysAuthorizedStatus];      //定位权限
        [self obtainCLLocationWhenInUseAuthorizedStatus];
    }
}

#pragma mark - 定位

/**
 * @brief 是否开启定位权限
 */
- (BOOL)isObtainLocationAuthority{
    
    if ([self statusOfCurrentLocation] == kCLAuthorizationStatusAuthorizedWhenInUse |
        [self statusOfCurrentLocation] == kCLAuthorizationStatusAuthorizedAlways) {
        return YES;
    }else{
        return NO;
    }
}

- (CLAuthorizationStatus)statusOfCurrentLocation
{
    BOOL isLocation = [CLLocationManager locationServicesEnabled];
    if (!isLocation) {
        NSLog(@"定位权限:未起开定位开关(not turn on the location)");
    }
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"定位权限:同意一直使用(Always Authorized)");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"定位权限:使用期间同意使用(AuthorizedWhenInUse)");
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"定位权限:拒绝(Denied)");
            break;
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"定位权限:未进行授权选择(not Determined)");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"定位权限:未授权(Restricted)");
            break;
        default:
            break;
    }
    return status;
}


//始终访问位置信息
- (void)obtainCLLocationAlwaysAuthorizedStatus{
    
    [self.locationManager requestAlwaysAuthorization];
    
}

//使用时访问位置信息
- (void)obtainCLLocationWhenInUseAuthorizedStatus{
    
    [self.locationManager requestWhenInUseAuthorization];
}



#pragma mark -- 获取当前定位












#pragma mark - 推送

-(void) checkCurrentNotificationStatus
{
    if (@available(iOS 10 , *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            
            if (settings.authorizationStatus == UNAuthorizationStatusDenied)
            {
                // 没权限
            }
            
        }];
    } else if (@available(iOS 8 , *)) {
        
        UIUserNotificationSettings * setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        
        if (setting.types == UIUserNotificationTypeNone) {
            // 没权限
        }
    }
}

- (void)obtainUserNotificationAuthorizedStatus{
    
    if (@available(iOS 10.0, *)) {

        UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert - UNAuthorizationOptionSound)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  
                                  [self ShowGranted:granted];
                                  
                              }];
    } else if (@available(iOS 8 , *)) {
        UIApplication * application = [UIApplication sharedApplication];
        
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil]];
        [application registerForRemoteNotifications];
        
    }
    
    
}


#pragma mark - 日历权限
/**
 * @brief 是否开启日历权限
 */
- (BOOL)isObtainEKEventAuthority{
    
    EKAuthorizationStatus status = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
    return [self isObtainWithStatus:status];
}

//开启日历权限
- (void)obtainEKEventAuthorizedStatus{
    
    EKEventStore *store = [[EKEventStore alloc]init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        
        [self ShowGranted:granted];
        
    }];
    
}

#pragma mark - 相册权限
/**
 * @brief 是否开启相册权限
 */
- (BOOL)isObtainPhPhotoAuthority{
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    return [self isObtainWithStatus:status];
    
}
//开启相册权限
- (void)obtainPHPhotoAuthorizedStaus{
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == 3) {
            NSLog(@"相册开启权限:获取");
        }else{
            NSLog(@"相册开启权限:暂无");
        }
    }];
    
}

#pragma mark - 相机权限
/**
 * @brief 是否开启相机权限
 */
- (BOOL)isObtainAVVideoAuthority{
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    return [self isObtainWithStatus:status];
    
}

- (void)obtainAVMediaVideoAuthorizedStatus{
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        
        [self ShowGranted:granted];
        
    }];
    
}

#pragma mark - 提醒事项权限
/**
 * @brief 是否开启提醒事项权限
 */
- (BOOL)isObtainReminder{
    
    EKAuthorizationStatus status = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
    return [self isObtainWithStatus:status];
}

- (void)obtainEKReminderAuthorizedStatus{
    
    EKEventStore *store = [[EKEventStore alloc]init];
    
    [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
        
        [self ShowGranted:granted];
        
    }];
}




#pragma mark - 运动与健身
/**
 * @brief 开启运动与健身权限(需要的运动权限自己再加,目前仅有"步数"、"步行-跑步距离"、"心率")
 */
//- (void)obtainHKHealthAuthorizedStatus{
//
//    HKHealthStore *health =[[HKHealthStore alloc]init];
//    
//    NSSet *readObjectTypes =[NSSet setWithObjects:
//                             [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],//Cumulative
//                             [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning],   //跑步
//                             [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex],    //体重
//                             [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate],    //心率
//                             nil];
//
//    [health requestAuthorizationToShareTypes:nil readTypes:readObjectTypes completion:^(BOOL success, NSError * _Nullable error) {
//
//        [self ShowGranted:success];
//
//    }];
//
//}

#pragma mark - 是否授权状态判断
- (BOOL)isObtainWithStatus:(NSInteger)status{
    
    if (status == JDAuthorizationStatusDenied) {
        NSLog(@"用户拒绝App使用(Denied)");
        return NO;
    }else if (status ==JDAuthorizationStatusNotDetermined){
        NSLog(@"未选择权限(NotDetermined)");
        return NO;
    }else if (status == JDAuthorizationStatusRestricted){
        NSLog(@"未授权(Restricted)");
        return NO;
    }
    NSLog(@"权限:已授权(Authorized)"); //EKAuthorizationStatusAuthorized
    return YES;
}

- (void)ShowGranted:(BOOL)success
{
    if (success == YES) {
        NSLog(@"开启权限:成功");
    }else{
        NSLog(@"开启权限:失败");
    }
}


- (NSString *)getNoPermissionCodeWithType:(NoPermissionError)type  {
//    PHERROR,            //相册
//    CLERROR,            //定位
//    UNERROR,            //推送
//    AVERROR,            //相机
    switch (type) {
        case PHERROR:
            return @"没有相册权限😓";
            break;
            
            case CLERROR:
            return @"没有定位权限😓";
            break;
            
            case UNERROR:
            return @"没有推送权限😓";
            break;
            
            case AVERROR:
            return @"没有相机权限😓";
            break;
        default:
            return @"没有权限😓";
            break;
    }
}



#pragma mark - lazy load

- (CLLocationManager *)locationManager {
    
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

@end
