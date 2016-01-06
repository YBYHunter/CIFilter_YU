//
//  ViewController.m
//  lvjing
//
//  Created by apple on 15/12/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "CIColorClampViewController.h"
#import "CIColorControlsViewController.h"
#import "CIColorMatrixViewController.h"
#import "CIColorPolynomialViewController.h"
#import "CIEXposureAdjustViewController.h"
#import "CIGamaAdjustViewController.h"
#import "CIHueAdjustViewController.h"
#import "CILinearToSRGBToneCurveViewController.h"
#import "CITemperatureAndTintViewController.h"
#import "CIToneCurveViewController.h"
#import "CIVibranceViewController.h"
#import "CIWhitePointAdjustViewController.h"
#import "CISRGBToneCurveToLinentViewController.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize dataSourceList;
@synthesize myTableView;

- (void)viewDidLoad {
    [super viewDidLoad];

    dataSourceList = [[NSMutableArray alloc] initWithObjects:@"CIColorClamp",@"CIColorControls（设置灰度）",@"CIColorMatrix（CIColor矩阵）",@"CIColorPolynomial（泰勒多项式）",@"CIExposureAdjust（曝光调节）",@"CIGammaAdjust（灰度系数调节）",@"CIHueAdjust（饱和度调节）",@"CILinearToSRGBToneCurve",@"CISRGBToneCurveToLinear", @"CITemperatureAndTint（色温）",@"CIToneCurve（色调曲线）",@"CIVibrance（振动）",@"CIWhitePointAdjust（白平衡调节）",nil];
    
    CGRect rect = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+50, self.view.frame.size.width, self.view.frame.size.height-50);
    UITableView *tempTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    tempTableView.dataSource = self;
    tempTableView.delegate = self;
    
    self.myTableView = tempTableView;
    [self.view addSubview:self.myTableView];
    [self backbtn];
}
- (void)backbtn{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 2
, 80, 51)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventAllEvents];
    [self.view addSubview:btn];
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //解决ios7以后，［canEditRowAtIndexPath］滑动删除方法不自动将［setEditing：］置Yes的问题。不写会造成崩溃
    [self.myTableView setEditing:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UITableView DataSource

#pragma mark - 表视图每个组(group)有多少行(cell)的设置方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSourceList count];
}

#pragma mark - 表视图每行(cell)的设置方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
    }
    //加载每一行的标签内容
    cell.textLabel.text = [self.dataSourceList objectAtIndex:indexPath.row];
    
    return cell;
}
#pragma mark - 左滑删除操作的设置方法
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //开启允许编辑
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //如果编辑操作是删除操作，那么执行删除方法
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //从数据源中删除目标数据
        [dataSourceList removeObjectAtIndex:indexPath.row];
        //表视图中删除当前行
        [myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    //如果编辑操作是插入操作...
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bazingga" message:@"添加一行操作还没实现" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    //更改左滑删除按钮标题，默认delete英文。
    return @"删除";
}
#pragma mark - 移动cell的设置方法(未实现)
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.section == 0 )
        return NO;
    
    return YES;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    id objectToMove = [self.dataSourceList objectAtIndex:sourceIndexPath.row];
    [self.dataSourceList removeObjectAtIndex:sourceIndexPath.row];
    [self.dataSourceList insertObject:objectToMove atIndex:destinationIndexPath.row];
}

//选中一行时的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //按下弹起
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        CIColorClampViewController *clamp = [[CIColorClampViewController alloc]init];
        [self presentViewController:clamp animated:YES completion:nil];
    }
    if (indexPath.row == 1) {
        CIColorControlsViewController *controls = [[CIColorControlsViewController alloc]init];
        [self presentViewController:controls animated:YES completion:nil];
        
    }
    if (indexPath.row == 2) {
        CIColorMatrixViewController *maxtrix = [[CIColorMatrixViewController alloc]init];
        [self presentViewController:maxtrix animated:YES completion:nil];
        
    }
    if (indexPath.row == 3) {
        CIColorPolynomialViewController *poly = [[CIColorPolynomialViewController alloc]init];
        [self presentViewController:poly animated:YES completion:nil];
    }
    if (indexPath.row == 4) {
        CIEXposureAdjustViewController *exposure = [[CIEXposureAdjustViewController alloc]init];
        [self presentViewController:exposure animated:YES completion:nil];
        
        
    }
    if (indexPath.row == 5) {
        CIGamaAdjustViewController *gama = [[CIGamaAdjustViewController alloc]init];
        [self presentViewController:gama animated:YES completion:nil];
        
        
    }
    if (indexPath.row == 6) {
        CIHueAdjustViewController *hue = [[CIHueAdjustViewController alloc]init];
        [self presentViewController:hue animated:YES completion:nil];
        
    }
    if (indexPath.row == 7) {
        CILinearToSRGBToneCurveViewController *linear = [[CILinearToSRGBToneCurveViewController alloc]init];
        [self presentViewController:linear animated:YES completion:nil];
    }
    if (indexPath.row == 8) {
       // CISRGBToneCurveToLinent
        CISRGBToneCurveToLinentViewController *curvetolinent = [[CISRGBToneCurveToLinentViewController alloc]init];
        [self presentViewController:curvetolinent animated:YES completion:nil];
        
    }
    if (indexPath.row == 9) {
        CITemperatureAndTintViewController *temperatureAndTint = [[CITemperatureAndTintViewController alloc]init];
        [self presentViewController:temperatureAndTint animated:YES completion:nil];
    }
    if (indexPath.row == 10) {
        CIToneCurveViewController *tonecurve = [[CIToneCurveViewController alloc]init];
        [self presentViewController:tonecurve animated:YES completion:nil];
    }
    if (indexPath.row == 11) {
        CIVibranceViewController *vibrance = [[CIVibranceViewController alloc]init];
        [self presentViewController:vibrance animated:YES completion:nil];
    }
    if (indexPath.row == 12){
        CIWhitePointAdjustViewController *whitePointAdjust = [[CIWhitePointAdjustViewController alloc]init];
        [self presentViewController:whitePointAdjust animated:YES completion:nil];
    }
}

@end
