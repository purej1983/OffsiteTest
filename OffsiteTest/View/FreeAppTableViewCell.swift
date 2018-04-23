//
//  FreeAppTableViewCell.swift
//  OffsiteTest
//
//  Created by Thomas Lam on 22/4/2018.
//  Copyright © 2018 Thomas Lam. All rights reserved.
//

import RxSwift
import Kingfisher
import Cosmos

final class FreeAppTableViewCell: UITableViewCell {
    private let disposeBag = DisposeBag()
    @IBOutlet weak var lblRowNum: UILabel!
    @IBOutlet weak var ivAppImage: UIImageView!
    @IBOutlet weak var lblAppName: UILabel!
    @IBOutlet weak var lblAppCategory: UILabel!
    @IBOutlet weak var vRating: CosmosView!
    private var vm: AppItemViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
        
        vm.vAppUserRating
            .asObservable()
            .subscribe(onNext: { (rating) in
                self.vRating.rating = rating ?? 0.0
            })
            .disposed(by: disposeBag)
        
        vm.vAppUserCommentCount
            .asObservable()
            .subscribe(onNext: { (rating) in
                if let rating = rating {
                    self.vRating.text = "\(rating)"
                } else {
                    self.vRating.text = ""
                }
            })
            .disposed(by: disposeBag)
    }
    
}
