//
//  MovieSearchResultVC.m
//  CareemTest
//
//  Created by Peigen.Liu on 2017/11/25.
//

#import "MovieSearchResultVC.h"
#import "MovieModel.h"
#import "MovieSearchResultTableViewCell.h"
#import "PullUpLoadMoreView.h"

@interface MovieSearchResultVC ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray<MovieModel*> *_resultArray;
    NSUInteger _currentPage;
    NSUInteger _maxResult;
    
    IBOutlet UITableView *_tableView;
    IBOutlet PullUpLoadMoreView *_pullUpFooter;
}

@end

@implementation MovieSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // First Load need init data
    [self initData];
    
    _tableView.estimatedRowHeight = 120.0f;
    
    // Set Footer hidden
    [_pullUpFooter setHidden:YES];
    
    // Set Self Title
    [self setTitle:[NSString stringWithFormat:@"Results of '%@'",self.query]];
    
    // Firstly load data
    [self loadMoreData];
}

- (void)initData{
    _resultArray = [NSMutableArray array];
    _currentPage = 0;
    _maxResult = -1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadMoreData{
    if (_resultArray.count >= _maxResult) {
        // No more data
        return;
    }
    
    [NetworkManager getMovieResultWithQuery:self.query WithPage:_currentPage+1 OnGetResultBack:^(NSInteger returnCode, SearchResult * _Nullable result) {
        if (returnCode == 200) {
            // Load success
            [_resultArray addObjectsFromArray:result.results];
            
            [_tableView reloadData];
            
            _currentPage++;
            
            _maxResult = result.total_results.unsignedIntegerValue;
            
            // Set Footer hidden
            [_pullUpFooter setHidden:YES];
        }else{
            // Error Handle
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Error" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (_resultArray.count == 0) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
            [alert addAction:okAction];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - TableView DataSource & Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieSearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieSearchResultTableViewCellId"];
    if (cell) {
        MovieModel *model = [_resultArray objectAtIndex:indexPath.row];
        
        [cell.titleLabel setText:[model title]];
        [cell.releaseDateLabel setText:[model releaseDate]];
        [cell.overviewLabel setText:[[model overview] length] == 0? @"\n\n" : [model overview]];
        
        
        // Download Thumbnail First
        [cell.posterImageView sd_setImageWithURL:[NSURL URLWithString:[model getPosterThumbnailURLString]] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            // Download full scale image
            [cell.posterImageView sd_setImageWithURL:[NSURL URLWithString:[model getPosterThumbnailURLString]] placeholderImage:image];
        }];
        

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return _pullUpFooter;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIScrollView Delegate
bool shouldLoadMoreWhenTouchUp = NO;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat contenOffsetY = scrollView.contentOffset.y;
    
    // if table view has no data yet then return.
    if (_resultArray.count == 0 || _resultArray.count >= _maxResult){
        return;
    }
    
    // Calculator offset
    CGFloat targetContentOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.frame.size.height - _pullUpFooter.frame.size.height;
    
    // if offset >= latest cell + 100.0f
    if (contenOffsetY >= targetContentOffsetY + 100.0f) {
        [_pullUpFooter.label setText:@"Release to Load More"];
        shouldLoadMoreWhenTouchUp = YES;

        return;
    }
    
    
    // if offset >= latest cell
    if (contenOffsetY >= targetContentOffsetY){
        _pullUpFooter.hidden = NO;
        shouldLoadMoreWhenTouchUp = NO;
        [_pullUpFooter.label setText:@"Pull Up to Load More"];
        [_pullUpFooter.indicatorView setHidden:YES];
    }
    

}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (shouldLoadMoreWhenTouchUp) {
        [_pullUpFooter.indicatorView setHidden:NO];
        [_pullUpFooter.label setText:@"Loading More..."];

        [self loadMoreData];
    }
    
    shouldLoadMoreWhenTouchUp = NO;
}

@end
