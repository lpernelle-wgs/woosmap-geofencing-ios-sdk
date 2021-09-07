//
//  AppDelegate.swift
//  WoosmapGeofencing
//
//

import UIKit
import CoreLocation
import WoosmapGeofencing
//import MarketingCloudSDK
#if canImport(AirshipCore)
  import AirshipCore
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate  {

    var window: UIWindow?
    let dataLocation = DataLocation()
    let dataPOI = DataPOI()
    let dataDistance = DataDistance()
    let dataRegion = DataRegion()
    let dataVisit = DataVisit()
    let airshipEvents = AirshipEvents()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        WoosmapGeofencing.shared.getLocationService().airshipEventsDelegate = airshipEvents

        // Set private Woosmap key API
        WoosmapGeofencing.shared.setWoosmapAPIKey(key: WoosmapKey)
        
        // Set delegate of protocol Location, POI and Distance
        WoosmapGeofencing.shared.getLocationService().locationServiceDelegate = dataLocation
        WoosmapGeofencing.shared.getLocationService().searchAPIDataDelegate = dataPOI
        WoosmapGeofencing.shared.getLocationService().distanceAPIDataDelegate = dataDistance
        WoosmapGeofencing.shared.getLocationService().regionDelegate = dataRegion
        // Enable Visit and set delegate of protocol Visit
        WoosmapGeofencing.shared.getLocationService().visitDelegate = dataVisit

        // Check if the authorization Status of location Manager
        if CLLocationManager.authorizationStatus() != .notDetermined {
            WoosmapGeofencing.shared.startMonitoringInBackground()
        }

        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { _, _ in }
        } else {
            application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        }
        application.registerForRemoteNotifications()
        
        return true
    }

    // Handle remote notification registration. (failed)
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NSLog("Error on getting remote notification token : \(error.localizedDescription)")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")
        if CLLocationManager.authorizationStatus() != .notDetermined {
            WoosmapGeofencing.shared.startMonitoringInBackground()
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
        // Set Refreshing Position Hight frequency state
        WoosmapGeofencing.shared.setModeHighfrequencyLocation(enable: false)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        WoosmapGeofencing.shared.didBecomeActive()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
         completionHandler([.alert,.badge])
    }

}
