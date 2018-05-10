//
//  RCGuidePageViewController.m
//  Running
//
//  Created by guangwei li on 2018/5/7.
//  Copyright © 2018年 123. All rights reserved.
//
#define PAGE 3
#define WIDTH (NSInteger)self.view.bounds.size.width
#define HEIGHT (NSInteger)self.view.bounds.size.height

#import "GuidePageViewController.h"

#import "TabBarViewController.h"

@interface GuidePageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl * pageControl;
@property (strong, nonatomic) UIImageView * imageView;
@property (strong, nonatomic) UIScrollView * scrollView;


@end

@implementation GuidePageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    ////画布大小
    myScrollView.contentSize = CGSizeMake(WIDTH*PAGE, HEIGHT);
    ///分页
    myScrollView.pagingEnabled = YES;
    ///去掉弹簧效果
    myScrollView.bounces = NO;
    
    myScrollView.showsVerticalScrollIndicator = NO;
    myScrollView.showsHorizontalScrollIndicator = NO
    ;
    myScrollView.delegate = self;
    
    self.scrollView = myScrollView;
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, HEIGHT/1.2, WIDTH, 30)];
    ///未选中时的颜色
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    ///选中时的颜色
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.0];
    self.pageControl.numberOfPages = PAGE;
    
    
    
    
    for (int i =  0; i<PAGE; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH*i, 0, WIDTH, HEIGHT)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d",i+1]];
        //imageView.backgroundColor = RCRandomColor;
        [myScrollView addSubview:imageView];
        
        self.imageView = imageView;
        
        if (i+1 == PAGE)
        {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake((WIDTH*i+RCScreenW/2-100), HEIGHT/1.5, 200, 40);
            button.backgroundColor = RCRGBColor(162, 205, 90);
            [button setTitle:@"开启登录" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
            [myScrollView addSubview:button];
        }
        //  self.pageControl.currentPage = imageView.x/WIDTH-PAGE + i;
        
        
        
    }
    
    myScrollView.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:myScrollView];
    
    
    [self.view addSubview:_pageControl];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    ////滚动视图结束的时候，改变pageControl的页数位置
    self.pageControl.currentPage = scrollView.contentOffset.x /  scrollView.width;
    
}


-(void)enter
{
    TabBarViewController * sport = [[TabBarViewController alloc] init];
    [self presentViewController:sport animated:YES completion:nil];
    
}

@end
