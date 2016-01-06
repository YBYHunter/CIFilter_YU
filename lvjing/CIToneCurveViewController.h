//
//  CIToneCurveViewController.h
//  lvjing
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BViewController.h"
typedef enum :
NSUInteger{
        CIToneCurveViewControllerTypeinputPoint0,
        CIToneCurveViewControllerTypeinputPoint1,
        CIToneCurveViewControllerTypeinputPoint2,
        CIToneCurveViewControllerTypeinputPoint3,
        CIToneCurveViewControllerTypeinputPoint4,
}CIToneCurveViewControllerType;


@interface CIToneCurveViewController : BViewController
@property (nonatomic,assign)CIToneCurveViewControllerType type;

@end
