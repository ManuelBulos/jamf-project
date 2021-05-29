//
//  AppDelegate.swift
//  jamfAnimalsOSXSwift
//
//  Created by Jamf on 27.08.2018.
//  Copyright © 2018 Jamf. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    private(set) var window: NSWindow?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window = makeWindow(title: Constants.appName, controller: AnimalViewController.make())
    }

    func makeWindow(title: String, controller: NSViewController) -> NSWindow {
        let contentRect = NSMakeRect(.zero,
                                     .zero,
                                     NSScreen.main?.frame.width ?? 100,
                                     NSScreen.main?.frame.height ?? 100)

        let window = NSWindow(contentRect: contentRect,
                              styleMask: [.miniaturizable, .closable, .resizable, .titled],
                              backing: .buffered,
                              defer: false)

        window.title = title
        window.contentViewController = controller
        window.makeKeyAndOrderFront(nil)
        return window
    }
}
