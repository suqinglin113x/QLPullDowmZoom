//
//  ViewController.h
//  澎湃新闻上滑
//
//  Created by 苏庆林 on 16/11/17.
//  Copyright © 2016年 苏庆林. All rights reserved.
//

#define KScreenSize [UIScreen mainScreen].bounds.size

#import "ViewController.h"
#import "MJRefresh.h"


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSourceArray;
@property (nonatomic, strong)UIImageView *headerBackView;
@property (nonatomic, strong)UIImageView *photoImageView;
@property (nonatomic, strong)UILabel *userNameLabel;
@property (nonatomic, strong)UILabel *introduceLabel;
@property (nonatomic, strong)UIView *tableViewHeaderView;
@property (nonatomic, assign)NSInteger imageHeight;

@property (nonatomic, strong) UIView *naviView;
@end

@implementation ViewController
{
    UILabel *navlabel;
    BOOL _hasHiding ;
}
- (void)setNaviTitleWithTitle:(NSString *)title
{
    UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenSize.width, 64)];
    naviView.tag = 100;
    naviView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:naviView];
    
    navlabel = [[UILabel alloc] init];
    navlabel.frame = CGRectMake(0, 0, 100, 40);
    navlabel.center = CGPointMake(KScreenSize.width/2, 64/2);
    navlabel.textAlignment = 1;
    [naviView addSubview:navlabel];
    navlabel.text = title;
    
    self.naviView = naviView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitleWithTitle:@""];
    
//    _hasHiding = NO;
    
}

- (NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray arrayWithObjects:@"花褪残红青杏小。燕子飞时，绿水人家绕。",@"枝上柳绵吹又少，天涯何处无芳草!", @"墙里秋千墙外道。墙外行人，墙里佳人笑。", @"笑渐不闻声渐悄，多情却被无情恼.",@"花褪残红青杏小。燕子飞时，绿水人家绕。",@"枝上柳绵吹又少，天涯何处无芳草!", @"墙里秋千墙外道。墙外行人，墙里佳人笑。", @"笑渐不闻声渐悄，多情却被无情恼.",nil];
    }
    return _dataSourceArray;
}
- (void)loadView
{
    [super loadView];
    _imageHeight = 160;//背景图片的高度
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.frame = CGRectMake(0, 64, KScreenSize.width, KScreenSize.height);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
//    self.tableView.contentInset = UIEdgeInsetsMake(_imageHeight, 0, 0, 0);
    
    [self createTableViewHeaderView];
    [self addfresh];
}

- (void)addfresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.header endRefreshing];
        });
    }];
    
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.footer endRefreshing];
            NSLog(@"没数据了");
        });
    }];
}
- (void)createTableViewHeaderView
{
    _tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, -_imageHeight, KScreenSize.width, _imageHeight)];
    _headerBackView = [[UIImageView alloc] init];
    //背景图
    _headerBackView.frame = CGRectMake(0, 0, KScreenSize.width, _imageHeight);
    _headerBackView.image = [UIImage imageNamed:@"backImg"];
    [_tableViewHeaderView addSubview:_headerBackView];
    
    _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenSize.width - 62)/2, 15, 62, 62)];
    [_tableViewHeaderView addSubview:_photoImageView];
    
    _photoImageView.layer.cornerRadius = 31;
    _photoImageView.layer.masksToBounds = YES;
    _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
    _photoImageView.autoresizesSubviews = YES;
    
    _photoImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    _photoImageView.image = [[UIImage imageNamed:@"userIcon"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _photoImageView.frame.origin.y + _photoImageView.frame.size.height + 8 , KScreenSize.width, 20 )];
    _userNameLabel.text = @"单元格林";
    
    _userNameLabel.textAlignment = 1;
    _userNameLabel.font = [UIFont systemFontOfSize:25];
    _userNameLabel.textColor = [UIColor whiteColor];
    [_tableViewHeaderView addSubview:_userNameLabel];
    
    
    
    _introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake((KScreenSize.width - 229 )/2, _userNameLabel.frame.origin.y + _userNameLabel.frame.size.height + 10 , 229 , 16 )];
    _introduceLabel.alpha = .7;
    _introduceLabel.text = @"人生若只如初见，何事秋风悲画扇";
    _introduceLabel.textAlignment = 1;
    _introduceLabel.font = [UIFont systemFontOfSize:12 ];
    _introduceLabel.textColor = _userNameLabel.textColor;
    [_tableViewHeaderView addSubview:self.introduceLabel];
    
    self.tableView.tableHeaderView = _tableViewHeaderView;
    
}

#pragma mark ---滚动代理---
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = self.view.frame.size.width;
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"偏移量：%lf", offsetY);
    
    if (offsetY <= 0) {
        CGFloat totalOffset = _imageHeight + ABS(offsetY);
        CGFloat scale = totalOffset/_imageHeight;
        _headerBackView.frame = CGRectMake(- (width * scale - width)/2, offsetY, width*scale, totalOffset);//拉伸后的图片的frame应该是同比例缩放。
        NSLog(@"坐标：%@", NSStringFromCGRect(self.headerBackView.frame));
    }
    
    CGFloat height = CGRectGetMaxY(self.userNameLabel.frame);
    if (offsetY > height) {
        
        [self.tableViewHeaderView removeFromSuperview];
        
        self.tableView.tableHeaderView = [[UIView alloc] init];
        self.tableView.frame = CGRectMake(0, 64, KScreenSize.width, KScreenSize.height-64);
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        
        [self setNaviTitleWithTitle:self.userNameLabel.text];
        
        if (!_hasHiding) {
            [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            _hasHiding = YES;
            return;
        }
    }
    
}

#pragma mark 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataSourceArray[indexPath.row];
    return cell;
}

#pragma mark ---行编辑--
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"移除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [_dataSourceArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    //设置收藏
    UITableViewRowAction *collectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        collectRowAction.backgroundColor = [UIColor greenColor];
    }];
    
    //设置置顶按钮
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [_dataSourceArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        NSIndexPath *firstPath = [NSIndexPath indexPathForItem:0 inSection:indexPath.section];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstPath];
//        [_tableView reloadData];
    }];
    
    //设置按钮的背景颜色
    topRowAction.backgroundColor = [UIColor blueColor];
    collectRowAction.backgroundColor = [UIColor grayColor];
    
    
    return @[deleteRowAction, collectRowAction, topRowAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
