//
//  Number+Extension.swift
//  Triet Le GoodNotes Challenge
//
//  Created by Triet Le on 30.7.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import Foundation

extension TimeInterval {
    var dateDisplayString: String {
        let date = Date(timeIntervalSinceNow: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}
