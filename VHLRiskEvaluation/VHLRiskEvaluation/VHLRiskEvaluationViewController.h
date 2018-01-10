//
//  VHLRiskEvaluationViewController.h
//  VHLRiskEvaluation
//
//  Created by Vincent on 2018/1/8.
//  Copyright © 2018年 Darnel Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHLRiskEvaluationModel.h"

@class VHLRiskEvaluationViewController;
@protocol VHLRiskEvaluationViewControllerDelegate<NSObject>

// 答题完成点击
- (void)riskEvaluationFinish:(NSMutableArray<VHLRiskEvaluationModel *> *)questionArray vc:(VHLRiskEvaluationViewController *)reVC;

@end

@interface VHLRiskEvaluationViewController : UIViewController

@property (nonatomic, strong) NSMutableArray<VHLRiskEvaluationModel *> *questionArray; // 问题数组

@property (nonatomic, weak) id<VHLRiskEvaluationViewControllerDelegate> delegate;

@end
