//
//  JZJTableViewCell.m
//  JZJTraveller
//
//  Created by 麦沃德赫尔 on 15/12/1.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "JZJTableViewCell.h"
#import "JZJBooks.h"
#import "UIImageView+WebCache.h"
@interface JZJTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
//@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *userheadImageView;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *routeDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
//@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *viewCountLabel;
//@property (weak, nonatomic) IBOutlet UILabel *commentLabel;


@end
@implementation JZJTableViewCell
-(void)setBook:(JZJBooks *)book
{
    _book=book;
    self.titleLabel.text=_book.title;
    self.descriptionLabel.text=_book.text;
    self.startTimeLabel.text=_book.startTime;
    self.routeDaysLabel.text=[NSString stringWithFormat:@"%@天",_book.routeDays];
//    self.viewCountLabel.text=[NSString stringWithFormat:@"%@",_book.viewCount];
//    self.commentLabel.text=[NSString stringWithFormat:@"%@",_book.commentCount];
//    self.usernameLabel.text=_book.userName;
//    self.likeLabel.text=[NSString stringWithFormat:@"%@",_book.likeCount];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_book.headImage] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
//    [self.userheadImageView sd_setImageWithURL:[NSURL URLWithString:_book.userHeadImg] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
}

@end
