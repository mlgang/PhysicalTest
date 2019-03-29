//
//  SubmitTableViewCell.m
//  PhysicalTest
//
//  Created by jay on 2019/3/28.
//  Copyright © 2019 jay. All rights reserved.
//

#import "SubmitTableViewCell.h"
#import <Masonry.h>

@interface SubmitTableViewCell()<UITextFieldDelegate>

@end

@implementation SubmitTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI{
    _titleLab = [[UILabel alloc] init];
    //_titleLab.backgroundColor = [UIColor lightGrayColor];
    //_titleLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_titleLab];
    [_titleLab sizeToFit];
    _titleLab.numberOfLines = 0;
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.right.equalTo(self.contentView.mas_centerX);
    }];
    
    _fillTextField = [[UITextField alloc] init];
    _fillTextField.delegate = self;
    _fillTextField.keyboardType = UIKeyboardTypePhonePad;
    //_fillTextField.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_fillTextField];
    [_fillTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.left.equalTo(self.contentView.mas_centerX);
    }];
}
#pragma mark - textField
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.textBlock) {
        self.textBlock(textField.text);
    }
}


@end
