//
//  YLDepartmentCell.m
//  YLAddressBook
//
//  Created by YouLing on 2016/12/20.
//  Copyright © 2016年 YouLing. All rights reserved.
//

#import "YLDepartmentCell.h"

@interface YLDepartmentCell()
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *labelName;

@end


@implementation YLDepartmentCell


-(void) setDataModel:(YLAddressBookModel *)dataModel
{
    self.labelName.text = dataModel.name;
}
+(instancetype) cellWithTableView:(UITableView*) tableView
{
    NSString* className = NSStringFromClass([self class]);
    
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:className];
    
    return [tableView dequeueReusableCellWithIdentifier:className];
}
@end
