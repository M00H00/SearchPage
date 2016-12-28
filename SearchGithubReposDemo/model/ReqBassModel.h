//
//  ReqBassModel.h
//  SearchGithubReposDemo
//
//  Created by 牟华 on 16/12/27.
//  Copyright © 2016年 牟华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqBassModel : NSObject

/**
 *  The search keywords, as well as any qualifiers.
 */
@property (strong, nonatomic) NSString *q;

/**
 *  The sort field. One of stars, forks, or updated. Default: results are sorted by best match.
 */
@property (strong, nonatomic) NSString *sort;

/**
 *  The sort order if sort parameter is provided. One of asc or desc. Default: desc
 */
@property (strong, nonatomic) NSString *order;

@end
