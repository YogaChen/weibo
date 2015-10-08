//
//  NBComposeTool.h
//  weibo
//
//  Created by yoga on 15/8/29.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    NBComposeToolbarButtonTypeCamera, // 照相机
    NBComposeToolbarButtonTypePicture, // 相册
    NBComposeToolbarButtonTypeMention, // 提到@
    NBComposeToolbarButtonTypeTrend, // 话题
    NBComposeToolbarButtonTypeEmotion // 表情
} NBComposeToolbarButtonType;

@class NBComposeToolbar;

@protocol NBComposeToolbarDelegate <NSObject>

@optional
- (void)composeTool:(NBComposeToolbar *)toolbar didClickedButton:(NBComposeToolbarButtonType)buttonType;

@end

@interface NBComposeToolbar : UIView

@property (nonatomic , weak) id <NBComposeToolbarDelegate> delegate;

/**
 *  是否要显示表情按钮
 */
@property (nonatomic, assign, getter = isShowEmotionButton) BOOL showEmotionButton;


@end
