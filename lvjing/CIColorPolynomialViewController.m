//
//  CIColorPolynomialViewController.m
//  lvjing
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CIColorPolynomialViewController.h"

@interface CIColorPolynomialViewController (){
    CIVector * center1;
    CIVector * center2;
    CIVector * center3;
    CIVector * center4;
    CIFilter *transFilter;
    CIImage *coreImage;
}
@property (strong, nonatomic) CIContext *context;

@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UISlider *slider2;
@property (weak, nonatomic) IBOutlet UISlider *slider3;
@property (weak, nonatomic) IBOutlet UISlider *slider4;
@property (weak, nonatomic) IBOutlet UISlider *slider5;
@property (weak, nonatomic) IBOutlet UISlider *slider6;
@property (weak, nonatomic) IBOutlet UISlider *slider7;
@property (weak, nonatomic) IBOutlet UISlider *slider8;
@property (weak, nonatomic) IBOutlet UISlider *slider9;
@property (weak, nonatomic) IBOutlet UISlider *slider10;
@property (weak, nonatomic) IBOutlet UISlider *slider11;
@property (weak, nonatomic) IBOutlet UISlider *slider12;
@property (weak, nonatomic) IBOutlet UISlider *slider13;
@property (weak, nonatomic) IBOutlet UISlider *slider14;
@property (weak, nonatomic) IBOutlet UISlider *slider15;
@property (weak, nonatomic) IBOutlet UISlider *slider16;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;
@property (weak, nonatomic) IBOutlet UILabel *label9;
@property (weak, nonatomic) IBOutlet UILabel *label10;
@property (weak, nonatomic) IBOutlet UILabel *label11;
@property (weak, nonatomic) IBOutlet UILabel *label12;
@property (weak, nonatomic) IBOutlet UILabel *label13;
@property (weak, nonatomic) IBOutlet UILabel *label14;
@property (weak, nonatomic) IBOutlet UILabel *label15;
@property (weak, nonatomic) IBOutlet UILabel *label16;


@end

@implementation CIColorPolynomialViewController

- (void)viewDidLoad {
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aaaaa) name:CleartransFilter object:nil];
    
    [super viewDidLoad];
    center1 = [CIVector vectorWithX:0 Y:1 Z:0 W:0];
    center2 = [CIVector vectorWithX:0 Y:1 Z:0 W:0];
    center3 = [CIVector vectorWithX:0 Y:1 Z:0 W:0];
    center4 = [CIVector vectorWithX:0 Y:1 Z:0 W:0];
    
    self.slider1.value = center1.X;
    self.slider9.value = center1.Y;
    self.slider2.value = center1.Z;
    self.slider10.value = center1.W;
    
    self.slider3.value = center2.X;
    self.slider11.value = center2.Y;
    self.slider4.value = center2.Z;
    self.slider12.value = center2.W;
    
    self.slider5.value = center3.X;
    self.slider13.value = center3.Y;
    self.slider6.value = center3.Z;
    self.slider14.value = center3.W;
    
    self.slider7.value = center4.X;
    self.slider15.value = center4.Y;
    self.slider8.value = center4.Z;
    self.slider16.value = center4.W;
    
    _label1.text = [NSString stringWithFormat:@"%.2f",self.slider1.value];
    _label2.text = [NSString stringWithFormat:@"%.2f",self.slider2.value];
    _label3.text = [NSString stringWithFormat:@"%.2f",self.slider3.value];
    _label4.text = [NSString stringWithFormat:@"%.2f",self.slider4.value];
    _label5.text = [NSString stringWithFormat:@"%.2f",self.slider5.value];
    _label6.text = [NSString stringWithFormat:@"%.2f",self.slider6.value];
    _label7.text = [NSString stringWithFormat:@"%.2f",self.slider7.value];
    _label8.text = [NSString stringWithFormat:@"%.2f",self.slider8.value];
    _label9.text = [NSString stringWithFormat:@"%.2f",self.slider9.value];
    _label10.text = [NSString stringWithFormat:@"%.2f",self.slider10.value];
    _label11.text = [NSString stringWithFormat:@"%.2f",self.slider11.value];
    _label12.text = [NSString stringWithFormat:@"%.2f",self.slider12.value];
    _label13.text = [NSString stringWithFormat:@"%.2f",self.slider13.value];
    _label14.text = [NSString stringWithFormat:@"%.2f",self.slider14.value];
    _label15.text = [NSString stringWithFormat:@"%.2f",self.slider15.value];
    _label16.text = [NSString stringWithFormat:@"%.2f",self.slider16.value];
    
    [self transImageWithCIImage];
    
}

