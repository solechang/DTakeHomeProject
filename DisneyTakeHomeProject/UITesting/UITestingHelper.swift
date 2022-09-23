//
//  UITestingHelper.swift
//  DisneyTakeHomeProject
//
//  Created by Chang Woo Choi on 9/23/22.
//

#if DEBUG
import Foundation

struct UITestingHelper {
    // get launch environment and launch argument
    static var isUITesting: Bool {
        ProcessInfo.processInfo.arguments.contains("-ui-testing")
    }
    static var isNetworkingSuccessful: Bool {
        ProcessInfo.processInfo.environment["-networking-success"] == "1"
    }
    
}
#endif
