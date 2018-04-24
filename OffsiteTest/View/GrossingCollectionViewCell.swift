//
//  GrossingCollectionViewCell.swift
//  OffsiteTest
//
//  Created by Thomas Lam on 22/4/2018.
//  Copyright © 2018 Thomas Lam. All rights reserved.
//

import UIKit

class GrossingCollectionViewCell: UICollectionViewCell {
    var isInitialized: Bool = false
    var vm: AppItemViewModel?
    var view: GrossingItemView!

    func setVM(_ vm: AppItemViewModel?) {
        self.vm = vm

        if !isInitialized {
            view = GrossingItemView()

            contentView.addSubview(view)

            view.snp.makeConstraints {
                $0.top.left.right.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
            isInitialized = true
        }

        if vm != nil {
            view.setVM(vm: vm!)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

