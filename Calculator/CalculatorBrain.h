//
//  CalculatorBrain.h
//  Calculator
//
//  Created by EIE3109 on 6/10/14.
//  Copyright (c) 2014 EIE3109. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

-(void) pushOperand: (double) operand;
-(double) performOperation;
-(void) pushOperation: (NSString *) operation;
-(void) clearOperandStack;

@end
