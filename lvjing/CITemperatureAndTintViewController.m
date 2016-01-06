
//  CITemperatureAndTintViewController.m
//  lvjing
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//
//色温
#import "CITemperatureAndTintViewController.h"

@interface CITemperatureAndTintViewController (){
    CIVector * center1;
    CIVector * center2;
    CIFilter *transFilter;
    CIImage *coreImage;
}
@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UISlider *slider2;
@property (weak, nonatomic) IBOutlet UISlider *slider3;
@property (weak, nonatomic) IBOutlet UISlider *slider4;

@property (strong, nonatomic) CIContext *context;
@property (weak, nonatomic) IBOutlet UILabel *jindu1;
@property (weak, nonatomic) IBOutlet UILabel *jindu2;
@property (weak, nonatomic) IBOutlet UILabel *jindu3;

@property (weak, nonatomic) IBOutlet UILabel *jindu4;

@end

@implementation CITemperatureAndTintViewController

- (void)viewDidLoad {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aaaaa) name:CleartransFilter object:nil];
    
    center1 = [CIVector vectorWithX:6500 Y:0 ];
    center2 = [CIVector vectorWithX:6500 Y:0 ];
    self.slider1.value = center1.X;
    self.slider2.value = center1.Y;
  
  
    [self transImageWithCIImage];
    [super viewDidLoad];
    
}

- (void)aaaaa
{
    transFilter = nil;
}

- (IBAction)slider1:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CITemperatureAndTintViewControllerTypeinputNeutral selectMin:YES];
}
- (IBAction)slider2:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CITemperatureAndTintViewControllerTypeinputNeutral selectMin:NO];
}
- (IBAction)slider3:(UISlider *)sender {
     [self changeCenterValue:sender.value type:CITemperatureAndTintViewControllerTypeinputTargetNeutral selectMin:YES];
}
- (IBAction)slider4:(UISlider *)sender {
     [self changeCenterValue:sender.value type:CITemperatureAndTintViewControllerTypeinputTargetNeutral selectMin:NO];
}

- (void)transImageWithCIImage{

    if (transFilter == nil) {
        CGImageRef cgImg = self.fimageView.image.CGImage;
        coreImage = [CIImage imageWithCGImage:cgImg];
        transFilter = [CIFilter filterWithName:@"CITemperatureAndTint"];
    }
    
    [transFilter setValue:coreImage forKey:kCIInputImageKey];
    [transFilter setValue:center1 forKey:@"inputNeutral"];
    [transFilter setValue:center2 forKey:@"inputTargetNeutral"];
    NSLog(@"center1 -- %@",center1);
    NSLog(@"center2 -- %@",center2);
    CIImage *output = transFilter.outputImage;
    
    self.context = [CIContext contextWithOptions: nil];
    CGImageRef cgimg = [self.context createCGImage:output fromRect:[output extent]];
    UIImage *uiimage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    
    self.fimageView.image = uiimage;
}

- (void)changeCenterValue:(CGFloat )value type:(CITemperatureAndTintViewControllerType)type selectMin:(BOOL)min{
    if (min) {
        CGFloat one = _slider1.value;
        CGFloat three = _slider3.value;
        if (type == CITemperatureAndTintViewControllerTypeinputNeutral) {
            one = value;
        }
        else if (type == CITemperatureAndTintViewControllerTypeinputTargetNeutral){
            three = value;
        }
        _jindu1.text = [NSString stringWithFormat:@"%.2f",self.slider1.value];
        _jindu3.text = [NSString stringWithFormat:@"%.2f",self.slider3.value];
        center1 = [CIVector vectorWithX:one Y:three];

    }
    else{
         CGFloat two = self.slider2.value;
         CGFloat four = self.slider4.value;
        if (type == CITemperatureAndTintViewControllerTypeinputNeutral) {
            two = value;
        }
        else if (type == CITemperatureAndTintViewControllerTypeinputTargetNeutral){
            four = value;
        }
    
    _jindu2.text = [NSString stringWithFormat:@"%.2f",self.slider2.value];
    _jindu4.text = [NSString stringWithFormat:@"%.2f",self.slider4.value];
    center2 = [CIVector vectorWithX:two Y:four];
    }
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
