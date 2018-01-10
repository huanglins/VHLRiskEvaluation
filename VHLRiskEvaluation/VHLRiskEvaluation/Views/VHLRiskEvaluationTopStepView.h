//
//  VHLRiskEvaluationStepView.h
//  VHLRiskEvaluation
//
//  Created by Vincent on 2018/1/9.
//  Copyright © 2018年 Darnel Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VHLRiskEvaluationTopStepView : UIView

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIProgressView *progressView;

//
- (void)setLeftValue:(NSString *)leftValue rightValue:(NSString *)rightValue progress:(CGFloat)progressValue pAnimation:(BOOL)isAnimation;

@end
