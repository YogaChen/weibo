//
//  NBUnreadCountResult.h
//  weibo
//
//  Created by yoga on 15/9/3.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBBaseParam.h"

@interface NBUnreadCountResult : NBBaseParam

/** 新微博未读数 */
@property (nonatomic, assign) int status;

/** 新粉丝数 */
@property (nonatomic, assign) int follower;

/** 新评论数 */
@property (nonatomic, assign) int cmt;

/** 新私信数 */
@property (nonatomic, assign) int dm;

/** 新提及我的微博数 */
@property (nonatomic, assign) int mention_cmt;

/** 新提及我的评论数 */
@property (nonatomic, assign) int mention_status;

/** 消息未读数 */
- (int)messageCount;

/** 所有未读数 */
- (int)totalCount;

@end
