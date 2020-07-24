//
//  NotificationCenter.swift
//  NotificationCourse
//
//  Created by Tong Yi on 6/24/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import Foundation

extension Notification.Name
{
    static let partyNotification: Notification.Name = Notification.Name("partyNotification")
}

class A
{
    func addObserver() //Obsever pattern
    {
        NotificationCenter.default.addObserver(self, selector: #selector(self.notified), name: .partyNotification, object: nil)
         
    }
    
    @objc func notified(_ notification: Notification)
    {
        print("let's go party")
        print(notification.userInfo!["AnyHashable"])
    }
}

class B
{
    func party() -> Void
    {
        NotificationCenter.default.post(name: .partyNotification, object: self, userInfo: ["AnyHashable" : "Wahahahahaha"])
    }
}

class C
{
    func addObserver() //Obsever pattern
    {
        NotificationCenter.default.addObserver(self, selector: #selector(self.notified(_:)), name: .partyNotification, object: nil)
    }
    
    func removeObsever()
    {
        NotificationCenter.default.removeObserver(self, name: .partyNotification, object: nil)
    }
    
    @objc func notified(_ notification: Notification)
    {
        print("C is going to B's party")
    }
}
