//
//  ResBassData.h
//  SearchGithubReposDemo
//
//  Created by 牟华 on 16/12/27.
//  Copyright © 2016年 牟华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Items.h"



@interface ResBassData : NSObject

@property (assign, nonatomic) NSInteger total_count;

@property (assign, nonatomic) BOOL incomplete_results;

@property (strong, nonatomic) NSArray *items;

@end
