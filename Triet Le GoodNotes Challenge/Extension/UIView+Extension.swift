//
//  UIView+Extension.swift
//  Triet Le GoodNotes Challenge
//
//  Created by Triet Le on 30.7.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import UIKit

extension UITableView {
    func reloadDataAnimated(_ closure:(() -> Void)? = nil) {
        UIView.transition(with: self, duration: 0.35, options: .transitionCrossDissolve, animations: {
            self.reloadData()
        }) { _ in
            closure?()
        }
    }
}
