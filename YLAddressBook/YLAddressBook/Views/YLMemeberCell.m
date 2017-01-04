//
//  YLMemeberCell.m
//  YLAddressBook
//
//  Created by YouLing on 2016/12/20.
//  Copyright © 2016年 YouLing. All rights reserved.
//

#import "YLMemeberCell.h"

@interface YLMemeberCell()
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation YLMemeberCell

-(void) setDataModel:(YLAddressBookModel *)dataModel
{
    self.nameLabel.text = dataModel.name;
    //self.cellImageView.image = [YLUtility createHeadImageWithUserName:@""];
}
+(instancetype) cellWithTableView:(UITableView*) tableView
{
    NSString* className = NSStringFromClass([self class]);
    
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:className];
    
    return [tableView dequeueReusableCellWithIdentifier:className];
}
@end
