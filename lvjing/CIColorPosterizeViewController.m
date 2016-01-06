//
//  CIColorPosterizeViewController.m
//  lvjing
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CIColorPosterizeViewController.h"

@interface CIColorPosterizeViewController ()
{
    CIFilter *transFilter;
    NSNumber * center;
    CIImage *coreImage;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) CIContext *context;
@property (weak, nonatomic) IBOutlet UILabel *jindu;

@end

@implementation CIColorPosterizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    center = [NSNumber numberWithFloat:6.0];
    self.slider.value = center.charValue;
    CGImageRef cgImg = self.imageView.image.CGImage;
    coreImage = [CIImage imageWithCGImage:cgImg];
    transFilter = [CIFilter filterWithName:@"CIColorPosterize"];
    [self transImageWithCIImage];
}

- (UIImage *)transImageWithCIImage
{
    [transFilter setValue:coreImage forKey:kCIInputImageKey];
    [transFilter setValue:center forKey:@"inputLevels"];
    CIImage *output = transFilter.outputImage;
    
    self.context = [CIContext contextWithOptions: nil];
    CGImageRef cgimg = [self.context createCGImage:output fromRect:[output extent]];
    UIImage *uiimage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    _imageView.image = uiimage;
    return uiimage;
}

- (void)changeCenterValue:(CGFloat )value{
    CGFloat one = self.slider.value;
    one = value;
    _jindu.text = [NSString stringWithFormat:@"%.2f",self.slider.value];
    center = [NSNumber numberWithFloat:one];
    [self transImageWithCIImage];
}

- (IBAction)slider:(UISlider *)sender {
    [self changeCenterValue:sender.value];

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
