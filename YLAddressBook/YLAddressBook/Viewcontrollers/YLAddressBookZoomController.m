//
//  YLAddressBookZoomController.m
//  YLAddressBook
//
//  Created by YouLing on 2017/1/5.
//  Copyright © 2017年 YouLing. All rights reserved.
//

#import "YLAddressBookZoomController.h"
#import "YLZoomView.h"
#import "YLAddressBookModel.h"
#include "YLUtility.h"
@interface YLAddressBookZoomController ()<YLZoomViewDelegate>
/*
 *左边的view
 */
@property(nonatomic,strong) YLZoomView* leftView;
/*
 *右边的view
 */
@property(nonatomic,strong) YLZoomView* rightView;
/*
 *存储UIView的
 */
@property(nonatomic,strong) NSMutableArray* viewsArray;
@end

@implementation YLAddressBookZoomController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    YLZoomView* rootView = [YLZoomView zoomViewWithDepartmentId:@""];
    rootView.delegate = self;
    rootView.departmentId = @"";
    [self.view addSubview:rootView];
    rootView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    self.viewsArray = [NSMutableArray array];
    self.leftView = rootView;
    [self.viewsArray addObject:rootView];
    [self setBackBtn];
}
#pragma mark - YLZoomViewDelegate的实现
-(NSArray*) zoomView:(YLZoomView*) zoomView withDepartmentId:(NSString*) departmentId
{
        //获取plist的路径
        NSString* connectPlistPath = [[NSBundle mainBundle] pathForResource:departmentId ofType:@".plist"];
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
-(void) zoomView:(YLZoomView *)zoomView clickWithModel:(YLAddressBookModel *)model
{
    if ([model.itemType isEqualToString:@"memeber"]) {
        
        UIAlertController* alertcontroller = [UIAlertController alertControllerWithTitle:@"提示" message:@"个人聊天界面正在开发中" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertcontroller addAction:alertAction];
        [self presentViewController:alertcontroller animated:YES completion:^{
            
        }];

    }else if([model.itemType isEqualToString:@"department"])
    {
       
        if (zoomView == self.leftView && self.rightView == nil) {
            YLZoomView* nextView = [YLZoomView zoomViewWithDepartmentId:@""];
            [self.viewsArray addObject:nextView];
            nextView.delegate = self;
            nextView.departmentId = model.connectionplist;
            nextView.frame = CGRectMake(SCREENWIDTH, 64, 200, SCREENHEIGHT);
            [self.view addSubview:nextView];
            CGRect rect2 = self.view.frame;
            rect2.origin.x = 0;
            rect2.origin.y = 64;
            rect2.size.height = self.view.bounds.size.height;
            rect2.size.width = SCREENWIDTH*105/320;
            CGRect rect = self.view.frame;
            rect.origin.x = SCREENWIDTH*105/320;
            rect.origin.y =64;
            rect.size.height = self.view.bounds.size.height;
            rect.size.width = SCREENWIDTH*225/320;
            self.rightView = nextView;
            [UIView animateWithDuration:0.5 animations:^{
                
                self.rightView.frame = rect;
                
                
            } completion:^(BOOL finished) {
                
            }];
        }
        else if(zoomView == self.leftView &&  self.rightView != nil)
        {
            self.rightView.departmentId = model.connectionplist;
        }
        else if(zoomView == self.rightView)
        {
            CGRect rect = self.view.frame;
            rect.origin.x = -SCREENWIDTH*105/320;
            rect.origin.y = 64;
            rect.size.height = self.view.bounds.size.height;
            rect.size.width = SCREENWIDTH*105/320;
            
            
            CGRect rect1 = self.view.frame;
            rect1.origin.x = 0;
            rect1.origin.y = 64;
            rect1.size.height = self.view.bounds.size.height;
            rect1.size.width = SCREENWIDTH;
            //rect1.size.width = SCREENWIDTH*105/320;
            self.leftView = self.rightView;
            
            
            YLZoomView* nextView = [YLZoomView zoomViewWithDepartmentId:@""];
            
            nextView.delegate = self;
            nextView.departmentId = model.connectionplist;
            nextView.frame = CGRectMake(SCREENWIDTH, 64, 200, SCREENHEIGHT);
            [self.view addSubview:nextView];
            [self.viewsArray addObject:nextView];
            
            CGRect rect2 = self.view.frame;
            rect2.origin.x = SCREENWIDTH*105/320;
            rect2.origin.y =64;
            rect2.size.height = self.view.bounds.size.height;
            rect2.size.width = SCREENWIDTH*225/320;
            self.rightView = nextView;
            
            
            [self.leftView setShowMemebers:NO];
            [UIView animateWithDuration:0.5 animations:^{
               self.leftView.frame = rect1;
               self.rightView.frame = rect2;
            } completion:^(BOOL finished) {
                CGRect rect = self.leftView.frame;
                rect.size.width = SCREENWIDTH*105/320;
                self.leftView.frame = rect;
                
            }];

        }
        
    }
    [self setBackBtn];
   }
-(void)gotoBack:(id) sender
{
    //self.rightView.hidden = YES;
    if (self.rightView == self.viewsArray.lastObject) {
        [self.viewsArray removeLastObject];
        CGRect rightRect;
        rightRect = self.rightView.frame;
        rightRect.origin.x = SCREENWIDTH;
        CGRect leftRect;
        if (self.viewsArray.count == 1) {
            leftRect = self.leftView.frame;
            leftRect.size.width = SCREENWIDTH;
        }
        else
        {
            leftRect = self.leftView.frame;
            leftRect.origin.x = SCREENWIDTH*105/320;
            leftRect.size.width = SCREENWIDTH*225/320;
        }
        [self.leftView setShowMemebers:YES];
        [UIView animateWithDuration:0.5 animations:^{
            self.leftView.frame = leftRect;
            self.rightView.frame = rightRect;
            
        } completion:^(BOOL finished) {
            if (self.viewsArray.count > 1) {
                self.leftView = self.viewsArray[self.viewsArray.count-2];
                self.rightView = self.viewsArray.lastObject;
            }
            else
            {
                self.leftView = self.viewsArray.lastObject;
                self.rightView = nil;
               
            }
            
        }];
        
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    [self setBackBtn];
}
-(void) setBackBtn
{
    if (self.viewsArray.count > 1) {
        UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"返回上一级" style:UIBarButtonItemStylePlain target:self action:@selector(gotoBack:)];
        self.navigationItem.leftBarButtonItem = item;
    }
    else
    {
        UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(gotoBack:)];
        self.navigationItem.leftBarButtonItem = item;
    }

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
