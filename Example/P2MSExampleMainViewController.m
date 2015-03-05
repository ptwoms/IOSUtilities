//
//  P2MSExampleMainViewController.m
//  IOSUtilities
//
//  Created by Pyae Phyo Myint Soe on 4/3/15.
//  Copyright (c) 2015 P2MS. All rights reserved.
//

#import "P2MSExampleMainViewController.h"
#import "P2MSPulldownRefreshTableView.h"

@interface P2MSExampleMainViewController ()

@property (nonatomic, weak) IBOutlet P2MSPulldownRefreshTableView *pullRefreshTableView;

@end

@implementation P2MSExampleMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pullRefreshTableView.delegate = self;
    self.pullRefreshTableView.pullRefreshDelegate = self;
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doLoadingMoreForTableView:(P2MSPulldownRefreshTableView *)tableView{
    [tableView stopLoadingMore];
}

- (void)doRefreshingForTableView:(P2MSPulldownRefreshTableView *)tableView{
    [tableView stopRefreshing];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll Main %@", NSStringFromClass([scrollView class]));
}

@end
