//
//  NBSendStatusParam.h
//  weibo
//
//  Created by yoga on 15/8/31.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBBaseParam.h"

@interface NBSendStatusParam : NBBaseParam

/**	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
@property (nonatomic, copy) NSString *status;

@end
