//
//  VHLRiskEvaluationQuestionView.h
//  VHLRiskEvaluation
//
//  Created by Vincent on 2018/1/10.
//  Copyright © 2018年 Darnel Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHLRiskEvaluationModel.h"

@protocol VHLRiskEvaluationQuestionViewDelegate <NSObject>

- (void)updateQuestion:(VHLRiskEvaluationModel *)questionModel cIndex:(int)index;
/** 上一题/下一题点击*/
- (void)upQuestionClick:(VHLRiskEvaluationModel *)questionModel cIndex:(int)index;
- (void)nextQuestionClick:(VHLRiskEvaluationModel *)questionModel cIndex:(int)index;

@end

/**
    单个问题面板
 */
@interface VHLRiskEvaluationQuestionView : UIView

- (instancetype)initWithFrame:(CGRect)frame questionModel:(VHLRiskEvaluationModel *)questionModel;

@property (nonatomic, strong) VHLRiskEvaluationModel *questionModel;
@property (nonatomic, weak) id<VHLRiskEvaluationQuestionViewDelegate> delegate;

@property (nonatomic, assign) int index;         // 当前问题下标
@property (nonatomic, assign) BOOL isLast;       // 是否是最后一个问题

@end
