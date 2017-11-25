//
//  MovieSearchResultTableViewCell.m
//  CareemTest
//
//  Created by Peigen.Liu on 2017/11/25.
//

#import "MovieSearchResultTableViewCell.h"
#import "MovieModel.h"

#define kDefaultHeight 150.0f;

@implementation MovieSearchResultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_posterImageView.layer setCornerRadius:4.0f];
    [_posterImageView setClipsToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
