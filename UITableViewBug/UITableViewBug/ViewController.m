//
//  ViewController.m
//  UITableViewBug
//
//  Created by Jone on 30/12/2016.
//  Copyright © 2016 Jone. All rights reserved.
//

#import "ViewController.h"
#import "SFTableViewCell.h"

/**
 ## reloadRowsAtIndexPaths problem
 
 I add a image as avatar at indexPath [0,0], and use detailLabel display nickname at indexPaht [0,1].
 When use `reloadRowsAtIndexPaths` indexPath the indexPath [0,1] get a image...
 
 I find when invoke `reloadRowsAtIndexPaths` the dequeue cell return a cell.
 
 And the indexPath [0,0] cell be reuse at [0,1].
 
 I don't know why so that.
 
 */

static CGFloat const kAvatorCellHeight = 80;
static NSTimeInterval const kDelayTime = 1;

static NSString * const kCellIdentifier = @"cellIdentifier";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIImage *avator;
@property (nonatomic, copy) NSString *nickName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titles = @[@"Avator", @"Nickname"];
    [self.tableView registerClass:[SFTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDelayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        _avator = [UIImage imageNamed:@"cat"];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        [self.tableView reloadData];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDelayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            _nickName = @"Smallfly";
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//            [self.tableView reloadData];
        });
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    SFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = _titles[indexPath.row];

    if (indexPath.row == 0) {
        [self configureCell:cell indexPath:indexPath];
    } else {
        NSString *nickName =  _nickName ?: @"nickname";
        cell.detailTextLabel.text = nickName;
    }
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    for (UIView *sv in cell.contentView.subviews) {
        if ([sv isKindOfClass:[UIImageView class]]) {
            [sv removeFromSuperview];
        }
    }
    
    UIImage *avator = _avator ?: [UIImage imageNamed:@"user_profile_avatar"];
    UIImageView *avatorImageView = [[UIImageView alloc] initWithImage:avator];
    avatorImageView.contentMode = UIViewContentModeScaleAspectFill;
    avatorImageView.clipsToBounds = YES;
    CGFloat imageSize = kAvatorCellHeight * 3/4;
    avatorImageView.layer.cornerRadius = imageSize / 2;
    avatorImageView.frame = (CGRect){CGRectGetWidth(self.view.bounds) - imageSize - 32,
        (kAvatorCellHeight - imageSize)/2,
        imageSize, imageSize};
    [cell.contentView addSubview:avatorImageView];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAvatorCellHeight;
}

@end
