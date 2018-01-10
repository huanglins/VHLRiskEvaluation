//
//  VHLRiskAnswerCell.m
//  VHLRiskEvaluation
//
//  Created by Vincent on 2018/1/10.
//  Copyright © 2018年 Darnel Studio. All rights reserved.
//

#import "VHLRiskAnswerCell.h"

@interface VHLRiskAnswerCell()

@property (nonatomic, strong) UIView *selectBGView;

@end

@implementation VHLRiskAnswerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
        UIView *cellSelectBGView = [[UIView alloc] initWithFrame:self.bounds];
        cellSelectBGView.backgroundColor = [UIColor colorWithRed:0.91 green:0.92 blue:0.95 alpha:1.00];
        self.selectedBackgroundView = cellSelectBGView;
        
        self.selectBGView = [[UIView alloc] initWithFrame:self.bounds];
        self.selectBGView.backgroundColor = [UIColor colorWithRed:0.91 green:0.92 blue:0.95 alpha:1.00];
        [self.contentView addSubview:self.selectBGView];
        self.selectBGView.hidden = YES;
        // 
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1.00];
        
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vhl_answer_selected_0"]];
    }
    return self;
}

- (void)setAnswerModel:(VHLRiskEvaluationAnswerModel *)answerModel {
    _answerModel = answerModel;
    
    self.textLabel.text = answerModel.answerTitle;
    self.selectBGView.hidden = !answerModel.isSelected;
    if (answerModel.isSelected) {
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vhl_answer_selected_1"]];
    } else {
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vhl_answer_selected_0"]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
