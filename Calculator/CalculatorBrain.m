//
//  CalculatorBrain.m
//  Calculator
//
//  Created by EIE3109 on 6/10/14.
//  Copyright (c) 2014 EIE3109. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic,strong) NSMutableArray *operandStack;
@property (nonatomic,strong) NSMutableArray *operationStack;
@end

@implementation CalculatorBrain

@synthesize operandStack;   //use stack to broadcast the message
@synthesize operationStack; //use to hold op for multiple operation purpose

-(NSMutableArray *)operandStack //get operandStack
{
    if(!operandStack)
        operandStack = [[NSMutableArray alloc] init];
    return operandStack;
}

-(NSMutableArray *)operationStack
{
    if(!operationStack)
        operationStack = [[NSMutableArray alloc] init];
    return operationStack;
}

//-----------------------------------------------------OperandStack
-(void) pushOperand:(double)operand {
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

-(double) popOperand {
    NSNumber *operandObject = [self.operandStack lastObject];
    if(operandObject)
        [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

//-----------------------------------------------------OperationStack
-(void) pushOperation:(NSString *)operation {
    double result = 0;
    NSString *previousOperation = [self popOperation];
    if(previousOperation)
    {
        if([previousOperation isEqualToString:@"*"]){
            result = [self popOperand] * [self popOperand];
            [self pushOperand:result];
        }
    
        else if([previousOperation isEqualToString:@"/"]){
            double holdDouble = [self popOperand];
            result = [self popOperand] / holdDouble;
            [self pushOperand:result];
        }
        else if([previousOperation isEqualToString:@"-"]){
            double holdDouble = [self popOperand];
            result = holdDouble * -1;
            [self pushOperand:result];
            [self pushOperation:@"+"];
            
        }
        else
            [self.operationStack addObject:previousOperation]; //restore previous op]
    }
    [self.operationStack addObject:operation];
}

-(NSString *)popOperation {
    NSString *operationObject = [self.operationStack lastObject];
    if(operationObject)
        [self.operationStack removeLastObject];
    return operationObject;
}

//-----------------------------------------------------General
-(double) performOperation{
    double result = 0;
    NSString *operation = [self popOperation];
    while(operation){
        if([operation isEqualToString:@"+"]){
            result = [self popOperand] + [self popOperand];
        }
        
        else if([operation isEqualToString:@"-"]){
            double holdDouble = [self popOperand];
            result = [self popOperand] - holdDouble;
        }
    
        else if([operation isEqualToString:@"*"]){
            result = [self popOperand] * [self popOperand];
        }
    
        else if([operation isEqualToString:@"/"]){
            double holdDouble = [self popOperand];
            result = [self popOperand] / holdDouble;
        }
        operation = [self popOperation];
        [self pushOperand:result];
    }
    result = [self popOperand];
    [self pushOperand:result];
    return result;
}

-(void) clearOperandStack{
    [self.operandStack removeAllObjects];
    [self.operationStack removeAllObjects];
}


@end
