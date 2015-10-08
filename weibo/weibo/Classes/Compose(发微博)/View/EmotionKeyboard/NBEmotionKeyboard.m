//
//  NBEmotionKeyboard.m
//  weibo
//
//  Created by yoga on 15/10/6.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBEmotionKeyboard.h"
#import "NBEmotionListView.h"
#import "NBEmotionToolbar.h"
#import "MJExtension.h"
#import "NBEmotion.h"

@interface NBEmotionKeyboard ()

/** 表情列表 */
@property (nonatomic, weak) NBEmotionListView *listView;
/** 表情工具条 */
@property (nonatomic, weak) NBEmotionToolbar *toollbar;
/** 默认表情 */
@property (nonatomic, strong) NSArray *defaultEmotions;
/** emoji表情 */
@property (nonatomic, strong) NSArray *emojiEmotions;
/** 浪小花表情 */
@property (nonatomic, strong) NSArray *lxhEmotions;

@end

@implementation NBEmotionKeyboard

- (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        self.defaultEmotions = [NBEmotion objectArrayWithFile:plist];
    }
    return _defaultEmotions;
}

- (NSArray *)emojiEmotions
{
    if (!_emojiEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiEmotions = [NBEmotion objectArrayWithFile:plist];
    }
    return _emojiEmotions;
}

- (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.defaultEmotions = [NBEmotion objectArrayWithFile:plist];
    }
    return _lxhEmotions;
}

+ (instancetype)keyboard
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithNamed:@"emoticon_keyboard_background"]];

        // 1.添加表情列表
        NBEmotionListView *listView = [[NBEmotionListView alloc] init];
        listView.backgroundColor = [UIColor greenColor];
        [self addSubview:listView];
        self.listView = listView;
        
        // 2.添加表情工具条
        NBEmotionToolbar *toollbar = [[NBEmotionToolbar alloc] init];
        [self addSubview:toollbar];
        self.toollbar = toollbar;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置工具条的frame
    self.toollbar.width = self.width;
    self.toollbar.height = 35;
    self.toollbar.y = self.height - self.toollbar.height;
    
    // 2.设置表情列表的frame
    self.listView.width = self.width;
    self.listView.height = self.toollbar.y;
    
}


@end
