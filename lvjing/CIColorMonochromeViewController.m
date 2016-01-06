//
//  CIColorMonochromeViewController.m
//  lvjing
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CIColorMonochromeViewController.h"

@interface CIColorMonochromeViewController ()
{
     CIColor * center1;
     NSNumber * center2;
     CIFilter *transFilter;
     CIImage *coreImage;
}
@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UISlider *slider2;
@property (weak, nonatomic) IBOutlet UISlider *slider3;
@property (weak, nonatomic) IBOutlet UISlider *slider4;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) CIContext *context;

@end

@implementation CIColorMonochromeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    center1 = [CIColor colorWithCGColor:[UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:1.0].CGColor];
       self.slider1.value = center1.red;
    self.slider2.value = center1.green;
    self.slider3.value = center1.blue;
    _label1.text = [NSString stringWithFormat:@"%.2f",self.slider1.value];
    _label2.text = [NSString stringWithFormat:@"%.2f",self.slider2.value];
    _label3.text = [NSString stringWithFormat:@"%.2f",self.slider3.value];
    
    center2 = [NSNumber numberWithFloat:0];
    self.slider4.value = center2.charValue;
    _label4.text = [NSString stringWithFormat:@"%.2f",self.slider4.value];
    
    CGImageRef cgImg = _imageView.image.CGImage;
    coreImage = [CIImage imageWithCGImage:cgImg];
    transFilter = [CIFilter filterWithName:@"CIColorMonochrome"];
    
    [self transImageWithCIImage];
}

- (UIImage *)transImageWithCIImage
{
    [transFilter setValue:coreImage forKey:kCIInputImageKey];
    [transFilter setValue:center1 forKey:@"inputColor"];
    [transFilter setValue:center2 forKey:@"inputIntensity"];
    NSLog(@"center1 -- %@",center1);
    NSLog(@"center2 -- %@",center2);
    CIImage *output = transFilter.outputImage;
    
    self.context = [CIContext contextWithOptions: nil];
    CGImageRef cgimg = [self.context createCGImage:output fromRect:[output extent]];
    UIImage *uiimage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    _imageView.image = uiimage;
    return uiimage;
}

- (void)changeCenterValue:(CGFloat )value type:(CIColorMonochromeViewControllerType)type{
    CGFloat one = self.slider1.value;
    CGFloat two = self.slider2.value;
    CGFloat three = self.slider3.value;
    if (type == CIColorMonochromeViewControllerTypeRed) {
        one = value;
    }
    if (type == CIColorMonochromeViewControllerTypeGreen) {
        two = value;
    }
    if (type == CIColorMonochromeViewControllerTypeBlue) {
        three = value;
    }
    _label1.text = [NSString stringWithFormat:@"%.2f",self.slider1.value];
    _label2.text = [NSString stringWithFormat:@"%.2f",self.slider2.value];
    _label3.text = [NSString stringWithFormat:@"%.2f",self.slider3.value];
    center1 = [CIColor colorWithCGColor:[UIColor colorWithRed:one green:two blue:three alpha:1.0].CGColor];
    [self transImageWithCIImage];
    
}

- (void)changecenter2Value:(CGFloat )value{
    CGFloat four = self.slider4.value;
    four = value;
    _label4.text = [NSString stringWithFormat:@"%.2f",self.slider4.value];
    center2 = [NSNumber numberWithFloat:four];
    [self transImageWithCIImage];

}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)slider1:(UISlider *)sender {
     [self changeCenterValue:sender.value type:CIColorMonochromeViewControllerTypeRed];
}
- (IBAction)slider2:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMonochromeViewControllerTypeGreen];
}

- (IBAction)slider3:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMonochromeViewControllerTypeBlue];

}

- (IBAction)slider4:(UISlider *)sender {
    [self changecenter2Value:sender.value];
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
