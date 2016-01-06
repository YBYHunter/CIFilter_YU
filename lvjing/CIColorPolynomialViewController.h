//
//  CIColorPolynomialViewController.h
//  lvjing
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BViewController.h"
typedef enum : NSUInteger {
    CIColorPolynomialViewControllerTypeX,
    CIColorPolynomialViewControllerTypey,
    CIColorPolynomialViewControllerTypeZ,
    CIColorPolynomialViewControllerTypeW,
    CIColorPolynomialViewControllerTypeNull,
} CIColorPolynomialViewControllerType;

@interface CIColorPolynomialViewController : BViewController

@end
