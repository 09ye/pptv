//
//  BestScrollView.m
//  crowdfunding-arcturus
//
//  Created by lqh77 on 14-5-13.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import "BestScrollView.h"

 

@implementation BestScrollView

@synthesize  animationTimer,imageArray,myTimer;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //是否自动播放
        animationTimer =YES;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
 
        CGRect  rect =CGRectMake(500,280, 50, 50);
        _pageControl = [[UIPageControl alloc] initWithFrame:rect];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [self addSubview:_pageControl];
        
        _curPage = 0;
        _pageControl.currentPage=_curPage;
    
//
    }
    return self;
}

-(void)showImageArray:(NSMutableArray  *)arr  withAnimation:(BOOL)animation{

    animationTimer=YES;
   myTimer=[NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];

}



-(IBAction)pageTurn:(int )indexNum
{
    self.pageControl.currentPage=indexNum-1;
    
    int pageNum=self.pageControl.currentPage;
    
    CGSize viewSize=self.scrollView.frame.size;
    
    [self.scrollView setContentOffset:CGPointMake((pageNum+1)*viewSize.width, 0)];
    
    NSLog(@"myscrollView.contentOffSet.x==%f",self.scrollView.contentOffset.x);
    NSLog(@"pageControl currentPage==%d",self.pageControl.currentPage);
    
    myTimer=[NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
}


-(void)scrollToNextPage:(id)sender{
    
    if (animationTimer) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x+1024 , 0) animated:YES];
        [self scrollViewDidScroll:self.scrollView];
    } 
}


- (void)setDataource:(id<BestScrollViewDatasource>)datasource
{
    _datasource = datasource;
    
    if (!animationTimer) {
        
        return;
    }
    
    [self reloadData];
}

- (void)reloadData
{
    _totalPages = [_datasource numberOfPages];
    if (_totalPages == 0) {
        return;
    }
    _pageControl.numberOfPages = _totalPages;
    [self loadData];
}

- (void)loadData
{
    if (!animationTimer) {
        
        return;
    }
    _pageControl.currentPage = _curPage;
    
    //从scrollView上移除所有的subview
    NSArray *subViews = [_scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    if(!_datasource){
    
        return;
    }
    if(!_delegate){
        
        return;
    }
    [self getDisplayImagesWithCurpage:_curPage];
    
    for (int i = 0; i < 3; i++) {
        UIView *v = [_curViews objectAtIndex:i];
        v.userInteractionEnabled = YES;
        __autoreleasing UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleTap:)];
        [v addGestureRecognizer:singleTap];
        
        v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
        [_scrollView addSubview:v];
    }
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

- (void)getDisplayImagesWithCurpage:(int)page {
    
    if (!animationTimer) {
        
        return;
    }
    
    if (self) {
        int pre = [self validPageValue:_curPage-1];
        int last = [self validPageValue:_curPage+1];
        
        if (!_curViews) {
            _curViews = [[NSMutableArray alloc] init];
        }
        
        [_curViews removeAllObjects];
        
        
        if (_datasource) {
            
            [_curViews addObject:[_datasource pageAtIndex:pre]];
            [_curViews addObject:[_datasource pageAtIndex:page]];
            [_curViews addObject:[_datasource pageAtIndex:last]];
        }

        
    } 
    
    
}

- (int)validPageValue:(NSInteger)value {
    
    if(value == -1) value = _totalPages - 1;
    if(value == _totalPages) value = 0;
    
    return value;
    
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [_delegate didClickPage:self atIndex:_curPage];
    }
    
}

- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index
{
    if (index == _curPage) {
        [_curViews replaceObjectAtIndex:1 withObject:view];
        for (int i = 0; i < 3; i++) {
            UIView *v = [_curViews objectAtIndex:i];
            v.userInteractionEnabled = YES;
            __autoreleasing UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(handleTap:)];
            [v addGestureRecognizer:singleTap];
         
            v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
            [_scrollView addSubview:v];
        }
    }
}




#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    
    if (!animationTimer) {
    
        return;
    }
    
    int x = aScrollView.contentOffset.x;
    
    //往下翻一张
    if(x >= (2*self.frame.size.width)) {
        _curPage = [self validPageValue:_curPage+1];
        [self loadData];
    }
    
    //往上翻
    if(x <= 0) {
        _curPage = [self validPageValue:_curPage-1];
        [self loadData];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:YES];
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
   
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
 
}

@end
