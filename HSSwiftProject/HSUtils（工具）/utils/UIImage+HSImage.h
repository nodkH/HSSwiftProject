//
//  UIImage+HSImage.h
//  ImageTest
//
//  Created by 孔祥刚 on 2019/8/1.
//  Copyright © 2019 孔祥刚. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (HSImage)
/// 圆形图片加边框
- (UIImage *)hs_circleImageBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/// 图片圆角
- (UIImage *)hs_circleImageRectCorner:(UIRectCorner)rectCorner cornerRadius:(CGFloat)cornerRadius;

/// 给图片加文字水印R
- (UIImage *)hs_addTitle:(NSString *)title attributeDic:(nullable NSDictionary *)attributeDic point:(CGPoint)point;

/// 图片清除
+ (UIImage *)hs_wipeImageWithView:(UIView *)view movePoint:(CGPoint)point brushSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
