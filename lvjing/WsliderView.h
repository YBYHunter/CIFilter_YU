//
//  WsliderView.h
//  lvjing
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WSliderDelegate <NSObject>

- (void)sliderUpdateValue:(CGFloat)value type:(NSInteger)type selectMin:(BOOL)min;

@end

@interface WsliderView : UIView
@property(nonatomic, retain) UISlider *baseSlider;
@property(nonatomic, retain) UILabel *label;
@property (nonatomic, assign)id <WSliderDelegate> delegate;

- (void)setObject:(CGFloat )minValue max:(CGFloat )maxValue nowvalue:(CGFloat )nowValue type:(NSInteger)type;

@end
