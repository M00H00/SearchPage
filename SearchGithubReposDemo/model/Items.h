//
//  ReposData.h
//  SearchGithubReposDemo
//
//  Created by 牟华 on 16/12/27.
//  Copyright © 2016年 牟华. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Owner : NSObject

@property (strong, nonatomic) NSString *login;

@end


@interface Items : NSObject

@property (strong, nonatomic) NSString *name;


@property (strong, nonatomic) NSString *desc;

@property (strong, nonatomic) Owner *owner;

@property (strong, nonatomic) NSString *html_url;

@end
