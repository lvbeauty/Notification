//
//  ViewController.swift
//  NotificationCourse
//
//  Created by Tong Yi on 6/24/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import UIKit
//import UserNotifications

class LocalNotificationViewController: UIViewController {

//    let aObj = A()
//    let cObj = C()
//    let bObj = B()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        requestUserAuthorization()
        UNUserNotificationCenter.current().delegate = self
        
        let aObj = A()
        let cObj = C()
        let bObj = B()

        aObj.addObserver()
        cObj.addObserver()

        print("----- ++++ ------")

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [aObj, bObj, cObj] in
            print(aObj)
            print(cObj)
            bObj.party()
        
//        DispatchQueue.main.sync {
//            self.bObj.party()
//        }
        }
        
    }
    
    deinit {
        print("All Done!!!")
    }

    func requestUserAuthorization()
    {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (status, error) in
            if status
            {
                print("Granted")
            }
            else
            {
                print("Not Granted")
            }
        }
    }
    
    @IBAction func notify(_ sender: Any)
    {
        self.sendNotification(with: "Hey this is Simplified iOS")
    }
    
    func sendNotification(with title: String)
    {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = "iOS Development is fun"
        content.body = "We are learning about iOS Local Notification"
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        
        guard let url = Bundle.main.url(forResource: "wanzi3", withExtension: "jpeg") else { return }
        do
        {
            content.attachments = [try UNNotificationAttachment(identifier: "AttachImage", url: url, options: nil)]
        }
        catch
        {
            print(error)
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let changeTextAction = UNTextInputNotificationAction(identifier: "Change.Text", title: "Change Message Text", options: [])
        let repeatAction = UNNotificationAction(identifier: "Repeat", title: "Repeat Notification", options: [])
        
        let category = UNNotificationCategory(identifier: "action category", actions: [changeTextAction, repeatAction], intentIdentifiers: [], options: [])
        
        content.categoryIdentifier = "action category"
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        let notificationRequest = UNNotificationRequest(identifier: "myCustomLocal", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            //handle error
        }
    }
}

extension LocalNotificationViewController: UNUserNotificationCenterDelegate
{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case "Change.Text":
            guard let textResponse = response as? UNTextInputNotificationResponse else {return}
            let title = textResponse.userText
            self.sendNotification(with: title)
        case "Repeat":
            self.sendNotification(with: "Hey this is Simplified iOS")
        default:
            break
        }
    }
}

