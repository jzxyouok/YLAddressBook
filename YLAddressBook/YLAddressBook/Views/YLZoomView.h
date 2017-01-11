//
//  YLZoomView.h
//  YLAddressBook
//
//  Created by YouLing on 2017/1/5.
//  Copyright © 2017年 YouLing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLAddressBookModel.h"
@class YLZoomView;

@protocol  YLZoomViewDelegate<NSObject>

-(NSArray*) zoomView:(YLZoomView*) zoomView withDepartmentId:(NSString*) departmentId;
-(void) zoomView:(YLZoomView*) zoomView clickWithModel:(YLAddressBookModel*) model;

@end


@interface YLZoomView : UIView

/*
 *对应的部门的id
 */
@property (nonatomic,strong) NSString* departmentId;
/*
 *delegate属性
 */
@property(nonatomic,weak) id<YLZoomViewDelegate> delegate;
/*
 *构造方法
 */
+(instancetype) zoomViewWithDepartmentId:(NSString*) departmentId;

@end
