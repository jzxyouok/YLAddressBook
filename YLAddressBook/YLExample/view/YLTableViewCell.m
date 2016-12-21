//
//  YLTableViewCell.m
//  YLAddressBook
//
//  Created by YouLing on 2016/12/20.
//  Copyright © 2016年 YouLing. All rights reserved.
//

#import "YLTableViewCell.h"



@interface YLTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *separatorLabel;
@end

@implementation YLTableViewCell

+(instancetype) cellWithTableView:(UITableView*) tableView
{
    NSString* className = NSStringFromClass([self class]);
    UINib* nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    return  [tableView dequeueReusableCellWithIdentifier:className];
}


@end
