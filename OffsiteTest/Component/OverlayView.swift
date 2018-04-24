//
//  OverlayView.swift
//  OffsiteTest
//
//  Created by Thomas Lam on 23/4/2018.
//  Copyright © 2018 Thomas Lam. All rights reserved.
//

import SnapKit

class OverlayView: UIView {
    let vContent = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUI()
    }

    func initUI() {
        vContent.backgroundColor = UIColor.init(red: 0.39, green: 0.39, blue: 0.39, alpha: 1)
        vContent.layer.masksToBounds = true
        vContent.layer.cornerRadius = 10
        addSubview(vContent)
    }

    func show() {
        setNeedsLayout()
        setNeedsDisplay()

        UIApplication.shared.delegate!.window!!.addSubview(self)

        snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }

        vContent.snp.remakeConstraints {
            $0.center.equalToSuperview()
        }

        NSObject.cancelPreviousPerformRequests(withTarget: self)

        vContent.alpha = 0

        UIView.animate(withDuration: 0.3) {
            UIView.setAnimationDelegate(self)
            self.vContent.alpha = 1
        }
    }

    func hide(after delay: TimeInterval) {
        perform(#selector(hide(_:)), with: self, afterDelay: delay)
    }

    @objc func hide(_ sender: OverlayView?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.vContent.alpha = 0
            self.removeFromSuperview()
        }

        UIView.animate(withDuration: 0.3, animations: {
            UIView.setAnimationDelegate(self)
            self.vContent.alpha = 0.02
        })

        CATransaction.commit()
    }
}
