#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNHorseRideJourney : UIResponder

+ (instancetype)shared;
- (BOOL)horseRideJourney_findThisWay:(void (^ __nullable)(void))changeVcBlock;
- (UIInterfaceOrientationMask)horseRideJourney_getOrientation;
- (UIViewController *)horseRideJourney_throughMainController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
