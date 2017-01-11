//
//  YLUtility.h
//  YLAddressBook
//
//  Created by YouLing on 2016/12/21.
//  Copyright © 2016年 YouLing. All rights reserved.
//  用来写自己的公共类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen  mainScreen].bounds.size.height
@interface YLUtility : NSObject

/*
 *功能：根据名字的最后一个字来实现自动生成用户头像
 *userName   用户名
 */
+(UIImage*) createHeadImageWithUserName:(NSString*) userName;

+(UIImage *)addText:(UIImage *)img text:(NSString *)text1;
@end
