//
//  ViewController2.h
//  lvjing
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController2 : UIViewController<UITableViewDataSource,UITableViewDelegate>
//数据源列表
@property (strong, nonatomic) NSMutableArray *dataSourceList;
//表视图(弱引用，将表视图绑定于视图，不用再关心手动释放问题)
@property (weak, nonatomic) UITableView *myTableView;


@end
