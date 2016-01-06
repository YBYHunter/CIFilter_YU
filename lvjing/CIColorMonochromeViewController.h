//
//  CIColorMonochromeViewController.h
//  lvjing
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BViewController.h"
typedef enum : NSUInteger{
    CIColorMonochromeViewControllerTypeBlue,
    CIColorMonochromeViewControllerTypeGreen,
    CIColorMonochromeViewControllerTypeRed,
}CIColorMonochromeViewControllerType;
@interface CIColorMonochromeViewController : BViewController
@property (nonatomic, assign)CIColorMonochromeViewControllerType *type;
@end
