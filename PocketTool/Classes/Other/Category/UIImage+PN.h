//
//  UIImage+PN.h
//  ZoushowPad
//
//  Created by Mac on 14-12-18.
//  Copyright (c) 2014年 Zoushow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (PN)
/**
 *  加载图片
 *
 *  @param name 图片名
 */
+ (UIImage *)imageWithName:(NSString *)name;
/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
@end
