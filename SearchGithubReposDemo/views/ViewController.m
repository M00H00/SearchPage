//
//  ViewController.m
//  SearchGithubReposDemo
//
//  Created by 牟华 on 16/12/27.
//  Copyright © 2016年 牟华. All rights reserved.
//

#import "ViewController.h"
#import "SearchDisplayController.h"
#import "SearchBar.h"
#import "RealtimeSearchUtil.h"
#import "MHHttpTool.h"
#import "TableViewCell.h"
#import "WebViewController.h"

#define screen_size [UIScreen mainScreen].bounds.size

@interface ViewController () <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) SearchBar *searchBar;

@property (strong, nonatomic) SearchDisplayController *searchController;

@property (assign, nonatomic) NSInteger inputCount;

@property (strong, nonatomic) NSString *searchText;

@property (strong, nonatomic) NSURLSessionTask *searchTask;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Search Page";
    self.extendedLayoutIncludesOpaqueBars = true;
    [self searchController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (SearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[SearchBar alloc] init];
        _searchBar.delegate = self;
        _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _searchBar.placeholder =  @"Search";
        _searchBar.backgroundColor = [UIColor colorWithRed:0.747 green:0.756 blue:0.751 alpha:1.000];
        _searchBar.tintColor = [UIColor lightGrayColor];
        
    }
    
    return _searchBar;
}

- (SearchDisplayController *)searchController
{
    if (_searchController == nil) {
        _searchController = [[SearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        _searchController.displaysSearchBarInNavigationBar = true;
        _searchController.delegate = self;
        
        _searchController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        __weak typeof(self) weakSelf = self;
        
        [_searchController setCellForRowAtIndexPathCompletion:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            
            TableViewCell *cell = [TableViewCell cellWithTableView:tableView];
            Items *item = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            cell.item = item;
            return cell;
        }];
        
        [_searchController setHeightForRowAtIndexPathCompletion:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            return 50;
        }];
        
        [_searchController setDidSelectRowAtIndexPathCompletion:^(UITableView *tableView, NSIndexPath *indexPath) {
            WebViewController *rookieWeb = [[WebViewController alloc] init];
            Items *item = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            rookieWeb.loadUrlStr = item.html_url;
            rookieWeb.title = item.desc;
            [weakSelf.navigationController pushViewController:rookieWeb animated:true];
        }];
        
        [_searchController setCanEditRowAtIndexPath:^BOOL(UITableView *tableview, NSIndexPath *index) {
            return false;
        }];
    }
    
    return _searchController;
}

#pragma mark - UISearchBar代理
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];

    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.inputCount ++;
    self.searchText = searchText;
    
    if (self.inputCount == 1) {
        [self requestKeyWorld:@1];
    } else if (self.inputCount > 1) {
        [self performSelector:@selector(requestKeyWorld:) withObject:@(self.inputCount) afterDelay:1.0f];
    } else {
        return ;
    }
    
}


- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [[RealtimeSearchUtil currentUtil] realtimeSearchStop];
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark - 根据关键字请求
- (void)requestKeyWorld:(NSNumber *)count {
    
    if (self.inputCount == [count integerValue]) {
        //说明用户停止输入超过了一秒，发起网络请求
        [self.searchTask cancel];
        
        ReqBassModel *req = [[ReqBassModel alloc] init];
        req.q = self.searchText;
        req.sort = @"Default";
        req.order = @"desc";
        __weak typeof(self) weakSelf = self;
        self.searchTask = [MHHttpTool GETWithParameters:req success:^(ResBassData *response) {
            
            [[RealtimeSearchUtil currentUtil] realtimeSearchWithSource:response.items searchText:self.searchText collationStringSelector:@selector(title) resultBlock:^(NSArray *results) {
                if (results) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.searchController.resultsSource removeAllObjects];
                        [weakSelf.searchController.resultsSource addObjectsFromArray:results];
                        [weakSelf.searchController.searchResultsTableView reloadData];
                    });
                }
            }];
        } failure:^(NSError *error) {
            
        }];
        
    }
}

@end
