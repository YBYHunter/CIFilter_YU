//
//  CIColorCrossPolynomialViewController.m
//  lvjing
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CIColorCrossPolynomialViewController.h"

@interface CIColorCrossPolynomialViewController ()
{
    CIVector * center1;
    CIVector * center2;
    CIFilter *transFilter;
    CIImage *coreImage;

}
@property (strong, nonatomic) CIContext *context;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CIColorCrossPolynomialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"还没完成" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
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
