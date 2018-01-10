//
//  VHLRiskEvaluationResultViewController.h
//  VHLRiskEvaluation
//
//  Created by Vincent on 2018/1/10.
//  Copyright © 2018年 Darnel Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHLRiskEvaluationModel.h"

@class VHLRiskEvaluationResultViewController;
@protocol VHLRiskEvaluationResultViewControllerDelegate<NSObject>

- (void)restartRiskEvaluation:(NSMutableArray<VHLRiskEvaluationModel *> *)questionArray vc:(VHLRiskEvaluationResultViewController *)riskResultVC;

@end

/**
    风险评测结果页
 */
@interface VHLRiskEvaluationResultViewController : UIViewController

@property (nonatomic, strong) NSMutableArray<VHLRiskEvaluationModel *> *questionArray; // 问题数组
@property (nonatomic, weak) id<VHLRiskEvaluationResultViewControllerDelegate> delegate;

/** 当前风险测试得分*/
- (void)setScore:(int)score;

@end
