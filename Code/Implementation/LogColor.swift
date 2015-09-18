//
//  LogColor.swift
//  CleanroomLogger
//
//  Created by Dan Dofter on 6/25/15.
//  Copyright (c) 2015 Gilt Groupe. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
#endif

public struct LogColor {

    public let fg: (Int, Int, Int)?
    public let bg: (Int, Int, Int)?
    
    private static let escape = "\u{001b}["
    private static let reset = "\(LogColor.escape);"
    
    private var fgString: String? {
        if let fg = fg {
            return "fg\(fg.0),\(fg.1),\(fg.2);"
        } else {
            return nil
        }
    }
    
    private var bgString: String? {
        if let bg = bg {
            return "bg\(bg.0),\(bg.1),\(bg.2);"
        } else {
            return nil
        }
    }
    
    public func format(message: String) -> String {

        if fg == nil && bg == nil {
            return message
        }

        var escapedColor: String = ""

        if let fgString = fgString {
            escapedColor += LogColor.escape + fgString
        }
        
        if let bgString = bgString {
            escapedColor += LogColor.escape + bgString
        }
        
        return "\(escapedColor)\(message)\(LogColor.reset)"
    }
    
    public init(fg: (Int, Int, Int)? = nil, bg: (Int, Int, Int)? = nil) {
        self.fg = fg
        self.bg = bg
    }
    
    #if os(iOS)
    public init(fg: UIColor, bg: UIColor? = nil) {
        var redComponent: CGFloat = 0
        var greenComponent: CGFloat = 0
        var blueComponent: CGFloat = 0
        var alphaComponent: CGFloat = 0
        
        fg.getRed(&redComponent, green: &greenComponent, blue: &blueComponent, alpha:&alphaComponent)
        self.fg = (Int(redComponent * 255), Int(greenComponent * 255), Int(blueComponent * 255))
        if let bg = bg {
            bg.getRed(&redComponent, green: &greenComponent, blue: &blueComponent, alpha:&alphaComponent)
            self.bg = (Int(redComponent * 255), Int(greenComponent * 255), Int(blueComponent * 255))
        } else {
            self.bg = nil
        }
    }
    #else
    public init(fg: NSColor, bg: NSColor? = nil) {
        self.fg = (Int(fg.redComponent * 255), Int(fg.greenComponent * 255), Int(fg.blueComponent * 255))
        if let bg = bg {
            self.bg = (Int(bg.redComponent * 255), Int(bg.greenComponent * 255), Int(bg.blueComponent * 255))
        } else {
            self.bg = nil
        }
    }
    #endif
    
    public static let red: LogColor = {
        return LogColor(fg: (255, 0, 0))
    }()
    
    public static let green: LogColor = {
        return LogColor(fg: (0, 255, 0))
    }()
    
    public static let blue: LogColor = {
        return LogColor(fg: (0, 0, 255))
    }()
        
    public static let black: LogColor = {
        return LogColor(fg: (0, 0, 0))
    }()
    
    public static let white: LogColor = {
        return LogColor(fg: (255, 255, 255))
    }()
    
    public static let lightGrey: LogColor = {
        return LogColor(fg: (211, 211, 211))
    }()
    
    public static let darkGrey: LogColor = {
        return LogColor(fg: (169, 169, 169))
    }()
    
    public static let orange: LogColor = {
        return LogColor(fg: (255, 165, 0))
    }()
    
    public static let whiteOnRed: LogColor = {
        return LogColor(fg: (255, 255, 255), bg: (255, 0, 0))
    }()
    
    public static let darkGreen: LogColor = {
        return LogColor(fg: (0, 128, 0))
    }()
}