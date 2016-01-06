//
//  CIColorMapViewController.m
//  lvjing
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CIColorMapViewController.h"

@interface CIColorMapViewController ()
{
    CIImage *center;
    CIFilter *transFilter;
}
@property (strong, nonatomic) CIContext *context;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CIColorMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"还没完成" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
- (UIImage *)transImageWithCIImage
{
    CGImageRef cgImg = _imageView.image.CGImage;
    CIImage *coreImage = [CIImage imageWithCGImage:cgImg];
    transFilter = [CIFilter filterWithName:@"CIColorMap"];
    [transFilter setValue:coreImage forKey:kCIInputImageKey];
    
    CIImage *output = transFilter.outputImage;
    
    self.context = [CIContext contextWithOptions: nil];
    CGImageRef cgimg = [self.context createCGImage:output fromRect:[output extent]];
    UIImage *uiimage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    _imageView.image = uiimage;
    return uiimage;
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
