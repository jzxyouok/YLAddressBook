//
//  YLAddressBookViewController.m
//  YLAddressBook
//
//  Created by YouLing on 2016/12/20.
//  Copyright © 2016年 YouLing. All rights reserved.
//

#import "YLAddressBookViewController.h"
#import "YLAddressBookModel.h"
#import "YLDepartmentCell.h"
#import "YLMemeberCell.h"
@interface YLAddressBookViewController ()<UITableViewDelegate,UITableViewDataSource,YLAddressBookViewControllerDelegate>
{
    NSMutableArray* _memeberDataArray;
    NSMutableArray* _departmentDataArray;
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    //_dataArray = [NSMutableArray array];
    _memeberDataArray = [NSMutableArray array];
    _departmentDataArray = [NSMutableArray array];
    /*
     *设置tableView的属性
     */
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //添加tableView
    [self.view addSubview:self.tableView];
}
- (void) viewWillAppear:(BOOL)animated
{
    if ([self.departId isEqualToString:@""]||self.departId==nil) {
       NSArray* tempArray =  [self.delegate YLAddressBookViewController:self getNextListDataWithConnect:@"YunYunRoot"];
        //人员的数组
         _memeberDataArray = [NSMutableArray arrayWithArray:tempArray[0]];
        //部门数组
        _departmentDataArray = [NSMutableArray arrayWithArray:tempArray[1]];
       
        //刷新
        [self.tableView reloadData];
        
    }else{
        NSArray* tempArray =  [self.delegate YLAddressBookViewController:self getNextListDataWithConnect:self.departId];
        //人员的数组
        _memeberDataArray = [NSMutableArray arrayWithArray:tempArray[0]];
        //部门数组
        _departmentDataArray = [NSMutableArray arrayWithArray:tempArray[1]];
        
        //刷新
        [self.tableView reloadData];

    }
}
#pragma mark -- tableView的代理开始

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return _memeberDataArray.count;
    }
    else if(section == 1)
    {
        return _departmentDataArray.count;
    }
    else
        return 0;
        
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        
    }
    else if(indexPath.section == 1)
    {
        YLAddressBookViewController* viewController = [[YLAddressBookViewController alloc] init];
        viewController.delegate = self;
        viewController.departId = ((YLAddressBookModel*)(_departmentDataArray[indexPath.row])).connectionplist;
        [self.navigationController pushViewController:viewController animated:YES];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回上级目录" style:UIBarButtonItemStylePlain target:self action:nil];
    }
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;    //人员的
    if (indexPath.section == 0) {
        //cell.backgroundColor = [UIColor redColor];
        YLMemeberCell* memeberCell = [YLMemeberCell cellWithTableView:tableView];
        memeberCell.dataModel = _memeberDataArray[indexPath.row];
        cell = memeberCell;
    }
    //部门的
    else if(indexPath.section == 1)
    {
       // cell.backgroundColor = [UIColor blueColor];
        YLDepartmentCell* departmentCell = [YLDepartmentCell cellWithTableView:tableView];
        departmentCell.dataModel = _departmentDataArray[indexPath.row];
        cell= departmentCell;;
    }
    return cell;
}
#pragma mark -- tableView的代理结束

#pragma mark -- YLAddressBookViewController代理的开始
-(NSArray *)YLAddressBookViewController:(YLAddressBookViewController *)viewcontroller getNextListDataWithConnect:(NSString *)connectPlist
{
    return [self.delegate YLAddressBookViewController:self getNextListDataWithConnect:connectPlist];
}

#pragma mark -- YLAddressBookViewController代理结束

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
