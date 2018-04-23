//
//  OverlayLoadingView.swift
//  OffsiteTest
//
//  Created by Thomas Lam on 23/4/2018.
//  Copyright © 2018 Thomas Lam. All rights reserved.
//
import UIKit

final class OverlayLoadingView: OverlayView {
    let aiLoading = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    init() {
        super.init(frame: CGRect.zero)
        accessibilityIdentifier = "activity_indicator"
        
        vContent.addSubview(aiLoading)
        
        aiLoading.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.edges.equalToSuperview().inset(17)
        }
    }
    
    override func show() {
        super.show()
        aiLoading.startAnimating()
    }
    
    override func hide(after delay: TimeInterval) {
        super.hide(after: delay)
        aiLoading.stopAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(frame: CGRect.zero)
    }
}
