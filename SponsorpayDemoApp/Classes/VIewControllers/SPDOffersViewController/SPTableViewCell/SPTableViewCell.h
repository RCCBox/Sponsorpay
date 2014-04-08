// Apple
#import <UIKit/UIKit.h>

// Vendor
// Views
#import "EGOImageView.h"

@interface SPTableViewCell : UITableViewCell

@property (unsafe_unretained) IBOutlet EGOImageView *thubnailView;
@property (unsafe_unretained) IBOutlet UILabel *badgeLabel;
@property (unsafe_unretained) IBOutlet UILabel *titleLabel;
@property (unsafe_unretained) IBOutlet UILabel *detailLabel;

@end
