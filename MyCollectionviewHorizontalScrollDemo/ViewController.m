//
//  ViewController.m
//  MyCollectionviewHorizontalScrollDemo
//
//  Created by yf on 2019/2/18.
//  Copyright © 2019年 yf. All rights reserved.
//

#import "ViewController.h"
#import "Masonry/Masonry.h"
#import "FlyHorizontalFlowLauyout.h"
#import "ItemCell.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) NSArray * listArr;
@property (nonatomic,assign) NSInteger emoticonGroupTotalPageCount;
@property (nonatomic,strong) UIView * pgControlView;
@property (nonatomic,strong) UIPageControl * pageControlBottom;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listArr = @[@"名医问诊",@"临床招募",@"公益医疗",@"基因检测",@"大病社区",@"我的收藏",@"我的评论"];
    _emoticonGroupTotalPageCount = (self.listArr.count%4)?(self.listArr.count/4)+1:(self.listArr.count/4);
    [self stepSubView];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)stepSubView
{
    
    //collectionview
    FlyHorizontalFlowLauyout * layout = [[FlyHorizontalFlowLauyout alloc] init];
    //水平布局
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    layout.itemSize=CGSizeMake((self.view.frame.size.width-60-20)/2, 150/2);
    //设置行列间距
    layout.minimumLineSpacing=20;
    layout.minimumInteritemSpacing=20;
    //设置分区的内容偏移
    layout.sectionInset=UIEdgeInsetsMake(25, 30, 25, 30);
    
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    //打开分页效果
    collectionView.pagingEnabled = YES;
    collectionView.delegate=self;
    collectionView.dataSource=self;
    self.collectionView = collectionView;
    [self.view addSubview:self.collectionView];
    
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(440/2);
    }];
    
    //注册cell
    [collectionView registerClass:[ItemCell class] forCellWithReuseIdentifier:@"ItemCell"];
    
    _pgControlView = [[UIView alloc] init];
    [self.view addSubview:_pgControlView];
    
    [_pgControlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.top.equalTo(self.collectionView.mas_bottom).offset(0);
        make.height.mas_equalTo(30);
    }];
    
    //分页控制器
    _pageControlBottom = [[UIPageControl alloc] initWithFrame:CGRectZero];
    _pageControlBottom.numberOfPages = _emoticonGroupTotalPageCount;
    _pageControlBottom.currentPage = 0;
    _pageControlBottom.pageIndicatorTintColor = [UIColor lightGrayColor];// 设置非选中页的圆点颜色
    _pageControlBottom.currentPageIndicatorTintColor = [UIColor darkGrayColor]; // 设置选中页的圆点颜色
    [_pgControlView addSubview:_pageControlBottom];
    
    
    [_pageControlBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pgControlView.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(10);
    }];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _emoticonGroupTotalPageCount;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    long index = indexPath.section * 4 + indexPath.row;
    ItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCell" forIndexPath:indexPath];
    if (index+1 <= _listArr.count) {
        cell.titleLabel.text = _listArr[index];
        cell.hidden = NO;
    }else{
        cell.hidden = YES;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    long index = indexPath.section * 4 + indexPath.row;
    id obj = _listArr[index];
    NSLog(@"%ld-----%@",(long)indexPath.section,obj);
}

//pagecontroll的委托方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    // 设置页码
    _pageControlBottom.currentPage = page;
}


@end
