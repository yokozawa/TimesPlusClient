//
//  TPCViewController.h
//  TimesPlusClient
//
//  Created by yoko_net on 2014/03/02.
//  Copyright (c) 2014年 yoko_net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Validator.h"
#import "TooltipView.h"

@interface TPCViewController : UIViewController
<UITextFieldDelegate, UIWebViewDelegate, ValidatorDelegate>

@property IBOutlet UITextField *tfCard1;
@property IBOutlet UITextField *tfCard2;
@property IBOutlet UITextField *tfPassword;
@property IBOutlet UIButton *btnGo;
@property IBOutlet UIButton *btnReset;

@property IBOutlet UIToolbar *toolBar;

@end
