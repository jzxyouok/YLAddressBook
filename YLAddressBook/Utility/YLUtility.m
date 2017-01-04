//
//  YLUtility.m
//  YLAddressBook
//
//  Created by YouLing on 2016/12/21.
//  Copyright © 2016年 YouLing. All rights reserved.
//

#import "YLUtility.h"
//#import <CoreGraphics/CoreGraphics.h>
@implementation YLUtility

+(UIImage*) createHeadImageWithUserName:(NSString*) userName
{
    
    //NSString* headImageStr = [userName substringFromIndex:userName.length-2];
    
    //UIImage* image = [UIImage ]
    UIImage *newimage;
    //准备开始画图
    UIGraphicsBeginImageContext(CGSizeMake(100, 100));
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置填充的颜色
    CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
    //
    UIRectFill(CGRectMake(0, 0, 100, 100));//clear background
    
    
    newimage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    
    UIGraphicsEndImageContext();
    
    return [YLUtility addText:newimage text:@"云"];
}
+(UIImage *)addText:(UIImage *)img text:(NSString *)text1
{
    //上下文的大小
    int w = img.size.width;
    int h = img.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();//创建颜色
    //创建上下文
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 44 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);//将img绘至context上下文中
    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);//设置颜色
    //char* text = (char *)[text1 cStringUsingEncoding:NSASCIIStringEncoding];
    //CGContextSelectFont(context, "Georgia", 30, kCGEncodingMacRoman);//设置字体的大小
    CGContextSetTextDrawingMode(context, kCGTextFill);//设置字体绘制方式
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);//设置字体绘制的颜色
    //CGContextShowTextAtPoint(context, w/2-strlen(text)*5, h/2, text, strlen(text));//设置字体绘制的位置
    //Create image ref from the context
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);//创建CGImage
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];//获得添加水印后的图片   
}
@end
