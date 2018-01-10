//
//  VHLRiskEvaluationViewController.m
//  VHLRiskEvaluation
//
//  Created by Vincent on 2018/1/8.
//  Copyright © 2018年 Darnel Studio. All rights reserved.
//

#import "VHLRiskEvaluationViewController.h"
// View
#import "VHLRiskEvaluationTopStepView.h"
#import "VHLRiskEvaluationQuestionView.h"
//
#import "UIView+VHLAdd.h"

@interface VHLRiskEvaluationViewController ()<VHLRiskEvaluationQuestionViewDelegate>

@property (nonatomic, strong) VHLRiskEvaluationTopStepView *topStepView;
@property (nonatomic, strong) UIScrollView *contentScrollView;

@end

@implementation VHLRiskEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    //
    _topStepView = [[VHLRiskEvaluationTopStepView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    [self.view addSubview:_topStepView];
    
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.width, self.view.height - 60 - 40 - self.navigationController.navigationBar.height - [UIApplication sharedApplication].statusBarFrame.size.height)];
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.bounces = NO;
    _contentScrollView.scrollEnabled = NO;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_contentScrollView];
    //
    CGFloat contentWidth = self.contentScrollView.width;
    for (int i = 0; i < self.questionArray.count; i++) {
        CGRect qrect = CGRectMake(i*contentWidth + 16, 0, contentWidth - 32, self.contentScrollView.height);
        VHLRiskEvaluationQuestionView *questionView = [[VHLRiskEvaluationQuestionView alloc] initWithFrame:qrect questionModel:self.questionArray[i]];
        questionView.index = i;
        if (i == self.questionArray.count - 1) {
            questionView.isLast = YES;
        }
        questionView.delegate = self;
        [self.contentScrollView addSubview:questionView];
    }
    self.contentScrollView.contentSize = CGSizeMake(self.view.width * self.questionArray.count, self.contentScrollView.height);
    //
    [self upQuestionClick:nil cIndex:-1];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma Delegate - VHLRiskEvaluationQuestionViewDelegate
- (void)updateQuestion:(VHLRiskEvaluationModel *)questionModel cIndex:(int)index {
    int totalScore = 0;
    for (VHLRiskEvaluationAnswerModel *answerModel in questionModel.answers) {
        if (answerModel.isSelected) {
            totalScore += answerModel.score;
        }
    }
    questionModel.totalScore = totalScore;
    self.questionArray[index] = questionModel;
}
- (void)upQuestionClick:(VHLRiskEvaluationModel *)questionModel cIndex:(int)index{
    int tempValue = (index > 0 ? index - 1 : 0);
    VHLRiskEvaluationModel *leftQuestionModel = self.questionArray[tempValue];
    VHLRiskEvaluationModel *rightQuestionModel = [self.questionArray lastObject];
    NSString *leftStr = [NSString stringWithFormat:@"%ld", leftQuestionModel.index];
    NSString *rightStr = [NSString stringWithFormat:@"%ld", rightQuestionModel.index];
    [self.topStepView setLeftValue:leftStr rightValue:rightStr progress:(tempValue + 1) / (CGFloat)self.questionArray.count pAnimation:(index < 0?NO:YES)];
    //
   [self.contentScrollView setContentOffset:CGPointMake(self.contentScrollView.width * tempValue, 0) animated:YES];
}
- (void)nextQuestionClick:(VHLRiskEvaluationModel *)questionModel cIndex:(int)index{
    if (index >= self.questionArray.count - 1) {
        // 点击完成
        if ([self.delegate respondsToSelector:@selector(riskEvaluationFinish:vc:)]) {
            __weak typeof(self) weakSelf = self;
            [self.delegate riskEvaluationFinish:self.questionArray vc:weakSelf];
        }
        return;
    }
    VHLRiskEvaluationModel *leftQuestionModel = self.questionArray[index + 1];
    VHLRiskEvaluationModel *rightQuestionModel = [self.questionArray lastObject];
    NSString *leftStr = [NSString stringWithFormat:@"%ld", leftQuestionModel.index];
    NSString *rightStr = [NSString stringWithFormat:@"%ld", rightQuestionModel.index];
    [self.topStepView setLeftValue:leftStr rightValue:rightStr progress:((index + 1) + 1) / (CGFloat)self.questionArray.count pAnimation:YES];
    //
    [self.contentScrollView setContentOffset:CGPointMake(self.contentScrollView.width * (index + 1), 0) animated: YES];
}

@end
