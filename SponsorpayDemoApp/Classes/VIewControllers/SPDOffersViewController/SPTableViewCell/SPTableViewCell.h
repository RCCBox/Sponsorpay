// Apple
#import <UIKit/UIKit.h>

@interface SPTableViewCell : UITableViewCell

@property (unsafe_unretained) IBOutlet UILabel *titleLabel;
@property (unsafe_unretained) IBOutlet UILabel *detailLabel;
@property (unsafe_unretained) IBOutlet UILabel *badgeLabel;

@end
