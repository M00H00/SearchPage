//
//  MHHttpTool.m
//  SearchGithubReposDemo
//
//  Created by 牟华 on 16/12/27.
//  Copyright © 2016年 牟华. All rights reserved.
//

#import "MHHttpTool.h"
#import "MHHTTPManager.h"
#import "MJExtension.h"

#define bass_url @"https://api.github.com/search/repositories"

@implementation MHHttpTool

+ (NSURLSessionDataTask *)GETWithParameters:(ReqBassModel *)param success:(void(^)(ResBassData *response))success failure:(void(^)(NSError *error))failure
{
    MHHTTPManager *manager = [MHHTTPManager manager];
    
    NSDictionary *paramDict = param.mj_keyValues;
    NSURLSessionDataTask *task = [manager GET:bass_url parameters:paramDict success:^(NSURLSessionDataTask *task, id responseObject) {
        ResBassData *resData = [ResBassData mj_objectWithKeyValues:responseObject];
        success(resData);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    
    return task;
}


@end
