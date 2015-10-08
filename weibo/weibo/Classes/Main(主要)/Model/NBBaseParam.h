//
//  NBBaseParam.h
//  weibo
//
//  Created by yoga on 15/8/31.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBBaseParam : NSObject

/**	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property (nonatomic, copy) NSString *access_token;

+ (instancetype)param;

@end
