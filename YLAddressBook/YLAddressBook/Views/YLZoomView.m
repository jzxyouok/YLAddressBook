//
//  YLZoomView.m
//  YLAddressBook
//
//  Created by YouLing on 2017/1/5.
//  Copyright © 2017年 YouLing. All rights reserved.
//

#import "YLZoomView.h"
#import "YLMemeberCell.h"
#import "YLDepartmentCell.h"

@interface  YLZoomView()<UITableViewDelegate,UITableViewDataSource>
/*
 *tableView 用来显示列表
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation YLZoomView
{
    NSMutableArray* _membersData;
    NSMutableArray* _departmentData;
}

#pragma mark -- nib加载完成后
-(void) awakeFromNib
{
    [super awakeFromNib];
    _membersData = [NSMutableArray array];
    _departmentData = [NSMutableArray array];
     self.tableView.tableFooterView = [[UIView  alloc] initWithFrame:CGRectZero];
//    self.departmentId = departmentId;
   
}

-(void) setDepartmentId:(NSString *)departmentId
{
    
    if ([_departmentId isEqualToString:departmentId]) {
        return;
    }
    _departmentId = departmentId;
    if (departmentId.length > 0) {
      NSArray* array =  [self.delegate zoomView:self withDepartmentId:_departmentId];
        _membersData = [array objectAtIndex:0];
        _departmentData = [array objectAtIndex:1];
    }
    else
    {
        NSArray* array =  [self.delegate zoomView:self withDepartmentId:@"YunYunRoot"];
        _membersData = [array objectAtIndex:0];
        _departmentData = [array objectAtIndex:1];
    }
    [self.tableView reloadData];
}
#pragma mark -- 写类方法用来创建YLZoomView对象

+(instancetype) zoomViewWithDepartmentId:(NSString*) departmentId
{
    YLZoomView * view = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil] objectAtIndex:0];
    return view;

}
-(void) willRemoveSubview:(UIView *)subview
{
    if (self.departmentId.length > 0) {
        NSArray* array =  [self.delegate zoomView:self withDepartmentId:self.departmentId];
        _membersData = [array objectAtIndex:0];
        _departmentData = [array objectAtIndex:1];
    }
    else
    {
        NSArray* array =  [self.delegate zoomView:self withDepartmentId:@"云云通讯"];
        _membersData = [array objectAtIndex:0];
        _departmentData = [array objectAtIndex:1];
    }
    [self.tableView reloadData];

}
#pragma mark -- UITableViewDataSource代理
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return  2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return _membersData.count;
    }
    else if(section == 1)
    {
        return _departmentData.count;
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;    //人员的
    if (indexPath.section == 0) {
        //cell.backgroundColor = [UIColor redColor];
        YLMemeberCell* memeberCell = [YLMemeberCell cellWithTableView:tableView];
        memeberCell.dataModel = _membersData[indexPath.row];
        cell = memeberCell;
    }
    //部门的
    else if(indexPath.section == 1)
    {
        // cell.backgroundColor = [UIColor blueColor];
        YLDepartmentCell* departmentCell = [YLDepartmentCell cellWithTableView:tableView];
        departmentCell.dataModel = _departmentData[indexPath.row];
        cell= departmentCell;;
    }
    return cell;
}
#pragma mark UITableViewDelegate代理
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
//        -(void) zoomView:(YLZoomView*) zoomView clickWithModel:(YLAddressBookModel*) model;
        [self.delegate zoomView:self clickWithModel:_membersData[indexPath.row]];
    }
    else if(indexPath.section == 1)
    {
        [self.delegate zoomView:self clickWithModel:_departmentData[indexPath.row]];
    }
}
@end









