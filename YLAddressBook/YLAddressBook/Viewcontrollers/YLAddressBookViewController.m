//
//  YLAddressBookViewController.m
//  YLAddressBook
//
//  Created by YouLing on 2016/12/20.
//  Copyright © 2016年 YouLing. All rights reserved.
//

#import "YLAddressBookViewController.h"
#import "YLAddressBookModel.h"
@interface YLAddressBookViewController ()
{
    NSMutableArray* _dataArray;
}

/*
 *用来显示人员的信息
 */
@property(nonatomic,strong) UITableView* tableView;

@end

@implementation YLAddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"组织通讯录";
    self.view.backgroundColor = [UIColor redColor];
    /*
     *
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
