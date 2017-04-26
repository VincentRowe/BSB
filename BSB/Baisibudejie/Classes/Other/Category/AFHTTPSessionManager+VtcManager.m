//
//  AFHTTPSessionManager+VtcManager.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/25.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "AFHTTPSessionManager+VtcManager.h"

@implementation AFHTTPSessionManager (VtcManager)

+ (instancetype)vtc_manager {

    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //[AFJSONRequestSerializer serializer]    :   JSON
    //[AFOnoResponseSerializer XMLResponseSerializer] : XML
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    mgr.responseSerializer = response;
    
    return mgr;
}

@end
