//
//  WebViewController.h
//  SearchGithubReposDemo
//
//  Created by 牟华 on 16/12/27.
//  Copyright © 2016年 牟华. All rights reserved.
//

#import <UIKit/UIKit.h>

@implementation UIView (DBExtention)

- (void)setDb_x:(CGFloat)db_x
{
    CGRect frame = self.frame;
    frame.origin.x = db_x;
    self.frame = frame;
}

- (CGFloat)db_x
{
    return self.frame.origin.x;
}

- (void)setDb_y:(CGFloat)db_y
{
    CGRect frame = self.frame;
    frame.origin.y = db_y;
    self.frame = frame;
}

- (CGFloat)db_y
{
    return self.frame.origin.y;
}

- (void)setDb_width:(CGFloat)db_width
{
    CGRect frame = self.frame;
    frame.size.width = db_width;
    self.frame = frame;
}

- (CGFloat)db_width
{
    return self.frame.size.width;
}

- (void)setDb_height:(CGFloat)db_height
{
    CGRect frame = self.frame;
    frame.size.height = db_height;
    self.frame = frame;
}

- (CGFloat)db_height
{
    return self.frame.size.height;
}

@end

@interface WebViewController : UIViewController

@property (strong, nonatomic) NSString *loadUrlStr;

@property (strong, nonatomic) NSString *loadStr;

@end