- (void)aaaaa
{
    transFilter = nil;
}

- (void)transImageWithCIImage
{
    if (transFilter == nil) {
        CGImageRef cgImg = self.fimageView.image.CGImage;
        coreImage = [CIImage imageWithCGImage:cgImg];
        transFilter = [CIFilter filterWithName:@"CIColorPolynomial"];
    }

    
    [transFilter setValue:coreImage forKey:kCIInputImageKey];

    [transFilter setValue:center1 forKey:@"inputRedCoefficients"];
    [transFilter setValue:center2 forKey:@"inputGreenCoefficients"];
    [transFilter setValue:center3 forKey:@"inputBlueCoefficients"];
    [transFilter setValue:center4 forKey:@"inputAlphaCoefficients"];
    
    CIImage *output = transFilter.outputImage;
    
    self.context = [CIContext contextWithOptions: nil];
    CGImageRef cgimg = [self.context createCGImage:output fromRect:[output extent]];
    UIImage *uiimage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    self.fimageView.image = uiimage;

    }

- (void)changeCenterValue:(CGFloat )value type:(CIColorPolynomialViewControllerType)type selectCenter:(id)center{
    if (center == center1) {
        CGFloat x1 = self.slider1.value;
        CGFloat y1 = self.slider9.value;
        CGFloat z1 = self.slider2.value;
        CGFloat w1 = self.slider10.value;
        if (type == CIColorPolynomialViewControllerTypeX) {
            x1 = value;
        }
        else if (type == CIColorPolynomialViewControllerTypey){
            y1 = value;
        }
        else if (type == CIColorPolynomialViewControllerTypeZ){
            z1 = value;
        }
        else if (type == CIColorPolynomialViewControllerTypeW){
            w1 = value;
        }
        _label1.text = [NSString stringWithFormat:@"%.2f",self.slider1.value];
        _label9.text = [NSString stringWithFormat:@"%.2f",self.slider9.value];
        _label2.text = [NSString stringWithFormat:@"%.2f",self.slider2.value];
        _label10.text = [NSString stringWithFormat:@"%.2f",self.slider10.value];
        center1 = [CIVector vectorWithX:x1 Y:y1 Z:z1 W:w1];
    }
    if (center == center2) {
        CGFloat x2 = self.slider3.value;
        CGFloat y2 = self.slider11.value;
        CGFloat z2 = self.slider4.value;
        CGFloat w2 = self.slider12.value;
        if (type == CIColorPolynomialViewControllerTypeX) {
            x2 = value;
        }
        else if (type == CIColorPolynomialViewControllerTypey){
            y2 = value;
        }
        else if (type == CIColorPolynomialViewControllerTypeZ){
            z2 = value;
        }
        else if (type == CIColorPolynomialViewControllerTypeW){
            w2 = value;
        }
        _label3.text = [NSString stringWithFormat:@"%.2f",self.slider3.value];
        _label11.text = [NSString stringWithFormat:@"%.2f",self.slider11.value];
        _label4.text = [NSString stringWithFormat:@"%.2f",self.slider4.value];
        _label12.text = [NSString stringWithFormat:@"%.2f",self.slider12.value];
        center2 = [CIVector vectorWithX:x2 Y:y2 Z:z2 W:w2];
    }
    if (center == center3) {
        CGFloat x3 = self.slider5.value;
        CGFloat y3 = self.slider13.value;
        CGFloat z3 = self.slider6.value;
        CGFloat w3 = self.slider14.value;
        if (type == CIColorPolynomialViewControllerTypeX) {
            x3 = value;
        }
        else if (type == CIColorPolynomialViewControllerTypey){
            y3 = value;
        }
        else if (type == CIColorPolynomialViewControllerTypeZ){
            z3 = value;
        }
        else if (type == CIColorPolynomialViewControllerTypeW){
            w3 = value;
        }
        _label1.text = [NSString stringWithFormat:@"%.2f",self.slider5.value];
        _label9.text = [NSString stringWithFormat:@"%.2f",self.slider13.value];
        _label2.text = [NSString stringWithFormat:@"%.2f",self.slider6.value];
        _label10.text = [NSString stringWithFormat:@"%.2f",self.slider14.value];
        center1 = [CIVector vectorWithX:x3 Y:y3 Z:z3 W:w3];
    }
    if (center == center4) {
        CGFloat x4 = self.slider7.value;
        CGFloat y4 = self.slider15.value;
        CGFloat z4 = self.slider8.value;
        CGFloat w4 = self.slider16.value;
        if (type == CIColorPolynomialViewControllerTypeX) {
            x4 = value;
        }
        else if (type == CIColorPolynomialViewControllerTypey){
            y4 = value;
        }
        else if (type == CIColorPolynomialViewControllerTypeZ){
            z4 = value;
        }
        else if (type == CIColorPolynomialViewControllerTypeW){
            w4 = value;
        }
        _label7.text = [NSString stringWithFormat:@"%.2f",self.slider7.value];
        _label15.text = [NSString stringWithFormat:@"%.2f",self.slider15.value];
        _label8.text = [NSString stringWithFormat:@"%.2f",self.slider8.value];
        _label16.text = [NSString stringWithFormat:@"%.2f",self.slider16.value];
        center4 = [CIVector vectorWithX:x4 Y:y4 Z:z4 W:w4];
    }
    
    [self transImageWithCIImage];
    
}

