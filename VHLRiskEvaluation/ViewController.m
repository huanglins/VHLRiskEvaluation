//
//  ViewController.m
//  VHLRiskEvaluation
//
//  Created by Vincent on 2018/1/8.
//  Copyright © 2018年 Darnel Studio. All rights reserved.
//

#import "ViewController.h"
#import "VHLRiskEvaluationViewController.h"
#import "VHLRiskEvaluationResultViewController.h"
//
#import "VHLNavigation.h"

@interface ViewController () <VHLRiskEvaluationViewControllerDelegate, VHLRiskEvaluationResultViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"风险评测";
    [self vhl_setNavBackgroundColor:[UIColor colorWithRed:0.18 green:0.25 blue:0.39 alpha:1.00]];
    [self vhl_setNavBarTitleColor:[UIColor whiteColor]];
    [self vhl_setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIButton *goButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [goButton setTitle:@"风险评测" forState:UIControlStateNormal];
    [goButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:goButton];
    goButton.center = self.view.center;
    [goButton addTarget:self action:@selector(goDT) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *goButton1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 180, 100)];
    [goButton1 setTitle:@"风险评测结果" forState:UIControlStateNormal];
    [goButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:goButton1];
    goButton1.center = CGPointMake(self.view.center.x, self.view.center.y + 80);
    [goButton1 addTarget:self action:@selector(goDT1) forControlEvents:UIControlEventTouchUpInside];
}
- (void)goDT {
    NSMutableArray *array = [VHLRiskEvaluationModel modelArrayWithDicArray:[self modelData]];
    VHLRiskEvaluationViewController *riskVC = [[VHLRiskEvaluationViewController alloc] init];
    riskVC.questionArray = array;
    riskVC.title = @"风险评测";
    riskVC.delegate = self;
    [riskVC vhl_setNavBackgroundColor:[UIColor colorWithRed:0.18 green:0.25 blue:0.39 alpha:1.00]];
    [riskVC vhl_setNavBarTitleColor:[UIColor whiteColor]];
    [riskVC vhl_setStatusBarStyle:UIStatusBarStyleLightContent];
    [riskVC vhl_setNavBarTintColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:riskVC animated:YES];
}

- (void)goDT1 {
    VHLRiskEvaluationResultViewController *riskResultVC = [[VHLRiskEvaluationResultViewController alloc] init];
    [riskResultVC vhl_setNavBackgroundColor:[UIColor colorWithRed:0.18 green:0.25 blue:0.39 alpha:1.00]];
    [riskResultVC vhl_setNavBarTitleColor:[UIColor whiteColor]];
    [riskResultVC vhl_setStatusBarStyle:UIStatusBarStyleLightContent];
    [riskResultVC vhl_setNavBarTintColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:riskResultVC animated:YES];
}
#pragma mark - delegate
- (void)riskEvaluationFinish:(NSMutableArray<VHLRiskEvaluationModel *> *)questionArray vc:(VHLRiskEvaluationViewController *)reVC{
    
    int sumScore = 0;
    for (VHLRiskEvaluationModel *model in questionArray) {
        sumScore += model.totalScore;
    }
    // NSLog(@"%f", sumScore);
    VHLRiskEvaluationResultViewController *riskResultVC = [[VHLRiskEvaluationResultViewController alloc] init];
    [riskResultVC vhl_setNavBackgroundColor:[UIColor colorWithRed:0.18 green:0.25 blue:0.39 alpha:1.00]];
    [riskResultVC vhl_setNavBarTitleColor:[UIColor whiteColor]];
    [riskResultVC vhl_setStatusBarStyle:UIStatusBarStyleLightContent];
    [riskResultVC vhl_setNavBarTintColor:[UIColor whiteColor]];
    [riskResultVC setScore:35];
    riskResultVC.questionArray = questionArray;
    
    riskResultVC.delegate = self;
    
    // pop 再 push
    NSMutableArray *arrView = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    int index = (int)[arrView indexOfObject:reVC];
    [arrView removeObjectAtIndex:index];
    [arrView addObject:riskResultVC];
    [self.navigationController setViewControllers:arrView animated:YES];
}
- (void)restartRiskEvaluation:(NSMutableArray<VHLRiskEvaluationModel *> *)questionArray vc:(VHLRiskEvaluationResultViewController *)riskResultVC {
    NSMutableArray *array = [VHLRiskEvaluationModel modelArrayWithDicArray:[self modelData]];
    VHLRiskEvaluationViewController *riskVC = [[VHLRiskEvaluationViewController alloc] init];
    riskVC.questionArray = questionArray?:array;
    riskVC.title = @"风险评测";
    riskVC.delegate = self;
    [riskVC vhl_setNavBackgroundColor:[UIColor colorWithRed:0.18 green:0.25 blue:0.39 alpha:1.00]];
    [riskVC vhl_setNavBarTitleColor:[UIColor whiteColor]];
    [riskVC vhl_setStatusBarStyle:UIStatusBarStyleLightContent];
    [riskVC vhl_setNavBarTintColor:[UIColor whiteColor]];
    
    // pop 再 push
    NSMutableArray *arrView = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    int index = (int)[arrView indexOfObject:riskResultVC];
    [arrView removeObjectAtIndex:index];
    [arrView addObject:riskVC];
    [self.navigationController setViewControllers:arrView animated:YES];
}
// ------------------------------------------------------------------------
/**
    答题信息
 */
