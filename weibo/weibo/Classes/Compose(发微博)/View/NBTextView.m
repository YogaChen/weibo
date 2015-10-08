//
//  NBTextView.m
//  weibo
//
//  Created by yoga on 15/8/28.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBTextView.h"

@interface NBTextView ()

@property (nonatomic , weak) UILabel *placeholderLabel;

@end

@implementation NBTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /// 添加一个显示提醒文字的label（显示占位文字的label）
        UILabel *placeholderLabel = [[UILabel alloc] init];
//        placeholderLabel.backgroundColor = [UIColor greenColor];
        placeholderLabel.textColor = [UIColor grayColor];
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        
        // 设置默认的字体
        self.font = [UIFont systemFontOfSize:14];
        
        // 不要设置自己的代理为自己本身
        // 监听内部文字改变
        //        self.delegate = self;
        
        /**
         监听控件的事件：
         1.delegate
         2.- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
         3.通知
         */
        
        // 当用户通过键盘修改了self的文字，self就会自动发出一个UITextViewTextDidChangeNotification通知
        // 一旦发出上面的通知，就会调用self的textDidChange方法
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];

    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听文字改变
- (void)textDidChange
{
    self.placeholderLabel.hidden = self.text.length != 0;
}

#pragma mark - 公共方法
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置占位符的frame
    self.placeholderLabel.x = 5;
    self.placeholderLabel.y = 8;
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    // 根据文字计算label的高度
    CGSize maxSize = CGSizeMake(self.placeholderLabel.width, MAXFLOAT);
    CGSize placeholderSize = [self.placeholder sizeWithFont:self.placeholderLabel.font constrainedToSize:maxSize];

    self.placeholderLabel.height = placeholderSize.height;

}

- (void)setPlaceholder:(NSString *)placeholder
{
    // 如果是copy策略，setter最好这么写
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;

    [self setNeedsLayout];
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    // 设置颜色
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    // 重新计算子控件的fame
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

@end
