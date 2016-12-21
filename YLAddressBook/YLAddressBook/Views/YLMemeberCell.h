//
//  YLMemeberCell.h
//  YLAddressBook
//
//  Created by YouLing on 2016/12/20.
//  Copyright © 2016年 YouLing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLAddressBookModel.h"
@interface YLMemeberCell : UITableViewCell

@property(nonatomic,strong) YLAddressBookModel* dataModel;

+(instancetype) cellWithTableView:(UITableView*) tableView;
@end
