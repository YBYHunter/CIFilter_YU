//
//  CIColorControlsViewController.m
//  lvjing
//
//  Created by apple on 15/12/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CIColorControlsViewController.h"
#import "WsliderView.h"
//#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
//#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)
@interface CIColorControlsViewController ()<WSliderDelegate>
{
    NSNumber * center1;
    NSNumber * center2;
    NSNumber * center3;
    CIFilter *transFilter;
    CIImage *coreImage;
   
}
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UISlider *slider2;
@property (strong, nonatomic) CIContext *context;
@property (weak, nonatomic) IBOutlet UILabel *jindu1;
@property (weak, nonatomic) IBOutlet UILabel *jindu2;
@property (weak, nonatomic) IBOutlet UILabel *jindu3;

@end

@implementation CIColorControlsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aaaaa) name:CleartransFilter object:nil];
    
    center1 = [NSNumber numberWithFloat:1];
    center2 = [NSNumber numberWithFloat:0];
    center3 = [NSNumber numberWithFloat:1];
    self.slider.value = center1.charValue;
    self.slider1.value = center2.charValue;
    self.slider2.value = center3.charValue;
   
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
        transFilter = [CIFilter filterWithName:@"CIColorControls"];
    }
    
    [transFilter setValue:coreImage forKey:kCIInputImageKey];
    [transFilter setValue:center1 forKey:@"inputSaturation"];
    [transFilter setValue:center2 forKey:@"inputBrightness"];
    [transFilter setValue:center3 forKey:@"inputContrast"];
    
    CIImage *output = transFilter.outputImage;
    
    self.context = [CIContext contextWithOptions: nil];
    CGImageRef cgimg = [self.context createCGImage:output fromRect:[output extent]];
    UIImage *uiimage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    self.fimageView.image = uiimage;
    return uiimage;
}


- (IBAction)slider:(UISlider *)sender {
    
    [self changeCenterValue:sender.value type:CIColorControlsViewControllerTypeinputSaturation];

}

- (IBAction)slider1:(UISlider *)sender {
     [self changeCenterValue:sender.value type:CIColorControlsViewControllerinputBrightness];
}

- (IBAction)slider2:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorControlsViewControllerinputContrast];
}



- (void)changeCenterValue:(CGFloat )value type:(CIColorControlsViewControllerType)type{
    CGFloat one = self.slider.value;
    CGFloat two = self.slider1.value;
    CGFloat three = self.slider2.value;

    if (type == CIColorControlsViewControllerTypeinputSaturation){
        one = value;
    }
    else if (type == CIColorControlsViewControllerinputBrightness){
        two = value;
    }
    else if (type == CIColorControlsViewControllerinputContrast){
        three = value;
    }
    
    _jindu1.text = [NSString stringWithFormat:@"%.2f",(self.slider.value/self.slider.maximumValue)];
    _jindu2.text = [NSString stringWithFormat:@"%.2f",(self.slider1.value/self.slider1.maximumValue)];
    _jindu3.text = [NSString stringWithFormat:@"%.2f",(self.slider2.value/self.slider2.maximumValue)];
    center1 = [NSNumber numberWithFloat:one];
    center2 = [NSNumber numberWithFloat:two];
    center3 = [NSNumber numberWithFloat:three];

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
