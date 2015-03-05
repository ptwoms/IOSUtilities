//
//  P2MSPulldownRefreshTableView.m
//  IOSUtilities
//
//  Created by Pyae Phyo Myint Soe on 3/3/15.
//  Copyright (c) 2015 P2MS. All rights reserved.
//

#import "P2MSPulldownRefreshTableView.h"
#import "ProtocolMessageProxy.h"
#import "UIView+AutoLayoutAddition.h"

#define LOAD_MORE_HEIGHT 30.0f
#define BOTTOM_DISTANCE_TO_TRIGGER_LOAD_MORE 5.0f

@interface P2MSPulldownRefreshTableView(){
    BOOL canDoLoadingMore;
    
    ProtocolMessageProxy *delegate_interceptor;
}

@end

@implementation P2MSPulldownRefreshTableView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSetup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSetup];
    }
    return self;
}

- (void)initSetup{
    _isLoadingMore = NO;
    canDoLoadingMore = NO;
    self.enableLoadingMore = YES;
    delegate_interceptor = [ProtocolMessageProxy proxyWithInterceptedProtocol:@protocol(UITableViewDelegate)];
    delegate_interceptor.proxyToDelegate = self;
    [super setDelegate:(id)delegate_interceptor];
    
    self.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self
                            action:@selector(refreshPage:) forControlEvents:UIControlEventValueChanged];
}

- (void)setRefreshControl:(UIRefreshControl *)refreshControl{
    if (_refreshControl.window) {
        [_refreshControl removeFromSuperview];
    }
    _refreshControl = nil;
    _refreshControl = refreshControl;
    [self addSubview:_refreshControl];
}

- (id<UITableViewDelegate>)delegate{
    return delegate_interceptor.originalProtocolDelegate;
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate{
    [super setDelegate:nil];
    delegate_interceptor.originalProtocolDelegate = delegate;
    [super setDelegate:(id)delegate_interceptor];
}


#pragma mark - Refresh & loading more
- (IBAction)refreshPage:(id)sender{
    _isRefreshing = YES;
    if (_isLoadingMore) {
        [self stopLoadingMore];
    }
    if ([self.pullRefreshDelegate respondsToSelector:@selector(doRefreshingForTableView:)]) {
        [self.pullRefreshDelegate doRefreshingForTableView:self];
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self stopRefreshing];
        });
    }
}

- (void)stopRefreshing{
    _isRefreshing = NO;
    [self.refreshControl endRefreshing];
}

- (void) startLoadingMore{
    _isLoadingMore = YES;
    self.tableFooterView = [self getLoadMoreView];
    if ([self.pullRefreshDelegate respondsToSelector:@selector(doLoadingMoreForTableView:)]) {
        [self.pullRefreshDelegate doLoadingMoreForTableView:self];
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self stopLoadingMore];
        });
    }
}

- (void) stopLoadingMore{
    //add some concepts here
    _isLoadingMore = NO;
    self.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    canDoLoadingMore = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        canDoLoadingMore = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    canDoLoadingMore = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (canDoLoadingMore && self.enableLoadingMore && ((scrollView.contentSize.height - scrollView.frame.size.height) - scrollView.contentOffset.y <= BOTTOM_DISTANCE_TO_TRIGGER_LOAD_MORE) && !_isLoadingMore && !_isRefreshing) {
        [self startLoadingMore];
    }
}


- (UIView *)getLoadMoreView{
    if ([self.pullRefreshDelegate respondsToSelector:@selector(getLoadMoreFooterViewForTableView:)]) {
        return [self.pullRefreshDelegate getLoadMoreFooterViewForTableView:self];
    }
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, LOAD_MORE_HEIGHT)];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.translatesAutoresizingMaskIntoConstraints = NO;
    spinner.hidesWhenStopped = YES;
    [footerView addSubview:spinner];
    [footerView setCenterHorizontalInContainerForSubView:spinner];
    [spinner startAnimating];
    return footerView;
}

@end
