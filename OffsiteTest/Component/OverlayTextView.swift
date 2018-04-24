//
//  OverlayTextView.swift
//  OffsiteTest
//
//  Created by Thomas Lam on 23/4/2018.
//  Copyright © 2018 Thomas Lam. All rights reserved.
//

import SnapKit

final class OverlayTextView: OverlayView {
    let lblText = UILabel()

    init() {
        super.init(frame: CGRect.zero)

        vContent.addSubview(lblText)

        lblText.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(17)
        }

        lblText.lineBreakMode = .byWordWrapping
        lblText.numberOfLines = 0
        lblText.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 40
    }

    func setText(_ text: String?) {
        lblText.text = text
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(frame: CGRect.zero)
    }
}
