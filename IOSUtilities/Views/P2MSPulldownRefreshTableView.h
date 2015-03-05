//
//  P2MSPulldownRefreshTableView.h
//  IOSUtilities
//
//  Created by Pyae Phyo Myint Soe on 3/3/15.
//  Copyright (c) 2015 P2MS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class P2MSPulldownRefreshTableView;

@protocol  P2MSPulldownRefreshTableDelegate<NSObject>

//- (void)willRefreshTableView:(P2MSPulldownRefreshTableView *)tableView;

- (void)doRefreshingForTableView:(P2MSPulldownRefreshTableView *)tableView;
- (void)doLoadingMoreForTableView:(P2MSPulldownRefreshTableView *)tableView;

@optional
- (UIView *)getLoadMoreFooterViewForTableView:(P2MSPulldownRefreshTableView *)tableView;

@end

@interface P2MSPulldownRefreshTableView : UITableView

@property (nonatomic, weak) id<P2MSPulldownRefreshTableDelegate> pullRefreshDelegate;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, readonly) BOOL isRefreshing, isLoadingMore;

@property (nonatomic) BOOL enableLoadingMore;


- (void)stopRefreshing;
- (void) stopLoadingMore;

@end
