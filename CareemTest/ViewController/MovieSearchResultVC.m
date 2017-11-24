//
//  MovieSearchResultVC.m
//  CareemTest
//
//  Created by Peigen.Liu on 2017/11/25.
//

#import "MovieSearchResultVC.h"
#import "MovieModel.h"
#import "MovieSearchResultTableViewCell.h"

@interface MovieSearchResultVC ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray<MovieModel*> *_resultArray;
    NSUInteger _currentPage;
    NSUInteger _maxResult;
    
    IBOutlet UITableView *_tableView;
}

@end

@implementation MovieSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // First Load need init data
    [self initData];
    
    _tableView.estimatedRowHeight = 120.0f;

    
    // Firstly load data
    [self loadMoreData];
}

- (void)initData{
    _resultArray = [NSMutableArray array];
    _currentPage = 1;
    _maxResult = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadMoreData{
    [[NetworkManager defaultManager] getMovieResultWithQuery:self.query WithPage:_currentPage+1 OnGetResultBack:^(NSInteger returnCode, SearchResult * _Nullable result) {
        if (returnCode == 200) {
            // Load success
            [_resultArray addObjectsFromArray:result.results];
            
            [_tableView reloadData];
        }else{
            // Error Handle
            
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
        [cell.titleLabel setText:[[_resultArray objectAtIndex:indexPath.row] title]];
        [cell.releaseDateLabel setText:[[_resultArray objectAtIndex:indexPath.row] releaseDate]];
        [cell.overviewLabel setText:[[_resultArray objectAtIndex:indexPath.row] overview]];

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}


@end
