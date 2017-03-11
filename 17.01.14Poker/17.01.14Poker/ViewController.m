//
//  ViewController.m
//  17.01.14Poker
//
//  Created by Serik Klement on 14.01.17.
//  Copyright © 2017 Serik Klement. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *images;

@end

@implementation ViewController

// просматривать лучше горизонтально!!!

// при нажатии на кнопку - на экране показываются комбинации карт в покере, карты в 1 комбинации не повторяются
// не реализовано:
// надпись в лейбле - название покерной комбинации


- (void)viewDidLoad {
    [super viewDidLoad];

    [self createButton];
    [self createLabel];
    self.view.backgroundColor = [UIColor colorWithRed:52.0/255 green:163.0/255 blue:70.0/255 alpha:1];
    
    self.images = [NSMutableArray new];
    
    for (NSInteger i = 0; i <= 54; i++) {
        
        NSString *nameImage = [NSString stringWithFormat:@"%zd.jpg", i];
        UIImage *image = [UIImage imageNamed:nameImage];
        image.accessibilityIdentifier = [NSString stringWithFormat:@"%zd", i]; // задаю идентификатор для UIImage вместо tag
        
        [self.images addObject:image]; // вставляю картинки в массив
    }
    
    for (NSInteger i = 1; i <= 5; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] init];
        
        CGFloat width = (self.view.frame.size.width - 60) / 5; // ширина вьюхи
        imgView.frame = CGRectMake((width * i - width + i * 10), 100, width, width * 1.5);
        imgView.image = [self.images objectAtIndex:0]; // присваиваю имиджу
        imgView.tag = i; // присваеваю тег - индекс
        
        [self.view addSubview:imgView];
        
    }
    
}

- (UILabel*) createLabel {
    
    UILabel *label = [UILabel new];
    
    CGFloat size = (self.view.frame.size.width * 0.8);
    label.frame = CGRectMake((self.view.frame.size.width - size) / 2, 30, size, 50);
    label.backgroundColor = [UIColor whiteColor];
    label.layer.borderWidth = 1;
    [self.view addSubview:label];
    
    return label;
}

- (UIButton*) createButton {
    
    UIButton *button = [UIButton new];
    
    CGFloat size = (self.view.frame.size.width / 3);
    button.frame = CGRectMake(size, 330, size, 50);
    button.backgroundColor = [UIColor colorWithRed:255.0/255 green:147.0/255 blue:47.0/255 alpha:1];
    button.layer.borderWidth = 2;
    [self.view addSubview:button];
    [button setTitle:@"START" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:50];
    
    [button addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [button addTarget:self action:@selector(actionButtonDown:) forControlEvents:UIControlEventTouchDown];
    
    return button;
}


- (void) actionButtonDown:(UIButton*) button {
    
    button.backgroundColor = [UIColor colorWithRed:255.0/255 green:147.0/255 blue:47.0/255 alpha:0.6];
    
}

- (void) actionButton:(UIButton*) button {
    
    NSMutableArray *arrayNumbers = [NSMutableArray new];
    
    for (NSInteger i = 1; i < [self.images count]; i++) {
        
        NSNumber *num = [NSNumber numberWithInteger:i]; // интежер преобразовываю в намбер
        
        [arrayNumbers addObject:num];
    }
    
    for (NSInteger j = 0; j < 5; j++) {
        
        NSInteger randomIndex = arc4random() % arrayNumbers.count;
        NSNumber *tempNum = [arrayNumbers objectAtIndex:randomIndex];
        NSInteger indexImg = tempNum.integerValue;
        
        [arrayNumbers removeObject:tempNum]; // выкинул из массива номер который уже высветился
        UIImage *image = [self.images objectAtIndex:indexImg];
        UIImageView *tempImage = [self.view viewWithTag:j + 1]; //нашёл по тегу на супервью имиджвью
        tempImage.image = image;
        
    }
    
    button.backgroundColor = [UIColor colorWithRed:255.0/255 green:147.0/255 blue:47.0/255 alpha:1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
