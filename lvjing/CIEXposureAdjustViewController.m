//
//  CIEXposureAdjustViewController.m
//  lvjing
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CIEXposureAdjustViewController.h"

@interface CIEXposureAdjustViewController ()
{
    CIFilter *transFilter;
    NSNumber * center;
    CIImage *coreImage;
}
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) CIContext *context;
@property (weak, nonatomic) IBOutlet UILabel *jindu;

@end

@implementation CIEXposureAdjustViewController

- (void)viewDidLoad {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aaaaa) name:CleartransFilter object:nil];
    
    
    [super viewDidLoad];
    center = [NSNumber numberWithFloat:0];
    self.slider.value = center.charValue;
    _jindu.text = [NSString stringWithFormat:@"%.2f",self.slider.value];
   
    [self transImageWithCIImage];
}

- (void)aaaaa
{
    transFilter = nil;
}

- (UIImage *)transImageWithCIImage
{
    if (transFilter == nil) {
    CGImageRef cgImg = self.fimageView.image.CGImage;
    coreImage = [CIImage imageWithCGImage:cgImg];
    transFilter = [CIFilter filterWithName:@"CIExposureAdjust"];
}
    [transFilter setValue:coreImage forKey:kCIInputImageKey];
    [transFilter setValue:center forKey:@"inputEV"];
    CIImage *output = transFilter.outputImage;
    
    self.context = [CIContext contextWithOptions: nil];
    CGImageRef cgimg = [self.context createCGImage:output fromRect:[output extent]];
    UIImage *uiimage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    self.fimageView.image = uiimage;
    return uiimage;
}

- (IBAction)slider:(UISlider *)sender {
    [self changeCenterValue:sender.value];
}

- (void)changeCenterValue:(CGFloat )value{
    CGFloat one = self.slider.value;
    one = value;
    _jindu.text = [NSString stringWithFormat:@"%.2f",(self.slider.value/self.slider.maximumValue)];
    center = [NSNumber numberWithFloat:one];
    [self transImageWithCIImage];
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
