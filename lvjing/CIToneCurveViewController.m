//
//  CIToneCurveViewController.m
//  lvjing
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CIToneCurveViewController.h"

@interface CIToneCurveViewController (){
    CIVector * center1;
    CIVector * center2;
    CIVector * center3;
    CIVector * center4;
    CIVector * center5;
    CIFilter *transFilter;
    CIImage *coreImage;

}
@property (strong, nonatomic) CIContext *context;

@property (weak, nonatomic) IBOutlet UISlider *x1;
@property (weak, nonatomic) IBOutlet UISlider *y1;
@property (weak, nonatomic) IBOutlet UISlider *x2;
@property (weak, nonatomic) IBOutlet UISlider *y2;
@property (weak, nonatomic) IBOutlet UISlider *x3;
@property (weak, nonatomic) IBOutlet UISlider *y3;
@property (weak, nonatomic) IBOutlet UISlider *x4;
@property (weak, nonatomic) IBOutlet UISlider *y4;
@property (weak, nonatomic) IBOutlet UISlider *x5;
@property (weak, nonatomic) IBOutlet UISlider *y5;
@property (weak, nonatomic) IBOutlet UILabel *jindu1;
@property (weak, nonatomic) IBOutlet UILabel *jindu2;
@property (weak, nonatomic) IBOutlet UILabel *jindu3;
@property (weak, nonatomic) IBOutlet UILabel *jindu4;
@property (weak, nonatomic) IBOutlet UILabel *jindu5;
@property (weak, nonatomic) IBOutlet UILabel *jindu6;
@property (weak, nonatomic) IBOutlet UILabel *jindu7;
@property (weak, nonatomic) IBOutlet UILabel *jindu8;
@property (weak, nonatomic) IBOutlet UILabel *jindu9;
@property (weak, nonatomic) IBOutlet UILabel *jindu10;

@end

@implementation CIToneCurveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aaaaa) name:CleartransFilter object:nil];
    
    center1 = [CIVector vectorWithX:0 Y:0];
    center2 = [CIVector vectorWithX:0.25 Y:0.25];
    center3 = [CIVector vectorWithX:0.5 Y:0.5];
    center4 = [CIVector vectorWithX:0.75 Y:0.75];
    center5 = [CIVector vectorWithX:1 Y:1];
    self.x1.value = center1.X;
    self.y1.value = center1.Y;
    self.x2.value = center2.X;
    self.y2.value = center2.Y;
    self.x3.value = center3.X;
    self.y3.value = center3.Y;
    self.x4.value = center4.X;
    self.y4.value = center4.Y;
    self.x5.value = center5.X;
    self.y5.value = center5.Y;
    
   
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
        transFilter = [CIFilter filterWithName:@"CIToneCurve"];
    }
    
    [transFilter setValue:coreImage forKey:kCIInputImageKey];
    
    [transFilter setValue:center1 forKey:@"inputPoint0"];
    [transFilter setValue:center2 forKey:@"inputPoint1"];
    [transFilter setValue:center3 forKey:@"inputPoint2"];
    [transFilter setValue:center4 forKey:@"inputPoint3"];
    [transFilter setValue:center5 forKey:@"inputPoint4"];
   
    CIImage *output = transFilter.outputImage;
    
    self.context = [CIContext contextWithOptions: nil];
    CGImageRef cgimg = [self.context createCGImage:output fromRect:[output extent]];
    UIImage *uiimage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    self.fimageView.image = uiimage;
    return uiimage;
}

- (void)changeCenterValue:(CGFloat)value type:(CIToneCurveViewControllerType)type selectcenter:(BOOL)min{
    if (min) {
        CGFloat one = _x1.value;
        CGFloat two = _x2.value;
        CGFloat three = _x3.value;
        CGFloat four = _x4.value;
        CGFloat five = _x5.value;
        if (type == CIToneCurveViewControllerTypeinputPoint0) {
            one = value;
            center1 = [CIVector vectorWithX: one];
        }
        else if (type == CIToneCurveViewControllerTypeinputPoint1) {
            two = value;
            center2 = [CIVector vectorWithX: two];
        }
        else if (type == CIToneCurveViewControllerTypeinputPoint2) {
            three = value;
            center3 = [CIVector vectorWithX:three];
        }
        else if (type == CIToneCurveViewControllerTypeinputPoint3) {
            four = value;
            center4 = [CIVector vectorWithX:four];
        }
        else if (type == CIToneCurveViewControllerTypeinputPoint4) {
            five = value;
            center5 = [CIVector vectorWithX:five];
        }
        _jindu1.text = [NSString stringWithFormat:@"%.2f",self.x1.value];
        _jindu3.text = [NSString stringWithFormat:@"%.2f",self.x2.value];
        _jindu5.text = [NSString stringWithFormat:@"%.2f",self.x3.value];
        _jindu7.text = [NSString stringWithFormat:@"%.2f",self.x4.value];
        _jindu9.text = [NSString stringWithFormat:@"%.2f",self.x5.value];

    }
    else{
        CGFloat first = _y1.value;
        CGFloat second = _y2.value;
        CGFloat third = _y3.value;
        CGFloat forth = _y4.value;
        CGFloat fifth = _y5.value;
        if (type == CIToneCurveViewControllerTypeinputPoint0) {
            first = value;
            center1 = [CIVector vectorWithX:0 Y:first];
        }
        else if (type == CIToneCurveViewControllerTypeinputPoint1){
            second = value;
            center2 = [CIVector vectorWithX:0 Y:second];

        }
        else if (type == CIToneCurveViewControllerTypeinputPoint2){
            third = value;
            center3 = [CIVector vectorWithX:0 Y:third];

        }
        else if (type == CIToneCurveViewControllerTypeinputPoint3){
            forth = value;
            center4 = [CIVector vectorWithX:0 Y:forth];

        }
        else if (type == CIToneCurveViewControllerTypeinputPoint4){
            fifth = value;
            center5 = [CIVector vectorWithX:0 Y:fifth];

        }
        _jindu2.text = [NSString stringWithFormat:@"%.2f",self.y1.value];
        _jindu4.text = [NSString stringWithFormat:@"%.2f",self.y2.value];
        _jindu6.text = [NSString stringWithFormat:@"%.2f",self.y3.value];
        _jindu8.text = [NSString stringWithFormat:@"%.2f",self.y4.value];
        _jindu10.text = [NSString stringWithFormat:@"%.2f",self.y5.value];
    }
}

