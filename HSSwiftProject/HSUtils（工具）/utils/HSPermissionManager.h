//
//  HSPermissionManager.h
//  JSEDU
//
//  Created by 金石 on 2018/7/3.
//  Copyright © 2018年 孔祥刚. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PHERROR,            //相册
    CLERROR,            //定位
    UNERROR,            //推送
    AVERROR,            //相机
} NoPermissionError;


/**
 权限管理类
 */
@interface HSPermissionManager : NSObject


+ (instancetype)sharedManager;

/**
 一次性请求 APP 所有需要的权限
 */
- (void)requestAllAuthority;


#pragma mark - 定位

/**
 * @brief 是否开启定位权限
 */
- (BOOL)isObtainLocationAuthority;
- (void)obtainCLLocationAlwaysAuthorizedStatus; //始终访问位置信息
- (void)obtainCLLocationWhenInUseAuthorizedStatus; //使用时访问位置信息

#pragma mark - 推送

- (void)obtainUserNotificationAuthorizedStatus;


#pragma mark - 日历权限
/**
 * @brief 是否开启日历权限
 */
- (BOOL)isObtainEKEventAuthority;
- (void)obtainEKEventAuthorizedStatus; //开启日历权限

#pragma mark - 相册权限
/**
 * @brief 是否开启相册权限
 */
- (BOOL)isObtainPhPhotoAuthority;
- (void)obtainPHPhotoAuthorizedStaus; //开启相册权限

#pragma mark - 相机权限
/**
 * @brief 是否开启相机权限
 */
- (BOOL)isObtainAVVideoAuthority;
- (void)obtainAVMediaVideoAuthorizedStatus;



#pragma mark - 提醒事项权限
/**
 * @brief 是否开启提醒事项权限
 */
- (BOOL)isObtainReminder;
- (void)obtainEKReminderAuthorizedStatus;

#pragma mark - 运动与健身
/**
 * @brief 开启运动与健身权限(需要的运动权限自己再加,目前仅有"步数"、"步行-跑步距离"、"心率")
 */
//- (void)obtainHKHealthAuthorizedStatus;



#pragma mark - 获取没有权限的错误提示
/**
 type 权限类型
 */
- (NSString *)getNoPermissionCodeWithType:(NoPermissionError)type;
@end
