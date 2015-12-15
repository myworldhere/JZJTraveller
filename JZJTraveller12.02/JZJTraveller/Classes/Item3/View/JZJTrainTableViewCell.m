//
//  JZJTrainTableViewCell.m
//  JZJTraveller
//
//  Created by tarena on 15/12/15.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "JZJTrainTableViewCell.h"
#import "JZJTrain.h"
@interface JZJTrainTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *trainNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *startingStationLabel;
@property (weak, nonatomic) IBOutlet UILabel *trainTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationStationLabel;
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
}
@end
