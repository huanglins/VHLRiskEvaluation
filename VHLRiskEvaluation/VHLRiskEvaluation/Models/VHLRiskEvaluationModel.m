//
//  VHLRiskEvaluationModel.m
//  VHLRiskEvaluation
//
//  Created by Vincent on 2018/1/8.
//  Copyright © 2018年 Darnel Studio. All rights reserved.
//

#import "VHLRiskEvaluationModel.h"

/** 单个问题 - 单个问题选项*/
@implementation VHLRiskEvaluationAnswerModel

/** 初始化方法*/
- (instancetype)initWithDic:(NSDictionary *)answerDic {
    if (self = [super init]) {
        if (self = [super init]) {
            self.answerTitle = [answerDic objectForKey:@"answerTitle"];
            self.isSelected = [[answerDic objectForKey:@"isSelected"] boolValue];
            self.score = [[answerDic objectForKey:@"score"] intValue];
        }
    }
    return self;
}
+ (instancetype)modelWithDic:(NSDictionary *)answerDic {
    return [[self alloc] initWithDic:answerDic];
}
+ (NSArray *)modelArrayWithArray:(NSArray *)dicArray {
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSDictionary *answerDic in dicArray) {
        [modelArray addObject:[VHLRiskEvaluationAnswerModel modelWithDic:answerDic]];
    }
    return modelArray;
}

@end
// ------------------------------------------------------------------------------
/** 单个问题*/
@implementation VHLRiskEvaluationModel

/** 初始化方法 */
- (instancetype)initWithDic:(NSDictionary *)dataDic {
    if (self = [super init]) {
        /** -*- 这里扩展属性  -*- */
        self.index = [[dataDic objectForKey:@"index"] integerValue];    // 下标
        self.question = [dataDic objectForKey:@"question"]?:@"";        // 标题
        self.maxSelectCount = [[dataDic objectForKey:@"maxSelectCount"] intValue];
        // 问题列表
        self.answers = [[NSMutableArray alloc] init];
        NSMutableArray *cellArray = [dataDic objectForKey:@"answers"];
        for (NSDictionary *dic in cellArray) {
            VHLRiskEvaluationAnswerModel *cellModel =  [[VHLRiskEvaluationAnswerModel alloc] initWithDic:dic];
            [self.answers addObject:cellModel];
        }
        //
        if (self.maxSelectCount < 1) self.maxSelectCount = 1;
        if (self.maxSelectCount > self.answers.count) self.maxSelectCount = (int) self.answers.count;
    }
    return self;
}
+ (instancetype)modelWithDic:(NSDictionary *)dataDic {
    return [[self alloc] initWithDic:dataDic];
}
+ (NSMutableArray *)modelArrayWithDicArray:(NSArray *)dataDicArray {
    NSMutableArray *modelArray = [NSMutableArray array];
    
    for (NSDictionary *dataDic in dataDicArray) {
        [modelArray addObject:[VHLRiskEvaluationModel modelWithDic:dataDic]];
    }
    
    return modelArray;
}

@end


