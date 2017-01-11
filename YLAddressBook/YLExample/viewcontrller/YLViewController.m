//
//  YLViewController.m
//  YLAddressBook
//
//  Created by YouLing on 2016/12/20.
//  Copyright © 2016年 YouLing. All rights reserved.
//

#import "YLViewController.h"
#import "YLTableViewCell.h"
#import "YLAddressBookViewController.h"
#import "YLAddressBookModel.h"
#import "YLAddressBookZoomController.h"
@interface YLViewController ()<UITableViewDelegate,UITableViewDataSource,YLAddressBookViewControllerDelegate>

@property(nonatomic,strong) UITableView* tableView;


@end

@implementation YLViewController
{
    NSArray* _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //设置navigation的title
    self.navigationItem.title = @"在线通讯录";
    //设置uitableView的属性
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"AddressList"];
    [self.view addSubview:self.tableView];
    //隐藏分割线
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //
    _dataArray = [NSArray arrayWithObjects:@"在线通讯录01",@"在线通讯录02", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableView的UITableViewDataSource代理
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddressList"];
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

#pragma mark - tableView的UITableViewDelegate代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //NSLog(@"你点击了这里");
        YLAddressBookViewController* addreBookViewController = [[YLAddressBookViewController alloc] init];
        addreBookViewController.delegate = self;
        [self.navigationController pushViewController:addreBookViewController animated:YES];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
        
    }else if(indexPath.row == 1)
    {
        YLAddressBookZoomController* addreBookZoomController = [[YLAddressBookZoomController alloc] init];
        [self.navigationController pushViewController:addreBookZoomController animated:YES];
         self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    }
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - YLAddressBookViewController的代理
-(NSArray*) YLAddressBookViewController:(YLAddressBookViewController *)viewcontroller getNextListDataWithConnect:(NSString *)connectPlist
{
    //获取plist的路径
    NSString* connectPlistPath = [[NSBundle mainBundle] pathForResource:connectPlist ofType:@".plist"];
    //读取plist的内容
    NSMutableDictionary* dictA = [[NSMutableDictionary alloc] initWithContentsOfFile:connectPlistPath];
    //对plist的内容就行解析
    NSArray* arrayA = [dictA objectForKey:@"DepartmentAndMembers"];
    NSMutableArray* departmentDataArray = [NSMutableArray array];
    NSMutableArray* memeberDataArray = [NSMutableArray array];
    NSMutableArray* dataArray = [NSMutableArray array];
    //对数据进行解析
    for (NSDictionary* dict in arrayA) {
        YLAddressBookModel* addressBookModel = [YLAddressBookModel addressBookModelWithDict:dict];
        //[dataArray addObject:addressBookModel];
        if ([addressBookModel.itemType isEqualToString:@"memeber"]) {
            [memeberDataArray addObject:addressBookModel];
        }
        else if([addressBookModel.itemType isEqualToString:@"department"])
        {
            [departmentDataArray addObject:addressBookModel];
        }
    }
    
    [dataArray addObject:memeberDataArray];
    
    [dataArray addObject:departmentDataArray];
    
    return dataArray;
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
