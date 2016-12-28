//
//  TableViewCell.h
//  SearchGithubReposDemo
//
//  Created by 牟华 on 16/12/27.
//  Copyright © 2016年 牟华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Items.h"

@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) Items *item;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
