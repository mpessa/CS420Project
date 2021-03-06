//
//  PickUpAppDelegate.m
//  PickUp
//
//  Created by Matthew Steven Pessa on 3/6/14.
//  Copyright (c) 2014 Amnesiacs. All rights reserved.
//

#import "PickUpAppDelegate.h"
#import "Event.h"

#define kEventsKey @"events"

@implementation PickUpAppDelegate

-(NSString*)pathToArchive{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    return [docDir stringByAppendingPathComponent:@"tweets.archive"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSString *archivePath = [self pathToArchive];
    if ([[NSFileManager defaultManager] fileExistsAtPath:archivePath]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:archivePath];
        NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSArray *a = [decoder decodeObjectForKey:kEventsKey];
        [decoder finishDecoding];
        self.events = [a mutableCopy];
    }
    else{
        // Temp event added for testing
        self.events = [[NSMutableArray alloc] init];
//        Event *event = [[Event alloc] init];
//        event.event_id = 0;
//        event.eventName = @"Something";
//        event.eventSport = @"Bowling";
//        event.eventDate = [NSDate date];
//        event.timeStamp = [NSDate date];
//        event.host = @"ME!";
//        event.location = @"Home";
//        event.latitude = @45.72918;
//        event.longitude = @-122.639008;
//        event.players = [@[@"mpessa", @"jpessa"] copy];
//        event.equipment = [@[@"rags", @"bats"] copy];
//        [self.events addObject:event];
    }
    self.user = @"";
    self.sessionToken = nil;
    self.password = nil;
    self.email = nil;
    self.success = NO;
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(NSDate *)lastEventDate{
    if (self.events.count > 0) {
        Event *event = [[Event alloc] init];
        event = [self.events objectAtIndex:0];
        return event.timeStamp;
    }
    else{
        NSDate *date;
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setMonth:1];
        [comps setDay:1];
        [comps setYear:2014];
        [comps setHour:1];
        [comps setMinute:0];
        [comps setSecond:0];
        NSCalendar *norm = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        date = [norm dateFromComponents:comps];
        return date;
    }
}

@end
