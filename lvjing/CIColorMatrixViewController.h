//
//  CIColorMatrixViewController.h
//  lvjing
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BViewController.h"
typedef enum : NSUInteger {
    CIColorMatrixViewControllerTypeX,
    CIColorMatrixViewControllerTypeY,
    CIColorMatrixViewControllerTypeZ,
    CIColorMatrixViewControllerTypeW,
    CIColorMatrixViewControllerTypeNull,
} CIColorMatrixViewControllerType;

@interface CIColorMatrixViewController : BViewController
@property (nonatomic, assign)CIColorMatrixViewControllerType type;
@end
