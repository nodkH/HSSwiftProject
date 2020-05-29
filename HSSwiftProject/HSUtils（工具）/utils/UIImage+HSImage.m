//
//  UIImage+HSImage.m
//  ImageTest
//
//  Created by 孔祥刚 on 2019/8/1.
//  Copyright © 2019 孔祥刚. All rights reserved.
//

#import "UIImage+HSImage.h"

@implementation UIImage (HSImage)

- (UIImage *)hs_circleImageBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    
    if (!self) {
        return [UIImage new];
    }
    CGSize size = self.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGContextSetLineWidth(context, borderWidth);
    
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextClip(context);
    
    [self drawInRect:rect];
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextStrokePath(context);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



- (UIImage *)hs_circleImageRectCorner:(UIRectCorner)rectCorner cornerRadius:(CGFloat)cornerRadius {
    
    if (!self) {
        return [UIImage new];
    }
    CGSize size = self.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    //获取图片上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:rectCorner cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    
    CGContextAddPath(context, [path CGPath]);
    
    //剪切超出范围
    CGContextClip(context);
    [self drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



- (UIImage *)hs_addTitle:(NSString *)title attributeDic:(nullable NSDictionary *)attributeDic point:(CGPoint)point {
    if (!self) {
        return [UIImage new];
    }
    CGSize size = self.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGRect imageRect = CGRectMake(0, 0, size.width, size.height);
    [self drawInRect:imageRect];
    [title drawAtPoint:point withAttributes:attributeDic];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)hs_wipeImageWithView:(UIView *)view movePoint:(CGPoint)point brushSize:(CGSize)size {
    //开启上下文
    UIGraphicsBeginImageContext(view.bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //此方法不能渲染图片 只针对layer
    //[view.layer drawInContext:context];
    
    //以point为中心，然后size的一半向两边延伸  坐画笔  橡皮擦
    CGRect clearRect = CGRectMake(point.x - size.width/2.0, point.y - size.width/2.0, size.width, size.height);
    
    //渲染图片
    [view.layer renderInContext:context];
    //清除该区域
    CGContextClearRect(context, clearRect);
    //得到新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    //避免内存泄漏
    view.layer.contents = nil;
    
    return newImage;
}
@end
