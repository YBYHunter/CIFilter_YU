//
//  BViewController.m
//  lvjing
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BViewController.h"

#define CleartransFilter  @"CleartransFilter"

@interface BViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIImageView *baseImageView;
@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 40)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    //（长按手势）
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(setlongPress:)];
                    //设置了滤镜图可交互
    self.fimageView.userInteractionEnabled = YES;
    longPress.minimumPressDuration = 0.2;
    [self.fimageView addGestureRecognizer:longPress];
    
    //长按变原图
    _baseImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [_baseImageView setImage:[UIImage imageNamed:@"xxxx.jpg"]];

    if (self.view.subviews.count > 0) {

        [self.view insertSubview:self.fimageView belowSubview:[self.view.subviews objectAtIndex:0]];

        [self.view insertSubview:_baseImageView belowSubview:[self.view.subviews objectAtIndex:0]];
    }
    
    [self setPicBtn];

}
#pragma marks - 设置相机
- (void)setPicBtn{
    UIButton *picBtn = [[UIButton alloc]initWithFrame:CGRectMake(300, 24, 80, 40)];
    picBtn.backgroundColor = [UIColor whiteColor];
    [picBtn setTitle:@"选择图片" forState:UIControlStateNormal];
    [picBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [picBtn addTarget:self action:@selector(selectPic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:picBtn];
}

- (void)selectPic:(id)sender{
    
    UIActionSheet *sheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        
    }
    
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
        
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        // 跳转到相机或相册页面
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
//        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    // 保存图片至本地，方法见下文
    [self saveImage:image withName:@"save"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"save"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    //    isFullScreen = NO;
    [self.fimageView setImage:savedImage];
    
    self.fimageView.tag = 100;
    self.fimageView.image = image;
    
    [_baseImageView setImage:savedImage];
    self.baseImageView.image = image;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CleartransFilter object:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    //    isFullScreen = !isFullScreen;
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self.view];
    
    CGPoint imagePoint = self.fimageView.frame.origin;
    //touchPoint.x ，touchPoint.y 就是触点的坐标
    
    // 触点在imageView内，点击imageView时 放大,再次点击时缩小
    if(imagePoint.x <= touchPoint.x && imagePoint.x +self.fimageView.frame.size.width >=touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.fimageView.frame.size.height >= touchPoint.y)
    {
        // 设置图片放大动画
        [UIView beginAnimations:nil context:nil];
        // 动画时间
        [UIView setAnimationDuration:1];
        
        //      if (isFullScreen) {
        //            // 放大尺寸
        //
        //            self.fimageView.frame = CGRectMake(0, 0, 320, 480);
        //        }
        //        else {
        //            // 缩小尺寸
        //            self.fimageView.frame = CGRectMake(50, 65, 90, 115);
                }
        
        // commit动画
        [UIView commitAnimations];
        
    //}
    
}

//ASIFormDataRequest *requestReport  = [[ASIFormDataRequest alloc] initWithURL:url];

//NSString *Path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
//
//[requestReport setFile:Path forKey:@"picturepath"];
//
//[requestReport buildPostBody];
//
//requestReport.delegate = self;
//
//[requestReport startAsynchronous];

- (void)setlongPress:(UITapGestureRecognizer *)longpress
{
    if (longpress.state == UIGestureRecognizerStateBegan) {
        
        self.fimageView.hidden = YES;
        
    }
    else if (longpress.state == UIGestureRecognizerStateEnded) {

        self.fimageView.hidden = NO;
    }
}

//滤镜图
- (UIImageView *)fimageView
{
    if (_fimageView == nil) {
        _fimageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _fimageView.image = [UIImage imageNamed:@"xxxx.jpg"];

     //不被拉伸
      // _fimageView.contentMode = UIViewContentModeScaleToFill;
        /*
         UIViewContentModeScaleToFill,
         UIViewContentModeScaleAspectFit,  // contents scaled to fit with fixed aspect. remainder is transparent
         UIViewContentModeScaleAspectFill, //裁剪去多余的边边，，为了比例与原图对应
         UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
         UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
         UIViewContentModeTop,
         UIViewContentModeBottom,
         UIViewContentModeLeft,
         UIViewContentModeRight,
         UIViewContentModeTopLeft,
         UIViewContentModeTopRight,
         UIViewContentModeBottomLeft,
         UIViewContentModeBottomRight,
         */
    }
    return _fimageView;
}

#pragma mark - 返回
- (void)popAction{

    if (self.navigationController.viewControllers == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
