//
//  NBComposeViewController.m
//  weibo
//
//  Created by yoga on 15/8/24.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBComposeViewController.h"
#import "NBTextView.h"
#import "NBComposeToolbar.h"
#import "NBComposePhotosView.h"
#import "NBAccount.h"
#import "NBAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "NBStatusTool.h"
#import "NBSendStatusResult.h"
#import "NBSendStatusParam.h"
#import "NBEmotionKeyboard.h"

@interface NBComposeViewController() <NBComposeToolbarDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) NBTextView *textView;
@property (nonatomic, weak) NBComposePhotosView *photosView;
@property (nonatomic, weak) NBComposeToolbar *toolbar;
@property (nonatomic, strong) NBEmotionKeyboard *kerboard;
/** 是否正在切换键盘 */
@property (nonatomic, assign, getter = isChangingKeyboard) BOOL changingKeyboard;

@end

@implementation NBComposeViewController

#pragma mark - 初始化方法
- (NBEmotionKeyboard *)kerboard
{
    if (!_kerboard) {
        self.kerboard = [NBEmotionKeyboard keyboard];
        self.kerboard.backgroundColor = [UIColor blueColor];
        self.kerboard.width = NBScreenW;
        self.kerboard.height = 216;
    }
    return _kerboard;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航条内容
    [self setupNavBar];
    
    // 添加输入控件
    [self setupTextView];
    
    // 添加工具条
    [self setupToolbar];
    
    // 添加显示图片的相册控件
    [self setupPhotosView];
}

// 添加显示图片的相册控件
- (void)setupPhotosView
{
    NBComposePhotosView *photosView = [[NBComposePhotosView alloc] init];
    photosView.width = self.textView.width;
    photosView.height = self.textView.height;
    photosView.y = 70;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

/**
 *  设置导航条内容
 */
- (void)setupNavBar
{
    self.title = @"发微博";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleBordered target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

/**
 *  添加输入控件
 */
- (void)setupTextView
{
    // 添加多行文本输入框
    NBTextView *textView = [[NBTextView alloc] init];
    textView.alwaysBounceVertical = YES; // 垂直方向上拥有有弹簧效果
    textView.frame = self.view.bounds;
    textView.placeholder = @"分享新鲜事...";
//    textView.placeholderColor = [UIColor redColor];
    // 设置字体
    textView.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:textView];
    self.textView = textView;
    self.textView.delegate = self;
    
    // 监听键盘
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  添加工具条
 */
- (void)setupToolbar
{
    // 创建
    NBComposeToolbar *toolbar = [[NBComposeToolbar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 35;
    toolbar.delegate = self;
    self.toolbar = toolbar;
    
    // 显示
//    self.textView.inputAccessoryView = toolbar;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
}

/**
 *  view显示完毕的时候再弹出键盘，避免显示控制器view的时候会卡住
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 成为第一响应者（叫出键盘）
    [self.textView becomeFirstResponder];
}

/**
 *  取消
 */
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
//    self.textView.text = @"";
//    self.textView.font = [UIFont systemFontOfSize:30];
}

/**
 *  发送
 */
- (void)send
{
    // 发布微博
    if (self.photosView.image.count) {
        // 发送有图片的微博
        [self sendStatusWithImage];
    }else{
        // 发送没有图片的微博
        [self sendStatusWithoutImage];
    }
    // 关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发送有图片的微博
 */
- (void)sendStatusWithImage
{
    // 1.获得请求管理者
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    
//    // 2.封装请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [NBAccountTool account].access_token;
//    params[@"status"] = self.textView.text;
//    
//    // 3.发送POST请求
////    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *resultDict) { // 发送图片不是这个方法
//    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
//        // 目前新浪开放的发微博接口 最多 只能上传一张图片
//        UIImage *image = [self.photosView.image firstObject];
//        NSData *data = UIImageJPEGRepresentation(image, 1.0);
////        params[@"pic"] = data;// 错误的
//        [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
//        
//    } success:^(AFHTTPRequestOperation *operation, NSDictionary *statusDict) {
//        [MBProgressHUD showSuccess:@"发送成功"];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"发送失败"];
//        
//    }];
}

/**
 *  发送没有图片的微博
 */
- (void)sendStatusWithoutImage
{
    // 1.封装请求参数
    NBSendStatusParam *param = [NBSendStatusParam param];
    param.status = self.textView.text;
    
    // 2.发送POST请求
    [NBStatusTool sendStatusWithParam:param success:^(NBSendStatusResult *result) {
        [MBProgressHUD showSuccess:@"发送成功"];

    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];

    }];
}

#pragma mark - 键盘处理
/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    if (self.isChangingKeyboard) {
        self.changingKeyboard = NO;
        return;
    }
    
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}

/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];
}

#pragma mark - UITextViewDelegate
/**
 *  当用户开始拖拽scrollView时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

/**
 *  当textView的文字改变就会调用
 */
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.text.length != 0;
}

#pragma mark - NBComposeToolbarDelegate
/**
 *  监听toolbar内部按钮的点击
 */
- (void)composeTool:(NBComposeToolbar *)toolbar didClickedButton:(NBComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case NBComposeToolbarButtonTypeCamera: // 照相机
            [self openCamera];
            break;
            
        case NBComposeToolbarButtonTypePicture: // 相册
            [self openAlbum];
            break;
            
        case NBComposeToolbarButtonTypeEmotion: // 表情
            [self openEmotion];
            break;
            
        default:
            break;
    }
}

/**
 *  打开照相机
 */
- (void)openCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openAlbum
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开表情
 */
- (void)openEmotion
{
    // 正在切换键盘
    self.changingKeyboard = YES;
    
    if (self.textView.inputView) { // 当前显示的是自定义键盘，切换为系统自带的键盘
        self.textView.inputView = nil;
        
        // 显示表情图片
        self.toolbar.showEmotionButton = YES;
    } else { // 当前显示的是系统自带的键盘，切换为自定义键盘
        // 如果临时更换了文本框的键盘，一定要重新打开键盘
        self.textView.inputView = self.kerboard;
        
        // 不显示表情图片
        self.toolbar.showEmotionButton = NO;
    }
    
    // 关闭键盘
    [self.textView resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 打开键盘
        [self.textView becomeFirstResponder];
    });

}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 1.取出选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 2.添加图片到相册中
    [self.photosView addImage:image];
}

@end
