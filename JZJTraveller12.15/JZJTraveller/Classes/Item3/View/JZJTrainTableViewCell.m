//
//  JZJTrainTableViewCell.m
//  JZJTraveller
//
//  Created by tarena on 15/12/15.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "JZJTrainTableViewCell.h"
#include "JZJSeatInfosTableViewCell.h"
#import "JZJTrain.h"
@interface JZJTrainTableViewCell ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UILabel *trainNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *startingStationLabel;
@property (weak, nonatomic) IBOutlet UILabel *trainTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationStationLabel;
@property (weak, nonatomic) IBOutlet UITableView *seatsInfoTableView;
@property (nonatomic ,strong) NSArray *allseats;

@end
@implementation JZJTrainTableViewCell

-(void)setTrainInfo:(JZJTrain *)trainInfo
{
    _trainInfo=trainInfo;
    self.trainNoLabel.text=_trainInfo.trainNo;
    self.startTimeLabel.text=_trainInfo.startTime;
    self.startingStationLabel.text=_trainInfo.from;
    self.trainTypeLabel.text=_trainInfo.trainType;
    self.durationLabel.text=_trainInfo.duration;
    self.endTimeLabel.text=_trainInfo.endTime;
    self.destinationStationLabel.text=_trainInfo.to;
    self.allseats = _trainInfo.seatInfos;
    
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.allseats.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JZJSeatInfosTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"seatCell"forIndexPath:indexPath];

    cell.seatInfo = self.allseats[indexPath.row];
    return cell;
}

/**
 *   设置图片箭头旋转
 */
-(void)setArrowImageViewWhitIfUnfold:(BOOL)unfold
{
    
    double degree;
    if(unfold ){
        degree = M_PI;
    }
    else{
        degree = 0;
    }
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _arrowImageView.layer.transform = CATransform3DMakeRotation(degree, 0, 0, 1);
    } completion:NULL];
    
}



@end
