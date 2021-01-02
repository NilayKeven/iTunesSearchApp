//
//  Logger.swift
//  iTunesSearchApp
//
//  Created by Nilay Keven on 2.01.2021.
//

import Foundation
import SwiftyBeaver

public struct Logger {
    public static let log = SwiftyBeaver.self
    
    private init() {}
    
    public static func setup() {
        let console = ConsoleDestination()
        console.format = "$DHH:mm:ss$d $L $M"
        console.levelColor.error = "❌"
        console.levelColor.warning = "⚠️"
        console.levelColor.info = "ℹ️"
        log.addDestination(console)
    }
}
