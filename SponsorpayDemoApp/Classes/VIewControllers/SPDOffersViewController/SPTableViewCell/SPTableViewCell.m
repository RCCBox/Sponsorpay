// Header
#import "SPTableViewCell.h"

@implementation SPTableViewCell

#pragma mark - Memory management

- (void)dealloc {
	
  self.titleLabel = nil;
  self.detailLabel = nil;
  self.badgeLabel = nil;
}

@end
