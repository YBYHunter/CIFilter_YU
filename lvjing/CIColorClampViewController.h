//
//  CIColorClampViewController.h
//  lvjing
//
//  Created by apple on 15/12/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BViewController.h"
#import "WsliderView.h"
typedef enum : NSUInteger {
    CIColorClampViewControllerTypeX,
    CIColorClampViewControllerTypeY,
    CIColorClampViewControllerTypeZ,
    CIColorClampViewControllerTypeW,
    CIColorClampViewControllerTypeNull,
} CIColorClampViewControllerType;

@interface CIColorClampViewController : BViewController

@property (nonatomic,assign) CIColorClampViewControllerType type;

@property (nonatomic, strong) WsliderView *sliderView;
@end
