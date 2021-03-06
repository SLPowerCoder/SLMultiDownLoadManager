//
//  AppDelegate.m
//  SLMultiDownLoadManager
//
//  Created by sunlei on 16/8/3.
//  Copyright © 2016年 sunlei. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SLFileManager.h"
#import "SLDownLoadQueue.h"
#import "DownLoadTools.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *vc = [[ViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    NSLog(@"%@",NSHomeDirectory());
    
    long long freeDiskSize = [DownLoadTools getDiskFreeSpaceEx];
    long long totalDiskSize = [DownLoadTools getDiskTotalSpaceEx];
    
    NSLog(@"剩余：：：%7.2lf G --- 总计：：%7.2lf G",freeDiskSize/(1024*1024*1024.0),totalDiskSize/(1024*1024*1024.0));
    
    //获取缓存
    [SLDownLoadQueue getDownLoadCache];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //将要进入前台的时候刷新一下，防止下载停止，虽然他们的状态是正在下载或待下载状态
    [SLDownLoadQueue updateDownLoad];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    //app被杀死的时候做一些本地处理
    [SLDownLoadQueue appWillTerminate];
}

//在应用处于后台，且后台任务下载完成时回调
#pragma mark --- 后台下载
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler
{
    if ([identifier isEqualToString:@"com.sunlei"]) {
     
        [SLDownLoadQueue appWillTerminate];
//        self.backgroundSessionCompletionHandler = completionHandler;
        completionHandler();
    }
    
}





@end
