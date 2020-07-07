//
//  DateExtension.swift
//  Continuum
//
//  Created by Victor Monteiro on 6/30/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import Foundation

extension Date {
    
    func dateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
