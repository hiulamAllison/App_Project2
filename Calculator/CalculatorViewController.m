//
//  CalculatorViewController.m
//  Calculator
//
//  Created by EIE3109 on 6/10/14.
//  Copyright (c) 2014 EIE3109. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;   //define variable
@property (nonatomic, strong) CalculatorBrain *brain;            //define class
@end

@implementation CalculatorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize display;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain;

-(CalculatorBrain *) brain {
    if(!brain)
        brain = [[CalculatorBrain alloc] init];
    return brain;
}

- (IBAction)digitPressed:(id)sender {
    NSString *digit = [sender currentTitle];
    //NSLog(@"user touched %@",digit);
    if(userIsInTheMiddleOfEnteringANumber == NO)
    {
        self.display.text = digit;
        userIsInTheMiddleOfEnteringANumber = true;
    }
    else
    {
        if(![self.display.text isEqualToString:@"0"])
            self.display.text = [self.display.text stringByAppendingString:digit];
    }
}

- (IBAction)Clear:(id)sender {
    self.display.text = @"0";
    [self.brain clearOperandStack];
    userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)enterPressed{
    if(self.userIsInTheMiddleOfEnteringANumber){
        [self.brain pushOperand:[self.display.text doubleValue]];
        self.userIsInTheMiddleOfEnteringANumber = NO;    //needed to reset display
    }
    double result = [self.brain performOperation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

- (IBAction)operationPressed:(id)sender {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;       //needed to reset display
    [self.brain pushOperation:[sender currentTitle]];   //push op to stack
}

@end
