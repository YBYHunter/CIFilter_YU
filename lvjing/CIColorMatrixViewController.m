
//
//  CIColorMatrixViewController.m
//  lvjing
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CIColorMatrixViewController.h"
#define SCREENHEIGHT ([[UIScreen mainScreen]bounds].size.height)

@interface CIColorMatrixViewController (){
//    UIView *infoView;
    CIVector * center1;
    CIVector * center2;
    CIVector * center3;
    CIVector * center4;
    CIVector * center5;
    CIFilter *transFilter;
    CIImage *coreImage;
}
@property (strong, nonatomic) CIContext *context;

@property (weak, nonatomic) IBOutlet UISlider *a;
@property (weak, nonatomic) IBOutlet UISlider *b;
@property (weak, nonatomic) IBOutlet UISlider *c;
@property (weak, nonatomic) IBOutlet UISlider *d;
@property (weak, nonatomic) IBOutlet UISlider *e;
@property (weak, nonatomic) IBOutlet UISlider *f;
@property (weak, nonatomic) IBOutlet UISlider *g;
@property (weak, nonatomic) IBOutlet UISlider *h;
@property (weak, nonatomic) IBOutlet UISlider *i;
@property (weak, nonatomic) IBOutlet UISlider *j;
@property (weak, nonatomic) IBOutlet UISlider *k;
@property (weak, nonatomic) IBOutlet UISlider *l;
@property (weak, nonatomic) IBOutlet UISlider *m;
@property (weak, nonatomic) IBOutlet UISlider *n;
@property (weak, nonatomic) IBOutlet UISlider *o;
@property (weak, nonatomic) IBOutlet UISlider *p;
@property (weak, nonatomic) IBOutlet UISlider *q;
@property (weak, nonatomic) IBOutlet UISlider *r;
@property (weak, nonatomic) IBOutlet UISlider *s;
@property (weak, nonatomic) IBOutlet UISlider *t;
@property (weak, nonatomic) IBOutlet UILabel *label_a;
@property (weak, nonatomic) IBOutlet UILabel *label_b;
@property (weak, nonatomic) IBOutlet UILabel *label_c;
@property (weak, nonatomic) IBOutlet UILabel *label_d;
@property (weak, nonatomic) IBOutlet UILabel *label_e;
@property (weak, nonatomic) IBOutlet UILabel *label_f;
@property (weak, nonatomic) IBOutlet UILabel *label_g;
@property (weak, nonatomic) IBOutlet UILabel *label_h;
@property (weak, nonatomic) IBOutlet UILabel *label_i;
@property (weak, nonatomic) IBOutlet UILabel *label_j;
@property (weak, nonatomic) IBOutlet UILabel *label_k;
@property (weak, nonatomic) IBOutlet UILabel *label_l;
@property (weak, nonatomic) IBOutlet UILabel *label_m;
@property (weak, nonatomic) IBOutlet UILabel *label_n;
@property (weak, nonatomic) IBOutlet UILabel *label_o;
@property (weak, nonatomic) IBOutlet UILabel *label_p;
@property (weak, nonatomic) IBOutlet UILabel *label_q;
@property (weak, nonatomic) IBOutlet UILabel *label_r;
@property (weak, nonatomic) IBOutlet UILabel *label_s;
@property (weak, nonatomic) IBOutlet UILabel *label_t;

@end

@implementation CIColorMatrixViewController
- (IBAction)a:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeX selectCenter:center1];
}
- (IBAction)b:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeZ selectCenter:center1];
}
- (IBAction)c:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeX selectCenter:center2];
}
- (IBAction)d:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeZ selectCenter:center2];
}
- (IBAction)e:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeX selectCenter:center3];
}
- (IBAction)f:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeZ selectCenter:center3];
}
- (IBAction)g:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeX selectCenter:center4];
}
- (IBAction)h:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeZ selectCenter:center4];
}

- (IBAction)i:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeX selectCenter:center5];
}

