//
//  YLAddressBookModel.h
//  YLAddressBook
//
//  Created by YouLing on 2016/12/20.
//  Copyright © 2016年 YouLing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLAddressBookModel : NSObject
/*
 *这里指连接的plist的文件的名字，如果是网络的话，这里的数值是为了请求
 *下一级目录的标识
 */
@property(nonatomic,strong) NSString* connectionplist;
/*
 *如果cell的类型是成员的话，这里是人员的头像
 */
@property(nonatomic,strong) NSString* iconName;
/*
 * 要显示的cell的类型
 */
@property(nonatomic,strong) NSString* itemType;
/*
 *人员或者是部门的名称
 */
@property(nonatomic,strong) NSString* name;

+(instancetype) addressBookModelWithDict:(NSDictionary*) dict;

@end
