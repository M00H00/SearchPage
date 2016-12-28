//
//  ResBassData.m
//  SearchGithubReposDemo
//
//  Created by 牟华 on 16/12/27.
//  Copyright © 2016年 牟华. All rights reserved.
//

#import "ResBassData.h"
#import "MJExtension.h"

@implementation ResBassData

+ (NSDictionary *)mj_objectClassInArray;
{
    return @{@"items" : [Items class]};
}



@end
