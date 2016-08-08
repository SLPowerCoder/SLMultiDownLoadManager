//
//  DownLoadingTableView.h
//  SLMultiDownLoadManager
//
//  Created by sunlei on 16/8/4.
//  Copyright © 2016年 sunlei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownLoadingTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) BOOL isDownLoadCompletedTableView; //表示是否是下载完成的table

@property (nonatomic, copy) void(^deleteSucess)(); //批量删除成功回调


- (instancetype)initWithFrame:(CGRect)rect style:(UITableViewStyle)tableViewStyle WithDataSource:(NSMutableArray *)dataSource;

@end