- (IBAction)slider1:(UISlider *)sender {
  [self changeCenterValue:sender.value type:CIColorPolynomialViewControllerTypeX selectCenter:center1];
}
- (IBAction)slider2:(UISlider *)sender {
   [self changeCenterValue:sender.value type:CIColorPolynomialViewControllerTypeZ selectCenter:center1];
}
- (IBAction)slider3:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorPolynomialViewControllerTypeX selectCenter:center2];
}
- (IBAction)slider4:(UISlider *)sender {
     [self changeCenterValue:sender.value type:CIColorPolynomialViewControllerTypeZ selectCenter:center2];
}
- (IBAction)slider5:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorPolynomialViewControllerTypeX selectCenter:center3];
}
- (IBAction)slider6:(UISlider *)sender {
     [self changeCenterValue:sender.value type:CIColorPolynomialViewControllerTypeZ selectCenter:center3];
}
- (IBAction)slider7:(UISlider *)sender {
     [self changeCenterValue:sender.value type:CIColorPolynomialViewControllerTypeX selectCenter:center4];
}
- (IBAction)slider8:(UISlider *)sender {
     [self changeCenterValue:sender.value type:CIColorPolynomialViewControllerTypeZ selectCenter:center4];
}
- (IBAction)slider9:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorPolynomialViewControllerTypey selectCenter:center1];
}
- (IBAction)slider10:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorPolynomialViewControllerTypeW selectCenter:center1];
}
- (IBAction)slider11:(UISlider *)sender {
     [self changeCenterValue:sender.value type:CIColorPolynomialViewControllerTypey selectCenter:center2];
}
- (IBAction)slider12:(UISlider *)sender {
     [self changeCenterValue:sender.value type:CIColorPolynomialViewControllerTypeW selectCenter:center2];
}
- (IBAction)slider13:(UISlider *)sender {
     [self changeCenterValue:sender.value type:CIColorPolynomialViewControllerTypey selectCenter:center3];
}
- (IBAction)slider14:(UISlider *)sender {
     [self changeCenterValue:sender.value type:CIColorPolynomialViewControllerTypeW selectCenter:center3];
}
- (IBAction)slider15:(UISlider *)sender {
     [self changeCenterValue:sender.value type:CIColorPolynomialViewControllerTypey selectCenter:center4];
}

- (IBAction)slider16:(UISlider *)sender {
     [self changeCenterValue:sender.value type:CIColorPolynomialViewControllerTypeW selectCenter:center4];
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
