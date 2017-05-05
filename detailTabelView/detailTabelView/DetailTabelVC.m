//
//  DetailTabelVC.m
//  detailTabelView
//
//  Created by I on 2017/5/4.
//  Copyright © 2017年 QT. All rights reserved.
//

#import "DetailTabelVC.h"

#import "UIImage+UIColor.h"


#define kScaleImageH 350

#define kNavigationH 44

#define kStatusBarH 20


@interface DetailTabelVC () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *detailTabelView;

@property (strong, nonatomic) UIView *tabelHeaderView; // 头部view

@property (strong, nonatomic) UIImageView *scaleImageView;

@property (strong, nonatomic) UIView *maskingView;

@end

@implementation DetailTabelVC


#pragma mark - 懒加载

- (UITableView *)detailTabelView
{
    if (_detailTabelView == nil){
        _detailTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 667) style:UITableViewStyleGrouped];
        
        _detailTabelView.dataSource = self;
        _detailTabelView.delegate = self;
        
        _detailTabelView.backgroundColor = [UIColor cyanColor];
        
//        [_detailTabelView addSubview:self.scaleImageView];
        
        _detailTabelView.tableHeaderView = self.tabelHeaderView;
        
        _detailTabelView.contentInset = UIEdgeInsetsMake(kScaleImageH, 0, 0, 0);
        [_detailTabelView setContentOffset:CGPointMake(0, -kScaleImageH)];
        
        [_detailTabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"decell"];
        
    }
    
    return _detailTabelView;
}

- (UIView *)tabelHeaderView
{
    if (_tabelHeaderView == nil){
        _tabelHeaderView = [[UIView alloc] init];
        _tabelHeaderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 900);
        _tabelHeaderView.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _tabelHeaderView;
}

- (UIImageView *)scaleImageView
{
    if (_scaleImageView == nil) {
        _scaleImageView = [[UIImageView alloc] init];
        _scaleImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kScaleImageH);
        _scaleImageView.image = [UIImage imageNamed:@"cat"];
        _scaleImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _scaleImageView.clipsToBounds = YES; // 这个属性一定要加, 否则虽然imageView高度调整了, 但是图片超出父控件依然能显示,会遮挡住下面的内容
        // 而且还可能会影响tableView的contentOffset的值 (暂时不知道原因)
        
        [_scaleImageView addSubview:self.maskingView];
    }
    
    return _scaleImageView;
}

- (UIView *)maskingView
{
    if (_maskingView == nil) {
        _maskingView = [[UIView alloc] init];
        _maskingView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kScaleImageH);
        _maskingView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0];
    }
    
    return _maskingView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.view.backgroundColor = [UIColor purpleColor];
    
    [self.view addSubview:self.detailTabelView];
    
    [self.view addSubview:self.scaleImageView];
    
    
//    UIColor *naviColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:0.3];
    
//    UIImage *naviImage = [UIImage createImageWithColor:naviColor];

    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

}

#pragma mark - data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"decell" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1];
    
    return cell;
}

#pragma mark - delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat h = -scrollView.contentOffset.y;
    
    if (h <= kNavigationH + kStatusBarH)
    {
        h = kNavigationH + kStatusBarH;
        
        /*
        
        UIColor *navColor = [UIColor whiteColor];
        
        UIImage *navImage = [UIImage createImageWithColor:navColor];
        
        [self.navigationController.navigationBar setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
        
        */
        
    }
    
    // 修改高度
    
    self.scaleImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, h);
    self.maskingView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, h);
    
    // 修改透明度
    
    self.maskingView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:(kScaleImageH - h) / (kScaleImageH - 64)];
    
    
    UIColor *navColor = [UIColor colorWithWhite:0.9 alpha:(kScaleImageH - h) / (kScaleImageH - 64)];
    UIImage *navImage = [UIImage createImageWithColor:navColor];
    [self.navigationController.navigationBar setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
    
    
    
    if (h <= 264.2) // 对应0.3的alpha
    {
        
        self.maskingView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:(kScaleImageH - 264.2) / (kScaleImageH - (kNavigationH + kStatusBarH))];
        
        
        UIColor *navColor = [UIColor colorWithWhite:0.9 alpha:(kScaleImageH - 264.2) / (kScaleImageH - (kNavigationH + kStatusBarH))];
        
        UIImage *navImage = [UIImage createImageWithColor:navColor];
        
        [self.navigationController.navigationBar setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
    }

    /*
    
    CGFloat navAlpha = (350 - h) / (350 - 64);
    
    if (navAlpha >= 1) {
        navAlpha = 0.99;
    }

    UIColor *navColor = [UIColor colorWithWhite:1 alpha:navAlpha];
    
    UIImage *navImage = [UIImage createImageWithColor:navColor];
    
    [self.navigationController.navigationBar setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
    
    */
}

/*

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

*/


@end
