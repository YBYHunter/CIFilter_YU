//
//  CISRGBToneCurveToLinentViewController.m
//  lvjing
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CISRGBToneCurveToLinentViewController.h"

@interface CISRGBToneCurveToLinentViewController (){
    CIFilter *transFilter;
}
@property (strong, nonatomic) CIContext *context;

@end

@implementation CISRGBToneCurveToLinentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aaaaa) name:CleartransFilter object:nil];
    
    [self transImageWithCIImage];
}

- (void)aaaaa
{
    transFilter = nil;
}

- (UIImage *)transImageWithCIImage
{
    CGImageRef cgImg = self.fimageView.image.CGImage;
    CIImage *coreImage = [CIImage imageWithCGImage:cgImg];
    transFilter = [CIFilter filterWithName:@"CISRGBToneCurveToLinear"];
    [transFilter setValue:coreImage forKey:kCIInputImageKey];
    CIImage *output = transFilter.outputImage;
    
    self.context = [CIContext contextWithOptions: nil];
    CGImageRef cgimg = [self.context createCGImage:output fromRect:[output extent]];
    UIImage *uiimage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    self.fimageView.image = uiimage;
    return uiimage;
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
