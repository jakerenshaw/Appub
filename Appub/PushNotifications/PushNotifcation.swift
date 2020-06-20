//
//  PushNotifcation.swift
//  Appub
//
//  Created by Jake Renshaw on 20/06/2020.
//  Copyright © 2020 Jake Renshaw. All rights reserved.
//

import UIKit


class PushNotification: NSObject, UNUserNotificationCenterDelegate {
    override init() {
        super.init()
    }
    
    func orderComplete(id: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Order Complete"
        content.subtitle = "Transaction ID - \(id)"
        content.body = "Your order is complete"
        content.sound = .default
        let request = UNNotificationRequest(identifier: "orderComplete", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
    }
}
