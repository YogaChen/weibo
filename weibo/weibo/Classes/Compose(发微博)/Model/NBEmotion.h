//
//  NBEmotion.h
//  
//
//  Created by yoga on 15/10/8.
//
//

#import <Foundation/Foundation.h>

@interface NBEmotion : NSObject

/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的png图片名 */
@property (nonatomic, copy) NSString *png;
/** emoji表情的编码 */
@property (nonatomic, copy) NSString *code;

@end