- (IBAction)j:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeZ selectCenter:center5];
}
- (IBAction)k:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeY selectCenter:center1];
}
- (IBAction)l:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeW selectCenter:center1];
}
- (IBAction)m:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeY selectCenter:center2];
}
- (IBAction)n:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeW selectCenter:center2];
}
- (IBAction)o:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeY selectCenter:center3];
}
- (IBAction)p:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeW selectCenter:center3];
}
- (IBAction)q:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeY selectCenter:center4];
}
- (IBAction)r:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeW selectCenter:center4];
}
- (IBAction)s:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeY selectCenter:center5];
}
- (IBAction)t:(UISlider *)sender {
    [self changeCenterValue:sender.value type:CIColorMatrixViewControllerTypeW selectCenter:center5];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aaaaa) name:CleartransFilter object:nil];
    
    center1 = [CIVector vectorWithX:1 Y:0 Z:0 W:0];
    center2 = [CIVector vectorWithX:0 Y:1 Z:0 W:0];
    center3 = [CIVector vectorWithX:0 Y:0 Z:1 W:0];
    center4 = [CIVector vectorWithX:0 Y:0 Z:0 W:1];
    center5 = [CIVector vectorWithX:0 Y:0 Z:0 W:0];
    
    self.a.value = center1.X;
    self.k.value = center1.Y;
    self.b.value = center1.Z;
    self.l.value = center1.W;
    
    self.c.value = center2.X;
    self.m.value = center2.Y;
    self.d.value = center2.Z;
    self.n.value = center2.W;
    
    self.e.value = center3.X;
    self.o.value = center3.Y;
    self.f.value = center3.Z;
    self.p.value = center3.W;
    
    self.g.value = center4.X;
    self.q.value = center4.Y;
    self.h.value = center4.Z;
    self.r.value = center4.W;
    
    self.i.value = center1.X;
    self.s.value = center1.Y;
    self.j.value = center1.Z;
    self.t.value = center1.W;
    
    _label_a.text = [NSString stringWithFormat:@"%.2f",self.a.value];
    _label_b.text = [NSString stringWithFormat:@"%.2f",self.b.value];
    _label_c.text = [NSString stringWithFormat:@"%.2f",self.c.value];
    _label_d.text = [NSString stringWithFormat:@"%.2f",self.d.value];
    _label_e.text = [NSString stringWithFormat:@"%.2f",self.e.value];
    _label_f.text = [NSString stringWithFormat:@"%.2f",self.f.value];
    _label_g.text = [NSString stringWithFormat:@"%.2f",self.g.value];
    _label_h.text = [NSString stringWithFormat:@"%.2f",self.h.value];
    _label_i.text = [NSString stringWithFormat:@"%.2f",self.i.value];
    _label_j.text = [NSString stringWithFormat:@"%.2f",self.j.value];
    _label_k.text = [NSString stringWithFormat:@"%.2f",self.k.value];
    _label_l.text = [NSString stringWithFormat:@"%.2f",self.l.value];
    _label_m.text = [NSString stringWithFormat:@"%.2f",self.m.value];
    _label_n.text = [NSString stringWithFormat:@"%.2f",self.n.value];
    _label_o.text = [NSString stringWithFormat:@"%.2f",self.o.value];
    _label_p.text = [NSString stringWithFormat:@"%.2f",self.p.value];
    _label_q.text = [NSString stringWithFormat:@"%.2f",self.q.value];
    _label_r.text = [NSString stringWithFormat:@"%.2f",self.r.value];
    _label_s.text = [NSString stringWithFormat:@"%.2f",self.s.value];
    _label_t.text = [NSString stringWithFormat:@"%.2f",self.t.value];

      [self transImageWithCIImage];
