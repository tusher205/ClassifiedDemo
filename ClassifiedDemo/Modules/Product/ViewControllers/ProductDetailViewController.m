//
//  ProductDetailViewController.m
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 26/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ProductDetailViewController.h"
#import "ClassifiedDemo-Swift.h"

@interface ProductDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ProductDetailViewController

+ (NSString *)nibName
{
    return NSStringFromClass([self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

# pragma mark - Methods
- (void) setUpView {
    
    // Set Navigation title
    self.navigationItem.title = ProductLocalizationText.TEXT_ITEM_DETAILS;
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    
    // Set name, price label
    self.nameLabel.text = self.selectedProduct.name.capitalizedString;
    self.priceLabel.text = self.selectedProduct.price.uppercaseString;
    
    NSString* postedText = [NSString stringWithFormat:@"%@ %@", ProductLocalizationText.TEXT_POSTED_AT, [DateUtils getFormatedDateFromString:self.selectedProduct.createdAt]];
    
    self.postedDateLabel.text = postedText;
    
    // Setup Image scroll view
    [self setUpProductImageScrollView];
    
    // Setup product detail table view
    [self setUpProductDetailTableView];
    
}

- (void) setUpProductImageScrollView {
    self.productImageScrollView.pagingEnabled = true;
    self.productImageScrollView.showsVerticalScrollIndicator = false;
    self.productImageScrollView.showsHorizontalScrollIndicator = false;
    self.productImageScrollView.frame = CGRectMake(0,
                                                   0,
                                                   UIScreen.mainScreen.bounds.size.width,
                                                   UIScreen.mainScreen.bounds.size.width);
    
    if (self.selectedProduct.imageUrls.count > 0) {
        // Add Images to scroll view
        [self setUpImagesToScrollView:self.selectedProduct.imageUrls];
        
        // Set page control
        [self setUpPageControl:self.selectedProduct.imageUrls.count];
    }
    
    // Disbaling details text view
    [self.detailsTextView setHidden:YES];
    
}

- (void) setUpImagesToScrollView:(NSArray *) images {
    for (int i = 0; i < images.count; i++){
        UIImageView* imageView = [[UIImageView alloc] init];
        
        // Set images
        if (images.count > 0) {
            [self.presenter onFetchImageWithName:images[i] completion:^(UIImage *image) {
                imageView.image = image;
            }];
        }
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        CGFloat xPosition = UIScreen.mainScreen.bounds.size.width * (CGFloat)i;
        imageView.frame = CGRectMake(xPosition,
                                     0,
                                     self.productImageScrollView.frame.size.width,
                                     self.productImageScrollView.frame.size.height);
        
        self.productImageScrollView.contentSize = CGSizeMake(self.productImageScrollView.frame.size.width * (CGFloat) i+1,
                                                             self.productImageScrollView.frame.size.height);
        [self.productImageScrollView addSubview:imageView];
        self.productImageScrollView.delegate = self;
    }
}

- (void) setUpPageControl:(NSUInteger) count {
    self.productImagePageControl.numberOfPages = count;
    self.productImagePageControl.currentPage = 0;
    [self.view bringSubviewToFront:_productImagePageControl];
}

- (void) setUpProductDetailTableView {
    
    self.detailsTableView.dataSource = self;
    self.detailsTableView.delegate = self;
    
    // Set table cell
    [self.detailsTableView registerNib:[ProductDetailTableViewCell loadNib]
                forCellReuseIdentifier:[ProductDetailTableViewCell reuseIdentifier]];
}

#pragma mark - UIScrollViewDelegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    double pageIndex = round(self.productImageScrollView.contentOffset.x / self.view.frame.size.width);
    self.productImagePageControl.currentPage = (int) pageIndex;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1; // Fixed
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return ClassifiedDetailCellIdentifierItemCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailTableViewCell *cell = (ProductDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[ProductDetailTableViewCell reuseIdentifier] forIndexPath:indexPath];
    
    ClassifiedDetailCellIdentifier cellId = (ClassifiedDetailCellIdentifier) indexPath.row;
    
    switch (cellId) {
        case ClassifiedDetailCellIdentifierItemUid:
            cell.textLabel.text = ProductLocalizationText.TEXT_PRODUCT_ID;
            cell.detailTextLabel.text = [self.selectedProduct.uid substringToIndex:10]; // First 10 characters
            break;

        case ClassifiedDetailCellIdentifierItemPrice:
            cell.textLabel.text = ProductLocalizationText.TEXT_PRICE;
            cell.detailTextLabel.text =  self.selectedProduct.price;
            break;

        case ClassifiedDetailCellIdentifierItemPostedDate:
            cell.textLabel.text = ProductLocalizationText.TEXT_POSTED_AT;
            cell.detailTextLabel.text = [DateUtils getFormatedDateFromString:self.selectedProduct.createdAt];
            break;

        default:
            break;
    }
    
    // Styll cell
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

#pragma mark UITableViewDelegate

@end

