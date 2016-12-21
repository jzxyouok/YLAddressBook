//
//  YLAddressBookViewController.h
//  YLAddressBook
//
//  Created by YouLing on 2016/12/20.
//  Copyright © 2016年 YouLing. All rights reserved.
//

#import <UIKit/UIKit.h>
//使用代理来完成
//
@class  YLAddressBookViewController;

@protocol YLAddressBookViewControllerDelegate <NSObject>

-(NSArray*) YLAddressBookViewController:(YLAddressBookViewController*) viewcontroller getNextListDataWithConnect:(NSString*) connectPlist;

@end

@interface YLAddressBookViewController : UIViewController


@end
