//
//  AppDelegate.swift
//  Craft
//
//  Created by castiel on 15/11/7.
//  Copyright © 2015年 castiel. All rights reserved.
//


//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖保佑             永无BUG




import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var startTime : NSDate?
    
    var instance : FMDatabase?
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        RestService.configBaseUrl("http://162.243.241.80:8080/wow")
        RestService.setNeedAuthentication(false)

        FMDBHelper.configDatabaseWithName("craft", tableQueries: [DBContract.notificationTable,DBContract.createAccountTable,DBContract.createIconTable,DBContract.ProfileTable,DBContract.createRaidTypeName,DBContract.createRaid,DBContract.createRaidLevel,DBContract.createInitDataToken,DBContract.createFriendTable,
            DBContract.createFaction,DBContract.createGroupTable])
        instance = FMDBHelper.sharedData() as? FMDatabase
        
        RCIM.sharedRCIM().initWithAppKey("pkfcgjstfdgr8")
        
        UMessage.startWithAppkey("572b270d67e58eabeb0030be", launchOptions: launchOptions)
        
        IQKeyboardManager.sharedManager().enable = true
        
        UIAdapter.shared.config(UIScreen.mainScreen().bounds)
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor()
        let startViewController = MainTabbar(nibName:nil, bundle: nil)
        self.window!.rootViewController = startViewController
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        self.window!.makeKeyAndVisible()
        
        let customQueue = dispatch_queue_create("initSystemSound", nil)
        dispatch_async(customQueue, {
            PlaySound.sharedData()
        })
        
//        let loginView = LoginController(nibName: nil, bundle: nil)
//        let loginNav = UINavigationController(rootViewController: loginView)
//        self.window!.rootViewController!.presentViewController(loginNav, animated: false, completion: nil)
        
        
        let startview = StartView(nibName: nil, bundle: nil)
        let startviewNav = UINavigationController(rootViewController: startview)
        self.window!.rootViewController!.presentViewController(startviewNav, animated: false, completion: nil)

        self.registerNotification()
        return true
    }
    
    
    func registerNotification(){
        
        //邀请响应actions
        let completeAction = UIMutableUserNotificationAction()
        completeAction.identifier = "OK" // the unique identifier for this action
        completeAction.title = "接受" // title for the action button
        completeAction.activationMode = .Background // UIUserNotificationActivationMode.Background - don't bring app to foreground
        completeAction.authenticationRequired = false // don't require unlocking before performing action
        //        completeAction.destructive = true // display action in red
        
        let refuseAction = UIMutableUserNotificationAction()
        refuseAction.identifier = "Refuse"
        if #available(iOS 9.0, *) {
            refuseAction.parameters = [UIUserNotificationTextInputActionButtonTitleKey : "Send"]
        } else {
            // Fallback on earlier versions
        }
        refuseAction.title = "拒绝"
        if #available(iOS 9.0, *) {
            refuseAction.behavior = UIUserNotificationActionBehavior.TextInput
        } else {
            // Fallback on earlier versions
        }
        refuseAction.activationMode = .Background
        refuseAction.destructive = false
        refuseAction.authenticationRequired = false
        
        let todoCategory = UIMutableUserNotificationCategory() // notification categories allow us to create groups of actions that we can associate with a notification
        todoCategory.identifier = "Invite_Category"
        todoCategory.setActions([refuseAction, completeAction], forContext: .Default) // UIUserNotificationActionContext.Default (4 actions max)
        
        
        //确认活动actions
        let confirmAction = UIMutableUserNotificationAction()
        confirmAction.identifier = "Confirm" // the unique identifier for this action
        confirmAction.title = "确认" // title for the action button
        confirmAction.activationMode = .Background // UIUserNotificationActivationMode.Background - don't bring app to foreground
        confirmAction.authenticationRequired = false // don't require unlocking before performing action
        //        completeAction.destructive = true // display action in red
        let cancelAction = UIMutableUserNotificationAction()
        cancelAction.identifier = "Cancel"
        if #available(iOS 9.0, *) {
            cancelAction.parameters = [UIUserNotificationTextInputActionButtonTitleKey : "为什么水我？"]
        } else {
            // Fallback on earlier versions
        }
        cancelAction.title = "取消"
        if #available(iOS 9.0, *) {
            cancelAction.behavior = UIUserNotificationActionBehavior.TextInput
        } else {
            // Fallback on earlier versions
        }
        cancelAction.activationMode = .Background
        cancelAction.destructive = false
        cancelAction.authenticationRequired = false
        
        
        let cancelCategory = UIMutableUserNotificationCategory() // notification categories allow us to create groups of actions that we can associate with a notification
        cancelCategory.identifier = "Notification_Category"
        cancelCategory.setActions([cancelAction,confirmAction], forContext: .Default) // UIUserNotificationActionContext.Default (4 actions max)
        
        
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge , .Sound], categories: NSSet(array: [todoCategory,cancelCategory]) as? Set<UIUserNotificationCategory>)
        
        UMessage.registerRemoteNotificationAndUserNotificationSettings(settings)
        
        //        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        
        UMessage.setLogEnabled(true)
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
//        startTime = NSDate()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
       
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
//        let now = NSDate()
//        let timeInterval = now.timeIntervalSinceDate(self.startTime!)
//        
//        print(timeInterval)
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        UMessage.didReceiveRemoteNotification(userInfo);
    }
    
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        UMessage.registerDeviceToken(deviceToken)
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        application.applicationIconBadgeNumber -= 1
    }
    
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        print("umessage")
        completionHandler()
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, withResponseInfo responseInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
       print("hello")
       completionHandler()
    }
}

