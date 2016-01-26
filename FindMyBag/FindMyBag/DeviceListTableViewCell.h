//
//  DeviceListTableViewCell.h
//  FindMyBag
//
//  Created by hebiao on 15/7/30.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iTagImageView;
@property (strong, nonatomic) IBOutlet UILabel *iTagLabel;
@property (strong, nonatomic) IBOutlet UILabel *connectedStatusLabel;


@end
