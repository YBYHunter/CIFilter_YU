//
//  CIWhitePointAdjustViewController.m
//  lvjing
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//
 //白平衡调节
#import "CIWhitePointAdjustViewController.h"
@interface CIWhitePointAdjustViewController (){
    
        CIColor * center1;
        CIFilter *transFilter;
        CIImage *coreImage;
    
}

@property (strong, nonatomic) CIContext *context;
@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UISlider *slider3;
@property (weak, nonatomic) IBOutlet UISlider *slider5;
@property (weak, nonatomic) IBOutlet UILabel *jindu1;
@property (weak, nonatomic) IBOutlet UILabel *jindu3;
@property (weak, nonatomic) IBOutlet UILabel *jindu5;

@end

@implementation CIWhitePointAdjustViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aaaaa) name:CleartransFilter object:nil];

    center1 = [CIColor colorWithCGColor:[UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:1.0].CGColor];
    
    self.slider1.value = center1.red;
    self.slider3.value = center1.green;
    self.slider5.value = center1.blue;

    
    _jindu1.text = [NSString stringWithFormat:@"%.2f",self.slider1.value/self.slider1.maximumValue];
    _jindu3.text = [NSString stringWithFormat:@"%.2f",self.slider3.value/self.slider3.maximumValue];
    _jindu5.text = [NSString stringWithFormat:@"%.2f",self.slider5.value/self.slider5.maximumValue];
    
    CGImageRef cgImg = self.fimageView.image.CGImage;
    coreImage = [CIImage imageWithCGImage:cgImg];
    transFilter = [CIFilter filterWithName:@"CIWhitePointAdjust"];
    
    [self transImageWithCIImage];

}

- (void)aaaaa
{
    transFilter = nil;
}

- (UIImage *)transImageWithCIImage
{
    [transFilter setValue:coreImage forKey:kCIInputImageKey];
    [transFilter setValue:center1 forKey:@"inputColor"];
    NSLog(@"center1 -- %@",center1);
    CIImage *output = transFilter.outputImage;
    
    self.context = [CIContext contextWithOptions: nil];
    CGImageRef cgimg = [self.context createCGImage:output fromRect:[output extent]];
    UIImage *uiimage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    self.fimageView.image = uiimage;
    return uiimage;
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)changeCenterValue:(CGFloat )value type:(CIWhitePointAdjustViewControllerType)type selectMin:(BOOL)min{
        CGFloat one = self.slider1.value;
        CGFloat three = self.slider3.value;
        CGFloat five = self.slider5.value;
        if (type == CIWhitePointAdjustViewControllerTypeRed) {
            one = value;
        }
        if (type == CIWhitePointAdjustViewControllerTypeGreen) {
            three = value;
        }
        if (type == CIWhitePointAdjustViewControllerTypeBlue) {
            five = value;
        }
        _jindu1.text = [NSString stringWithFormat:@"%.2f",self.slider1.value/self.slider1.maximumValue];
        _jindu3.text = [NSString stringWithFormat:@"%.2f",self.slider3.value/self.slider3.maximumValue];
        _jindu5.text = [NSString stringWithFormat:@"%.2f",self.slider5.value/self.slider5.maximumValue];
    center1 = [CIColor colorWithCGColor:[UIColor colorWithRed:one green:three blue:five alpha:1.0].CGColor];
    [self transImageWithCIImage];
    
}


- (IBAction)slider1:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIWhitePointAdjustViewControllerTypeRed selectMin:YES];
}

- (IBAction)slider3:(UISlider *)sender {
   [self changeCenterValue:sender.value type:CIWhitePointAdjustViewControllerTypeGreen selectMin:YES];
}

- (IBAction)slider5:(UISlider *)sender {
   [self changeCenterValue:sender.value type:CIWhitePointAdjustViewControllerTypeBlue selectMin:YES];
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
