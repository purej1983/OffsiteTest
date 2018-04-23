//
//  UIViewExtension.swift
//  OffsiteTest
//
//  Created by Thomas Lam on 23/4/2018.
//  Copyright © 2018 Thomas Lam. All rights reserved.
//
import UIKit

extension UIView {
    func makeRoundCorner() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    func makeCircle() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.masksToBounds = true
    }
}
