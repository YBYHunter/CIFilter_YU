//
//  CIFalseColorViewController.m
//  lvjing
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CIFalseColorViewController.h"

@interface CIFalseColorViewController ()
{
    
    CIColor * center1;
    CIColor * center2;
    CIFilter *transFilter;
    CIImage *coreImage;
    
}
@property (strong, nonatomic) CIContext *context;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UISlider *slider2;
@property (weak, nonatomic) IBOutlet UISlider *slider3;
@property (weak, nonatomic) IBOutlet UISlider *slider4;
@property (weak, nonatomic) IBOutlet UISlider *slider5;
@property (weak, nonatomic) IBOutlet UISlider *slider6;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;

@end

@implementation CIFalseColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    center1 = [CIColor colorWithCGColor:[UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:1.0].CGColor];
    center2 = [CIColor colorWithCGColor:[UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:1.0].CGColor];
    self.slider1.value = center1.red;
    self.slider2.value = center1.green;
    self.slider3.value = center1.blue;
    
    self.slider4.value = center2.red;
    self.slider5.value = center2.green;
    self.slider6.value = center2.blue;
    
    
    _label1.text = [NSString stringWithFormat:@"%.2f",self.slider1.value];
    _label2.text = [NSString stringWithFormat:@"%.2f",self.slider2.value];
    _label3.text = [NSString stringWithFormat:@"%.2f",self.slider3.value];
    
    _label4.text = [NSString stringWithFormat:@"%.2f",self.slider4.value];
    _label5.text = [NSString stringWithFormat:@"%.2f",self.slider5.value];
    _label6.text = [NSString stringWithFormat:@"%.2f",self.slider6.value];
    
    CGImageRef cgImg = _imageView.image.CGImage;
    coreImage = [CIImage imageWithCGImage:cgImg];
    transFilter = [CIFilter filterWithName:@"CIFalseColor"];
    
    [self transImageWithCIImage];
}

- (UIImage *)transImageWithCIImage
{
    [transFilter setValue:coreImage forKey:kCIInputImageKey];
    [transFilter setValue:center1 forKey:@"inputColor0"];
    [transFilter setValue:center2 forKey:@"inputColor1"];
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

- (void)changeCenterValue:(CGFloat )value type:(CIFalseColorViewControllerType)type selectCenter:(id)center{
    CGFloat one = self.slider1.value;
    CGFloat two = self.slider2.value;
    CGFloat three = self.slider3.value;
    CGFloat four = self.slider4.value;
    CGFloat five = self.slider5.value;
    CGFloat six = self.slider6.value;
    if (center == center1) {
        if (type == CIFalseColorViewControllerTypeRed) {
               one = value;
        }
        if (type == CIFalseColorViewControllerTypeGreen) {
               two = value;
        }
        if (type == CIFalseColorViewControllerTypeBlue) {
               three = value;
        }
    _label1.text = [NSString stringWithFormat:@"%.2f",self.slider1.value];
    _label2.text = [NSString stringWithFormat:@"%.2f",self.slider2.value];
    _label3.text = [NSString stringWithFormat:@"%.2f",self.slider3.value];
        
    center1 = [CIColor colorWithCGColor:[UIColor colorWithRed:one green:two blue:three alpha:1.0].CGColor];
    }
    if (center == center2) {
        if (type == CIFalseColorViewControllerTypeRed) {
            four = value;
        }
        if (type == CIFalseColorViewControllerTypeGreen) {
            five = value;
        }
        if (type == CIFalseColorViewControllerTypeBlue) {
            six = value;
        }
    _label4.text = [NSString stringWithFormat:@"%.2f",self.slider4.value];
    _label5.text = [NSString stringWithFormat:@"%.2f",self.slider5.value];
    _label6.text = [NSString stringWithFormat:@"%.2f",self.slider6.value];
        
    center2 = [CIColor colorWithCGColor:[UIColor colorWithRed:four green:five blue:six alpha:1.0].CGColor];
        
       }
    [self transImageWithCIImage];
    
}


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)slider1:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIFalseColorViewControllerTypeRed selectCenter:center1];
}
- (IBAction)slider2:(UISlider *)sender {
      [self changeCenterValue:sender.value type:CIFalseColorViewControllerTypeGreen selectCenter:center1];
}
- (IBAction)slider3:(UISlider *)sender {
      [self changeCenterValue:sender.value type:CIFalseColorViewControllerTypeBlue selectCenter:center1];
}
- (IBAction)slider4:(UISlider *)sender {
      [self changeCenterValue:sender.value type:CIFalseColorViewControllerTypeRed selectCenter:center2];
}
- (IBAction)slider5:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIFalseColorViewControllerTypeGreen selectCenter:center2];
}

- (IBAction)slider6:(UISlider *)sender {
      [self changeCenterValue:sender.value type:CIFalseColorViewControllerTypeBlue selectCenter:center2];
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
