//
//  LocationTableViewCell.h
//  WeChat
//
//  Created by hebiao on 15/7/29.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *tagImageView;
@property (strong, nonatomic) IBOutlet UILabel *tagNameLabel;

@property (retain, nonatomic) IBOutlet UILabel *dateAndTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *latAndLotLabel;
@property (retain, nonatomic) IBOutlet UILabel *locationLabel;

@end