- (NSArray *)modelData {
    NSArray *arr = @[@{@"index": @1,
                       @"question":@"若有临时且非预期的事件发生时，您的备用金 相当于您几个月的家庭开销？（这些备用金属于可随时动用的存款）",
                       @"answers": @[
                               @{@"answerTitle":@"高中中专或以下",@"isSelected":@(NO),@"score": @1},
                              @{@"answerTitle":@"专科/大学",@"isSelected":@(NO),@"score": @2},
                              @{@"answerTitle":@"研究生以上",@"isSelected":@(NO),@"score": @3},
                              ]},
                     @{@"index": @2,
                       @"question":@"您的婚姻状况",
                       @"maxSelectCount": @(3),
                       @"answers": @[
                               @{@"answerTitle":@"未婚",@"isSelected":@(NO),@"score": @2},
                               @{@"answerTitle":@"已婚无子女",@"isSelected":@(NO),@"score": @1},
                               @{@"answerTitle":@"已婚有子女",@"isSelected":@(NO),@"score": @1},
                               @{@"answerTitle":@"已婚有子女",@"isSelected":@(NO),@"score": @1},
                               ]}
                     ];
    return arr;
}
/**
 
 ,
 @{@"index": @3,
 @"question":@"您的工作是",
 @"maxSelectCount": @(3),
 @"answers": @[
 @{@"answerTitle":@"企业负责人/企业主",@"isSelected":@(NO)},
 @{@"answerTitle":@"专业技术人员",@"isSelected":@(NO)},
 @{@"answerTitle":@"高/中阶主管",@"isSelected":@(NO)},
 @{@"answerTitle":@"劳动工作者",@"isSelected":@(NO)},
 @{@"answerTitle":@"一般职员",@"isSelected":@(NO)},
 @{@"answerTitle":@"家庭主妇",@"isSelected":@(NO)},
 @{@"answerTitle":@"基层主管",@"isSelected":@(NO)},
 @{@"answerTitle":@"学生",@"isSelected":@(NO)},
 @{@"answerTitle":@"退休",@"isSelected":@(NO)},
 @{@"answerTitle":@"其他",@"isSelected":@(NO)},
 ]},
 @{@"index": @4,
 @"question":@"您的家庭平均收入是",
 @"answers": @[
 @{@"answerTitle":@"10万以下",@"isSelected":@(NO)},
 @{@"answerTitle":@"10-20万",@"isSelected":@(NO)},
 @{@"answerTitle":@"20-50万",@"isSelected":@(NO)},
 @{@"answerTitle":@"50-100万",@"isSelected":@(NO)},
 @{@"answerTitle":@"100万以上",@"isSelected":@(NO)},
 ]},
 @{@"index": @5,
 @"question":@"您通过网络获取信息的情况",
 @"answers": @[
 @{@"answerTitle":@"经常",@"isSelected":@(NO)},
 @{@"answerTitle":@"时常",@"isSelected":@(NO)},
 @{@"answerTitle":@"偶尔",@"isSelected":@(NO)},
 @{@"answerTitle":@"从不",@"isSelected":@(NO),@"score": @5},
 ]},
 @{@"index": @6,
 @"question":@"您的投资资金来源",
 @"answers": @[
 @{@"answerTitle":@"薪水/固定收入",@"isSelected":@(NO)},
 @{@"answerTitle":@"退休金",@"isSelected":@(NO)},
 @{@"answerTitle":@"闲置资金",@"isSelected":@(NO)},
 @{@"answerTitle":@"投资收益",@"isSelected":@(NO)},
 @{@"answerTitle":@"其他基金公司转入",@"isSelected":@(NO)},
 @{@"answerTitle":@"其他",@"isSelected":@(NO)},
 ]},
 @{@"index": @7,
 @"question":@"您互联网熟悉情况",
 @"answers": @[
 @{@"answerTitle":@"非常熟悉",@"isSelected":@(NO)},
 @{@"answerTitle":@"熟悉",@"isSelected":@(NO)},
 @{@"answerTitle":@"不太熟悉",@"isSelected":@(NO)},
 @{@"answerTitle":@"从未接触",@"isSelected":@(NO)},
 ]},
 @{@"index": @8,
 @"question":@"您互联网熟悉情况",
 @"answers": @[
 @{@"answerTitle":@"非常熟悉",@"isSelected":@(NO)},
 @{@"answerTitle":@"熟悉",@"isSelected":@(NO)},
 @{@"answerTitle":@"不太熟悉",@"isSelected":@(NO)},
 @{@"answerTitle":@"从未接触",@"isSelected":@(NO)},
 ]},
 @{@"index": @9,
 @"question":@"您互联网熟悉情况",
 @"answers": @[
 @{@"answerTitle":@"非常熟悉",@"isSelected":@(NO)},
 @{@"answerTitle":@"熟悉",@"isSelected":@(NO)},
 @{@"answerTitle":@"不太熟悉",@"isSelected":@(NO)},
 @{@"answerTitle":@"从未接触",@"isSelected":@(NO)},
 ]},
 @{@"index": @10,
 @"question":@"您互联网熟悉情况",
 @"answers": @[
 @{@"answerTitle":@"非常熟悉",@"isSelected":@(NO)},
 @{@"answerTitle":@"熟悉",@"isSelected":@(NO)},
 @{@"answerTitle":@"不太熟悉",@"isSelected":@(NO)},
 @{@"answerTitle":@"从未接触",@"isSelected":@(NO)},
 ]},
 */

@end
