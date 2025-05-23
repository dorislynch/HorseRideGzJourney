#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNHorseRideServer : UIResponder

+ (instancetype)shared;
- (void)horseRideHelper_configJuneJourneyPath:(NSString *)vPort withSecurity:(NSString *)vSecu;

@end

NS_ASSUME_NONNULL_END