- (IBAction)x1:(UISlider *)sender {
    center1 = [CIVector vectorWithX:sender.value Y:0];
    [self transImageWithCIImage];
    [_x1 addTarget:self action:@selector(jindu1:) forControlEvents:UIControlEventAllEvents];
}
- (void)jindu1:(UISlider *)sender{
    _jindu1.text = [NSString stringWithFormat:@"%.2f",(sender.value/sender.maximumValue)];
}

- (IBAction)y1:(UISlider *)sender {
    center2 = [CIVector vectorWithX:sender.value Y:1];
    [self transImageWithCIImage];
    [_y1 addTarget:self action:@selector(jindu2:) forControlEvents:UIControlEventAllEvents];
}
- (void)jindu2:(UISlider *)sender{
    _jindu2.text = [NSString stringWithFormat:@"%.2f",(sender.value/sender.maximumValue)];
}

- (IBAction)x2:(UISlider *)sender {
    center1 = [CIVector vectorWithX:0 Y:sender.value];
    [self transImageWithCIImage];
    [_x2 addTarget:self action:@selector(jindu3:) forControlEvents:UIControlEventAllEvents];
}

- (void)jindu3:(UISlider *)sender{
    _jindu3.text = [NSString stringWithFormat:@"%.2f",(sender.value/sender.maximumValue)];
}

- (IBAction)y2:(UISlider *)sender {
    center2 = [CIVector vectorWithX:1 Y:sender.value];
    [self transImageWithCIImage];
    [_y2 addTarget:self action:@selector(jindu4:) forControlEvents:UIControlEventAllEvents];
}

- (void)jindu4:(UISlider *)sender{
    _jindu4.text = [NSString stringWithFormat:@"%.2f",(sender.value/sender.maximumValue)];
}

- (IBAction)x3:(UISlider *)sender {
    center1 = [CIVector vectorWithX:sender.value Y:0];
    [self transImageWithCIImage];
    [_x3 addTarget:self action:@selector(jindu5:) forControlEvents:UIControlEventAllEvents];
}

- (void)jindu5:(UISlider *)sender{
    _jindu5.text = [NSString stringWithFormat:@"%.2f",(sender.value/sender.maximumValue)];
}


- (IBAction)y3:(UISlider *)sender {
    center3 = [CIVector vectorWithX:sender.value Y:1];
    [self transImageWithCIImage];
    [_y3 addTarget:self action:@selector(jindu6:) forControlEvents:UIControlEventAllEvents];
}

- (void)jindu6:(UISlider *)sender{
    _jindu6.text = [NSString stringWithFormat:@"%.2f",(sender.value/sender.maximumValue)];
}


- (IBAction)x4:(UISlider *)sender {
    center1 = [CIVector vectorWithX:0 Y:sender.value];
    [self transImageWithCIImage];
    [_x4 addTarget:self action:@selector(jindu7:) forControlEvents:UIControlEventAllEvents];
}
- (void)jindu7:(UISlider *)sender{
    _jindu7.text = [NSString stringWithFormat:@"%.2f",(sender.value/sender.maximumValue)];
}

- (IBAction)y4:(UISlider *)sender {
    center4 = [CIVector vectorWithX:1 Y:sender.value];
    [self transImageWithCIImage];
     [_y4 addTarget:self action:@selector(jindu8:) forControlEvents:UIControlEventAllEvents];
}

- (void)jindu8:(UISlider *)sender{
    _jindu8.text = [NSString stringWithFormat:@"%.2f",(sender.value/sender.maximumValue)];
}

- (IBAction)x5:(UISlider *)sender {
    center1 = [CIVector vectorWithX:sender.value Y:0];
    [self transImageWithCIImage];
     [_x5 addTarget:self action:@selector(jindu9:) forControlEvents:UIControlEventAllEvents];
}
- (void)jindu9:(UISlider *)sender{
    _jindu9.text = [NSString stringWithFormat:@"%.2f",(sender.value/sender.maximumValue)];
}

- (IBAction)y5:(UISlider *)sender {
    center5 = [CIVector vectorWithX:sender.value Y:1];
    [self transImageWithCIImage];
     [_y5 addTarget:self action:@selector(jindu10:) forControlEvents:UIControlEventAllEvents];
}

- (void)jindu10:(UISlider *)sender{
    _jindu10.text = [NSString stringWithFormat:@"%.2f",(sender.value/sender.maximumValue)];
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
