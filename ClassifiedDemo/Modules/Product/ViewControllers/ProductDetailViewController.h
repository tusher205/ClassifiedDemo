//
//  ProductDetailViewController.h
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 26/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClassifiedProduct;
@class ProductListPresenter;

@interface ProductDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *productImageScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *productImagePageControl;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *postedDateLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;
@property (weak, nonatomic) IBOutlet UITableView *detailsTableView;

@property (weak, nonatomic) ClassifiedProduct* selectedProduct;
@property (weak, nonatomic) ProductListPresenter* presenter;

+ (NSString *)nibName;

@end
