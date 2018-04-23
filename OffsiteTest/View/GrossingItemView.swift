//
//  GrossingView.swift
//  OffsiteTest
//
//  Created by Thomas Lam on 22/4/2018.
//  Copyright © 2018 Thomas Lam. All rights reserved.
//

import RxSwift
import Kingfisher

final class GrossingItemView: UIStackView {
    public private(set) var vm: AppItemViewModel?
    private let disposeBag = DisposeBag()
    private let ivAppImage = UIImageView()
    private let lblAppName = UILabel()
    private let lblAppCategory = UILabel()

    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.initUI()
    }

    init() {
        super.init(frame: CGRect.zero)
        self.initUI()
    }

    private func initUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layoutMargins = UIEdgeInsets(top: 17, left: 0, bottom: 17, right: 0)
        self.isLayoutMarginsRelativeArrangement = true
        self.axis = .vertical
        self.alignment = .leading
        self.spacing = 8
        self.distribution = .equalSpacing

        self.ivAppImage.widthAnchor.constraint(equalToConstant: 75).isActive = true
        self.ivAppImage.heightAnchor.constraint(equalToConstant: 75).isActive = true
        self.ivAppImage.makeRoundCorner()
        
        self.lblAppName.numberOfLines = 3
        self.lblAppName.lineBreakMode = .byTruncatingTail
        self.lblAppName.font = UIFont.boldSystemFont(ofSize: 12)
        
        self.lblAppCategory.font = UIFont.systemFont(ofSize: 12 )

        self.addArrangedSubview(self.ivAppImage)
        self.addArrangedSubview(self.lblAppName)
        self.addArrangedSubview(self.lblAppCategory)
        
    }

    func setVM(vm: AppItemViewModel) {
        self.vm = vm
        self.bindUI()
    }

    private func bindUI() {
        guard let vm = self.vm else {
            return
        }
        vm.vAppImage
            .asObservable()
            .subscribe(onNext: { (strUrl) in
                let url = URL(string: strUrl)
                self.ivAppImage.kf.setImage(with: url)
            })
            .disposed(by: disposeBag)

        vm.vAppName
            .asObservable()
            .subscribe(onNext: {
                self.lblAppName.text = $0
            })
            .disposed(by: disposeBag)
        
        vm.vAppCategory
            .asObservable()
            .subscribe(onNext: {
                self.lblAppCategory.text = $0
            })
            .disposed(by: disposeBag)
    }

}
