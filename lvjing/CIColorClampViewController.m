//
//  CIColorClampViewController.m
//  lvjing
//
//  Created by apple on 15/12/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CIColorClampViewController.h"
#import "WsliderView.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)
@interface CIColorClampViewController ()<WSliderDelegate>
{
    CIVector * center1;
    CIVector * center2;
    CIFilter *transFilter;
    CIImage *coreImage;
}

@property (strong, nonatomic) CIContext *context;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UISlider *sliderX_max;
@property (weak, nonatomic) IBOutlet UISlider *sliderY_min;
@property (weak, nonatomic) IBOutlet UISlider *sliderY_max;
@property (weak, nonatomic) IBOutlet UISlider *sliderZ_min;
@property (weak, nonatomic) IBOutlet UISlider *sliderZ_max;
@property (weak, nonatomic) IBOutlet UISlider *sliderW_min;
@property (weak, nonatomic) IBOutlet UISlider *sliderW_max;

@property (weak, nonatomic) IBOutlet UILabel *jindu_minX;
@property (weak, nonatomic) IBOutlet UILabel *jindu_minY;
@property (weak, nonatomic) IBOutlet UILabel *jindu_minZ;
@property (weak, nonatomic) IBOutlet UILabel *jindu_minW;
@property (weak, nonatomic) IBOutlet UILabel *jindu_maxX;
@property (weak, nonatomic) IBOutlet UILabel *jindu_maxy;
@property (weak, nonatomic) IBOutlet UILabel *jindu_maxZ;
@property (weak, nonatomic) IBOutlet UILabel *jindu_maxW;
@end

@implementation CIColorClampViewController

- (void)viewDidLoad {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aaaaa) name:CleartransFilter object:nil];
    _sliderView = [[WsliderView alloc] initWithFrame:CGRectMake(0, 0, 100, 300)];
    _sliderView.delegate = self;
    [self.view addSubview:_sliderView];
    
    [_sliderView setObject:0 max:1 nowvalue:0 type:CIColorClampViewControllerTypeX];
    [_sliderView setObject:0 max:1 nowvalue:0 type:CIColorClampViewControllerTypeY];
    [_sliderView setObject:0 max:1 nowvalue:0 type:CIColorClampViewControllerTypeZ];
    [_sliderView setObject:0 max:1 nowvalue:0 type:CIColorClampViewControllerTypeW];

    center1 = [CIVector vectorWithX:0 Y:0 Z:0 W:0];
    center2 = [CIVector vectorWithX:1 Y:1 Z:1 W:1];
    self.slider.value = center1.X;
    self.sliderY_min.value = center1.Y;
    self.sliderZ_min.value = center1.Z;
    self.sliderW_min.value = center1.W;
    self.sliderX_max.value = center2.X;
    self.sliderY_max.value = center2.Y;
    self.sliderZ_max.value = center2.Z;
    self.sliderW_max.value = center2.W;
    
    [self transImageWithCIImage];
    [super viewDidLoad];
    
}

- (void)aaaaa
{
    transFilter = nil;
}

- (void )transImageWithCIImage
{
    if (transFilter == nil) {
        CGImageRef cgImg = self.fimageView.image.CGImage;
        coreImage = [CIImage imageWithCGImage:cgImg];
        transFilter = [CIFilter filterWithName:@"CIColorClamp"];
    }
    
    NSLog(@"center1 -- %@",center1);
    NSLog(@"center2 -- %@",center2);
    [transFilter setValue:coreImage forKey:kCIInputImageKey];
    [transFilter setValue:center1 forKey:@"inputMinComponents"];
    [transFilter setValue:center2 forKey:@"inputMaxComponents"];
    CIImage *output = transFilter.outputImage;
    
    self.context = [CIContext contextWithOptions: nil];
    CGImageRef cgimg = [self.context createCGImage:output fromRect:[output extent]];
    UIImage *uiimage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    self.fimageView.image = uiimage;

}

- (void)changeCenterValue:(CGFloat )value type:(CIColorClampViewControllerType)type selectMin:(BOOL)Min
{
    if (Min) {
        CGFloat min_xx = self.slider.value;
        CGFloat min_yy = self.sliderY_min.value;
        CGFloat min_zz = self.sliderZ_min.value;
        CGFloat min_ww = self.sliderW_min.value;
        if (type == CIColorClampViewControllerTypeX) {
            min_xx = value;
            
        }
        else if (type == CIColorClampViewControllerTypeY)
        {
            min_yy = value;
            
        }
        else if (type == CIColorClampViewControllerTypeZ)
        {
            min_zz = value;
            
        }
        else if (type == CIColorClampViewControllerTypeW)
        {
            min_ww = value;
            
        }
        _jindu_minX.text = [NSString stringWithFormat:@"%.2f",self.slider.value];
        _jindu_minY.text = [NSString stringWithFormat:@"%.2f",self.sliderY_min.value];
        _jindu_minZ.text = [NSString stringWithFormat:@"%.2f",self.sliderZ_min.value];
        _jindu_minW.text = [NSString stringWithFormat:@"%.2f",self.sliderW_min.value];
        center1 = [CIVector vectorWithX:min_xx Y:min_yy Z:min_zz W:min_ww];
    }
    else
    {
        CGFloat max_xx = self.sliderX_max.value;
        CGFloat max_yy = self.sliderY_max.value;
        CGFloat max_zz = self.sliderZ_max.value;
        CGFloat max_ww = self.sliderW_max.value;
        if (type == CIColorClampViewControllerTypeX) {
            max_xx = value;
        }
        else if (type == CIColorClampViewControllerTypeY)
        {
            max_yy = value;
        }
        else if (type == CIColorClampViewControllerTypeZ)
        {
            max_zz = value;
        }
        else if (type == CIColorClampViewControllerTypeW)
        {
            max_ww = value;
        }
        _jindu_maxX.text = [NSString stringWithFormat:@"%.2f",self.sliderX_max.value];
        _jindu_maxy.text = [NSString stringWithFormat:@"%.2f",self.sliderY_max.value];
        _jindu_maxZ.text = [NSString stringWithFormat:@"%.2f",self.sliderZ_max.value];
        _jindu_maxW.text = [NSString stringWithFormat:@"%.2f",self.sliderW_max.value];
        center2 = [CIVector vectorWithX:max_xx Y:max_yy Z:max_zz W:max_ww];
    }
    [self transImageWithCIImage];
}

- (IBAction)slider:(UISlider *)sender {
    
    [self changeCenterValue:sender.value type:CIColorClampViewControllerTypeX selectMin:YES];
}

- (IBAction)slider_maxX:(UISlider *)sender {
    
    [self changeCenterValue:sender.value type:CIColorClampViewControllerTypeX selectMin:NO];

}

- (IBAction)slider_minY:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorClampViewControllerTypeY selectMin:YES];
}

- (IBAction)slider_maxY:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorClampViewControllerTypeY selectMin:NO];

}

- (IBAction)slider_minZ:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorClampViewControllerTypeZ selectMin:YES];
}

- (IBAction)slider_maxZ:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorClampViewControllerTypeZ selectMin:NO];
}

- (IBAction)slider_minW:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorClampViewControllerTypeW selectMin:YES];
}

- (IBAction)slider_maxW:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorClampViewControllerTypeW selectMin:NO];
}

#pragma mark -  WSliderDelegate

- (void)sliderUpdateValue:(CGFloat)value type:(NSInteger)type selectMin:(BOOL)min{
    
    [self sliderUpdateValue:self.slider.value type:type selectMin:min];
}

@end
