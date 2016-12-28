//
//  MHHttpTool.h
//  SearchGithubReposDemo
//
//  Created by 牟华 on 16/12/27.
//  Copyright © 2016年 牟华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReqBassModel.h"
#import "ResBassData.h"

@interface MHHttpTool : NSObject

+ (NSURLSessionDataTask *)GETWithParameters:(ReqBassModel *)param
                  success:(void(^)(ResBassData *response))success
                  failure:(void(^)(NSError *error))failure;

@end
