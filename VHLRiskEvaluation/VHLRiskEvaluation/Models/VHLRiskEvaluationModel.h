//
//  VHLRiskEvaluationModel.h
//  VHLRiskEvaluation
//
//  Created by Vincent on 2018/1/8.
//  Copyright © 2018年 Darnel Studio. All rights reserved.
//


#import <Foundation/Foundation.h>

/** 风险评估 - 答题信息 - 问题选项*/
@interface VHLRiskEvaluationAnswerModel : NSObject

@property (nonatomic, strong) NSString *answerTitle;            // 选项名称
@property (nonatomic, assign) BOOL isSelected;                  // 是否被选中
@property (nonatomic, assign) int score;                        // 该选项分数

/** 初始化方法  @{@"answerTitle":@"问题选项内容",@"isSelected":@(NO)} */
- (instancetype)initWithDic:(NSDictionary *)answerDic;
+ (instancetype)modelWithDic:(NSDictionary *)answerDic;
+ (NSMutableArray *)modelArrayWithArray:(NSArray *)dicArray;           // 字典数组初始化

@end
// ------------------------------------------------------------------------------
/** 风险评估 - 单个答题信息*/
@interface VHLRiskEvaluationModel : NSObject

@property (nonatomic, assign) NSInteger index;                  // 下标
@property (nonatomic, strong) NSString *question;               // 问题名称
@property (nonatomic, assign) int maxSelectCount;               // 最多可选
@property (nonatomic, assign) int totalScore;                   // 该问题得分
@property (nonatomic, strong) NSMutableArray<VHLRiskEvaluationAnswerModel *> *answers;// 问题选项列表

/** 初始化方法 */
- (instancetype)initWithDic:(NSDictionary *)dataDic;
+ (instancetype)modelWithDic:(NSDictionary *)dataDic;
+ (NSMutableArray *)modelArrayWithDicArray:(NSArray *)dataDicArray;

@end


