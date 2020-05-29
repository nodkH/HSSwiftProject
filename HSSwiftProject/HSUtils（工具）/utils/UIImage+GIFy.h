//
//  UIImage+GIF.h
//  ewrtyu
//
//  Created by MAC on 2018/2/24.
//  Copyright © 2018年 ShanxiXiaohuoban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GIFy)
typedef void (^GIFimageBlock)(UIImage *GIFImage);
    
    /** 根据本地GIF图片名 获得GIF image对象 */
    
+ (UIImage *)imageWithGIFNamed:(NSString *)name;
    
    /** 根据一个GIF图片的data数据 获得GIF image对象 */
    
+ (UIImage *)imageWithGIFData:(NSData *)data;
    
    /** 根据一个GIF图片的URL 获得GIF image对象 */
    
+ (void)imageWithGIFUrl:(NSString *)url and:(GIFimageBlock)gifImageBlock;
@end
