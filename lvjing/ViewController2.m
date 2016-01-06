
//
//  ViewController2.m
//  lvjing
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController2.h"
#import "CIColorCrossPolynomialViewController.h"
#import "CIColorCubeViewController.h"
#import "CIColorCubeWithColorSpaceViewController.h"
#import "CIColorInvertViewController.h"
#import "CIColorMapViewController.h"
#import "CIColorMonochromeViewController.h"
#import "CIColorPosterizeViewController.h"
#import "CIFalseColorViewController.h"
#import "CIMaskToAlphaViewController.h"
#import "CIMaximumComponentViewController.h"
#import "CIMinimumComponentViewController.h"
#import "CIPhotoEffectChromeViewController.h"
#import "CIPhotoEffectFadeViewController.h"
#import "CIPhotoEffectMonoViewController.h"
#import "CIPhotoEffectInstantViewController.h"
#import "CIPhotoEffectNoirViewController.h"
#import "CIPhotoEffectTonalViewController.h"
#import "CIPhotoEffectTransferViewController.h"
#import "CIPhotoEffectProcessViewController.h"
#import "CISepiaToneViewController.h"
#import "CIVignetteEffectViewController.h"
#import "CIVignetteViewController.h"
@interface ViewController2 ()

@end

@implementation ViewController2
@synthesize dataSourceList;
@synthesize myTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataSourceList = [[NSMutableArray alloc] initWithObjects:@"CIColorCrossPolynomial",@"CIColorCube",@"CIColorCubeWithColorSpace",@"CIColorInvert",@"CIColorMap",@"CIColorMonochrome",@"CIColorPosterize",@"CIFalseColor",@"CIMaskToAlpha", @"CIMaximumComponent",@"CIMinimumComponent",@"CIPhotoEffectChrome",@"CIPhotoEffectFade",@"CIPhotoEffectInstant",@"CIPhotoEffectMono",@"CIPhotoEffectNoir",@"CIPhotoEffectProcess",@"CIPhotoEffectTonal",@"CIPhotoEffectTransfer",@"CISepiaTone",@"CIVignette",@"CIVignetteEffect",nil];
    
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
        CIColorCrossPolynomialViewController *cross = [[CIColorCrossPolynomialViewController alloc]init];
        [self presentViewController:cross animated:YES completion:nil];
        
    }
    if (indexPath.row == 1) {
        CIColorCubeViewController *cube = [[CIColorCubeViewController alloc]init];
        [self presentViewController:cube animated:YES completion:nil];
        
    }
    if (indexPath.row == 2) {
        CIColorCubeWithColorSpaceViewController *cubewithSpace = [[CIColorCubeWithColorSpaceViewController alloc]init];
        [self presentViewController:cubewithSpace animated:YES completion:nil];
        
    }
    if (indexPath.row == 3) {
        CIColorInvertViewController *invert = [[CIColorInvertViewController alloc]init];
        [self presentViewController:invert animated:YES completion:nil];
      
    }
    if (indexPath.row == 4) {
        CIColorMapViewController *map = [[CIColorMapViewController alloc]init];
        [self presentViewController:map animated:YES completion:nil];
    }
    if (indexPath.row == 5) {
        CIColorMonochromeViewController *monochrome = [[CIColorMonochromeViewController alloc]init];
        [self presentViewController:monochrome animated:YES completion:nil];
        
    }
    if (indexPath.row == 6) {
        CIColorPosterizeViewController *posterize = [[CIColorPosterizeViewController alloc]init];
        [self presentViewController:posterize animated:YES completion:nil];
       
    }
    if (indexPath.row == 7) {
        CIFalseColorViewController *falseColor = [[CIFalseColorViewController alloc]init];
        [self presentViewController:falseColor animated:YES completion:nil];
      
    }
    if (indexPath.row == 8) {
        CIMaskToAlphaViewController *maskToAlpha = [[CIMaskToAlphaViewController alloc]init];
        [self presentViewController:maskToAlpha animated:YES completion:nil];
    }
    if (indexPath.row == 9) {
        CIMaximumComponentViewController *max = [[CIMaximumComponentViewController alloc]init];
        [self presentViewController:max animated:YES completion:nil];
    }
    if (indexPath.row == 10) {
        CIMinimumComponentViewController *mininumComponent = [[CIMinimumComponentViewController alloc]init];
        [self presentViewController:mininumComponent animated:YES completion:nil];
       
    }
    if (indexPath.row == 11) {
        CIPhotoEffectChromeViewController *chrome = [[CIPhotoEffectChromeViewController alloc]init];
        [self presentViewController:chrome animated:YES completion:nil];
    }
    if (indexPath.row == 12){
        CIPhotoEffectFadeViewController *fade = [[CIPhotoEffectFadeViewController alloc]init];
        [self presentViewController:fade animated:YES completion:nil];
    }
    if (indexPath.row == 13) {
        CIPhotoEffectInstantViewController *instant = [[CIPhotoEffectInstantViewController alloc]init];
        [self presentViewController:instant animated:YES completion:nil];
    }
    if (indexPath.row == 14) {
        CIPhotoEffectMonoViewController *mono = [[CIPhotoEffectMonoViewController alloc]init];
        [self presentViewController:mono animated:YES completion:nil];
    }
    if (indexPath.row == 15) {
        CIPhotoEffectNoirViewController *noir = [[CIPhotoEffectNoirViewController alloc]init];
        [self presentViewController:noir animated:YES completion:nil];
    }
    if (indexPath.row == 16) {
        CIPhotoEffectProcessViewController *process = [[CIPhotoEffectProcessViewController alloc]init];
        [self presentViewController:process animated:YES completion:nil];
    }
    if (indexPath.row == 17) {
        CIPhotoEffectTonalViewController *tonal = [[CIPhotoEffectTonalViewController alloc]init];
        [self presentViewController:tonal animated:YES completion:nil];
    }
    if (indexPath.row == 18) {
        CIPhotoEffectTransferViewController *transfer = [[CIPhotoEffectTransferViewController alloc]init];
        [self presentViewController:transfer animated:YES completion:nil];
    }
    if (indexPath.row == 19) {
        CISepiaToneViewController *sipiaTone = [[CISepiaToneViewController alloc]init];
        [self presentViewController:sipiaTone animated:YES completion:nil];
        
    }
    if (indexPath.row == 20) {
        CIVignetteViewController *vignette = [[CIVignetteViewController alloc]init];
        [self presentViewController:vignette animated:YES completion:nil];
    }
    if (indexPath.row == 21) {
        CIVignetteEffectViewController *vignetteEffect = [[CIVignetteEffectViewController alloc]init];
        [self presentViewController:vignetteEffect animated:YES completion:nil];
    }
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
