//
//  CIColorControlsViewController.h
//  lvjing
//
//  Created by apple on 15/12/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BViewController.h"

typedef enum : NSUInteger {
    CIColorControlsViewControllerTypeinputSaturation,
    CIColorControlsViewControllerinputBrightness,
    CIColorControlsViewControllerinputContrast
} CIColorControlsViewControllerType;

@interface CIColorControlsViewController : BViewController

@end
