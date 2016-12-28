//
//  TableViewCell.m
//  SearchGithubReposDemo
//
//  Created by 牟华 on 16/12/27.
//  Copyright © 2016年 牟华. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()

@property (weak, nonatomic) UIView *lineView;

@end

@implementation TableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    TableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TableViewCell"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.textLabel.textColor = [UIColor redColor];
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        
        self.detailTextLabel.font = [UIFont systemFontOfSize:13];
        self.detailTextLabel.textAlignment = NSTextAlignmentRight;
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineView];
        self.lineView = lineView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.frame = CGRectMake(10, 5, 100, 50);
    
    self.detailTextLabel.frame = CGRectMake(self.contentView.bounds.size.width - 200 - 10, 0, 200, 50);
    self.lineView.frame = CGRectMake(10, self.contentView.bounds.size.height - 1, self.contentView.bounds.size.width, 1);
    
}

- (void)setItem:(Items *)item
{
    _item = item;
    
    self.textLabel.text = item.owner.login;
    self.detailTextLabel.text = item.desc;
}

@end
