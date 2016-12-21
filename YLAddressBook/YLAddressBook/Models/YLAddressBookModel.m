//
//  YLAddressBookModel.m
//  YLAddressBook
//
//  Created by YouLing on 2016/12/20.
//  Copyright © 2016年 YouLing. All rights reserved.
//

#import "YLAddressBookModel.h"

@implementation YLAddressBookModel
/*
 *处理下key没有定义的情况
 */
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key  isEqual: @"icon"]) {
        [self setValue:value forKey:@"iconName"];
    }
    
}

+(instancetype) addressBookModelWithDict:(NSDictionary*) dict
{
    YLAddressBookModel* addressBookModel = [[YLAddressBookModel alloc] init];
    [addressBookModel setValuesForKeysWithDictionary:dict];
    return addressBookModel;
}
@end
