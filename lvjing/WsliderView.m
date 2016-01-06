//
//  WsliderView.m
//  lvjing
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "WsliderView.h"

@interface WsliderView ()
{
    NSInteger wsliderType;
    BOOL YesOrNo;
}
@end

@implementation WsliderView

- (void)setObject:(CGFloat)minValue max:(CGFloat )maxValue nowvalue:(CGFloat )nowValue type:(NSInteger)type{
    _baseSlider.maximumValue = maxValue;
    _baseSlider.minimumValue = minValue;
    _baseSlider.value = nowValue;
    wsliderType = type;
}

#pragma mark - 初始化进度条
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _baseSlider = [[UISlider alloc]initWithFrame:CGRectMake(100, 0, 100, 100)];
        _baseSlider.value = 0;
        _baseSlider.maximumValue = 1;
        _baseSlider.minimumValue = 0;
        [_baseSlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_baseSlider];
        
//        //进度label
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 35, 20)];
//        label.backgroundColor = [UIColor blueColor];
//        label.textColor = [UIColor whiteColor];
//        label.text = [NSString stringWithFormat:@"%.2f",_baseSlider.value];
//        [self addSubview:label];
//        
//        //name label
//        UILabel *namelabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 35, 20)];
//        namelabel.backgroundColor = [UIColor blueColor];
//        [self addSubview:namelabel];
        
    }
    return self;
}

- (void)sliderAction:(UISlider *)sender selectMin:(BOOL)min{
    _label.text = [NSString stringWithFormat:@"%.2f",sender.value];
    if([self.delegate respondsToSelector:@selector(sliderUpdateValue:type:selectMin:)])
    {
        [self.delegate sliderUpdateValue:sender.value type:wsliderType selectMin:YesOrNo];
    }
}



@end