//    [self setbutton];
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
        transFilter = [CIFilter filterWithName:@"CIColorMatrix"];
    }
    
    [transFilter setValue:coreImage forKey:kCIInputImageKey];
    [transFilter setValue:center1 forKey:@"inputRVector"];
    [transFilter setValue:center2 forKey:@"inputGVector"];
    [transFilter setValue:center3 forKey:@"inputBVector"];
    [transFilter setValue:center4 forKey:@"inputAVector"];
    [transFilter setValue:center5 forKey:@"inputBiasVector"];
    CIImage *output = transFilter.outputImage;
    
    self.context = [CIContext contextWithOptions: nil];
    CGImageRef cgimg = [self.context createCGImage:output fromRect:[output extent]];
    UIImage *uiimage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    self.fimageView.image = uiimage;
    
}
- (void)changeCenterValue:(CGFloat )value type:(CIColorMatrixViewControllerType)type selectCenter:(id)center{
    if (center == center1) {
        CGFloat x1 = self.a.value;
        CGFloat y1 = self.k.value;
        CGFloat z1 = self.b.value;
        CGFloat w1 = self.l.value;
        if (type == CIColorMatrixViewControllerTypeX) {
            x1 = value;
        }
        else if (type == CIColorMatrixViewControllerTypeY){
            y1 = value;
        }
        else if (type == CIColorMatrixViewControllerTypeZ){
            z1 = value;
        }
        else if (type == CIColorMatrixViewControllerTypeW){
            w1 = value;
        }
        _label_a.text = [NSString stringWithFormat:@"%.2f",self.a.value];
        _label_b.text = [NSString stringWithFormat:@"%.2f",self.b.value];
        _label_k.text = [NSString stringWithFormat:@"%.2f",self.k.value];
        _label_l.text = [NSString stringWithFormat:@"%.2f",self.l.value];
        center1 = [CIVector vectorWithX:x1 Y:y1 Z:z1 W:w1];
    }
    if (center == center2) {
        CGFloat x2 = self.c.value;
        CGFloat y2 = self.m.value;
        CGFloat z2 = self.d.value;
        CGFloat w2 = self.n.value;
        if (type == CIColorMatrixViewControllerTypeX) {
            x2 = value;
        }
        else if (type == CIColorMatrixViewControllerTypeY){
            y2 = value;
        }
        else if (type == CIColorMatrixViewControllerTypeZ){
            z2 = value;
        }
        else if (type == CIColorMatrixViewControllerTypeW){
            w2 = value;
        }
        _label_c.text = [NSString stringWithFormat:@"%.2f",self.c.value];
        _label_d.text = [NSString stringWithFormat:@"%.2f",self.d.value];
        _label_m.text = [NSString stringWithFormat:@"%.2f",self.m.value];
        _label_n.text = [NSString stringWithFormat:@"%.2f",self.n.value];
        center1 = [CIVector vectorWithX:x2 Y:y2 Z:z2 W:w2];
    }
    if (center == center3) {
        CGFloat x3 = self.e.value;
        CGFloat y3 = self.o.value;
        CGFloat z3 = self.f.value;
        CGFloat w3 = self.p.value;
        if (type == CIColorMatrixViewControllerTypeX) {
            x3 = value;
        }
        else if (type == CIColorMatrixViewControllerTypeY){
            y3 = value;
        }
        else if (type == CIColorMatrixViewControllerTypeZ){
            z3 = value;
        }
        else if (type == CIColorMatrixViewControllerTypeW){
            w3 = value;
        }
        _label_e.text = [NSString stringWithFormat:@"%.2f",self.e.value];
        _label_o.text = [NSString stringWithFormat:@"%.2f",self.o.value];
        _label_f.text = [NSString stringWithFormat:@"%.2f",self.f.value];
        _label_p.text = [NSString stringWithFormat:@"%.2f",self.p.value];
        center3 = [CIVector vectorWithX:x3 Y:y3 Z:z3 W:w3];
    }
    if (center == center4) {
        CGFloat x4 = self.g.value;
        CGFloat y4 = self.q.value;
        CGFloat z4 = self.h.value;
        CGFloat w4 = self.r.value;
        if (type == CIColorMatrixViewControllerTypeX) {
            x4 = value;
        }
        else if (type == CIColorMatrixViewControllerTypeY){
            y4 = value;
        }
        else if (type == CIColorMatrixViewControllerTypeZ){
            z4 = value;
        }
        else if (type == CIColorMatrixViewControllerTypeW){
            w4 = value;
        }
        _label_g.text = [NSString stringWithFormat:@"%.2f",self.g.value];
        _label_q.text = [NSString stringWithFormat:@"%.2f",self.q.value];
        _label_h.text = [NSString stringWithFormat:@"%.2f",self.h.value];
        _label_r.text = [NSString stringWithFormat:@"%.2f",self.r.value];
        center4 = [CIVector vectorWithX:x4 Y:y4 Z:z4 W:w4];
    }
    if (center == center5) {
        CGFloat x5 = self.i.value;
        CGFloat y5 = self.s.value;
        CGFloat z5 = self.j.value;
        CGFloat w5 = self.t.value;
        if (type == CIColorMatrixViewControllerTypeX) {
            x5 = value;
        }
        else if (type == CIColorMatrixViewControllerTypeY){
            y5 = value;
        }
        else if (type == CIColorMatrixViewControllerTypeZ){
            z5 = value;
        }
        else if (type == CIColorMatrixViewControllerTypeW){
            w5 = value;
        }
        _label_i.text = [NSString stringWithFormat:@"%.2f",self.i.value];
        _label_s.text = [NSString stringWithFormat:@"%.2f",self.s.value];
        _label_j.text = [NSString stringWithFormat:@"%.2f",self.j.value];
        _label_t.text = [NSString stringWithFormat:@"%.2f",self.t.value];
        center5 = [CIVector vectorWithX:x5 Y:y5 Z:z5 W:w5];
    }
    [self transImageWithCIImage];

}





//- (void)setbutton{
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(21, 402, 80, 40)];
//    [btn setTitle:@"点我出现" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [btn setBackgroundColor:[UIColor whiteColor]];
//    [btn addTarget:self action:@selector(setInfoViewFrame:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//}
//
//- (void)setInfoViewFrame:(BOOL)isDown{
//    if(isDown == NO)
//    {
//        [UIView animateWithDuration:0.1
//                              delay:0.0
//                            options:0
//                         animations:^{
//                             [infoView setFrame:CGRectMake(0, SCREENHEIGHT+60, 320, 90)];
//                         }
//                         completion:^(BOOL finished) {
//                             [UIView animateWithDuration:0.1
//                                                   delay:0.0
//                                                 options:UIViewAnimationCurveEaseIn
//                                              animations:^{
//                                                  [infoView setFrame:CGRectMake(0, SCREENHEIGHT, 320, 90)];
//                                              }
//                                              completion:^(BOOL finished) {
//                                              }];
//                         }];
//        
//    }else
//    {
//        [UIView animateWithDuration:0.1
//                              delay:0.0
//                            options:0
//                         animations:^{
//                             [infoView setFrame:CGRectMake(0, SCREENHEIGHT-90+16, 320, 90)];
//                         }
//                         completion:^(BOOL finished) {
//                             [UIView animateWithDuration:0.1
//                                                   delay:0.0
//                                                 options:UIViewAnimationCurveEaseIn
//                                              animations:^{
//                                                  [infoView setFrame:CGRectMake(0, SCREENHEIGHT-90, 320, 90)];
//                                              }
//                                              completion:^(BOOL finished) {
//                                              }];
//                         }];
//    }
//}

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
