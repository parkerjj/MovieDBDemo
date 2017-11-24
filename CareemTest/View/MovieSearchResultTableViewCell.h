//
//  MovieSearchResultTableViewCell.h
//  CareemTest
//
//  Created by Peigen.Liu on 2017/11/25.
//

#import <UIKit/UIKit.h>

@interface MovieSearchResultTableViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UIImageView    *posterImageView;
@property (nonatomic,weak) IBOutlet UILabel        *titleLabel;
@property (nonatomic,weak) IBOutlet UILabel        *releaseDateLabel;
@property (nonatomic,weak) IBOutlet UILabel        *overviewLabel;


@end
