//
//  AppDelegate.swift
//  SilverJourney
//
//  Created by Hassan Talat on 8/17/22.
//

import Foundation
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {
    var statusItem: NSStatusItem?
    var popover = NSPopover()
    
    func applicationDidFinishLaunching(_ aNotification:
                                       Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength:
        NSStatusItem.variableLength)
        let itemImage = NSImage(systemSymbolName: "leaf.fill", accessibilityDescription: "leaf")
        itemImage?.isTemplate = true
        statusItem?.button?.image = itemImage
        
        statusItem?.menu = NSMenu()
        statusItem?.menu?.delegate = self

        let contentView = ContentView()
        popover.contentSize = CGSize(width: 500, height: 500)
        popover.contentViewController = NSHostingController(rootView:contentView)
        
        NSEvent.addGlobalMonitorForEvents(matching:
        [.leftMouseDown, .rightMouseDown]) { [weak self] event in
          self?.popover.performClose(event)
        }
    }
    
    func menuWillOpen(_ menu: NSMenu) {
        guard let statusBarButton = statusItem?.button else { return }
        popover.show(relativeTo: statusBarButton.bounds, of:statusBarButton, preferredEdge: .maxY)
    }
}
