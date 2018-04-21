//
//  ViewController.swift
//  OffsiteTest
//
//  Created by Thomas Lam on 21/4/2018.
//  Copyright © 2018 Thomas Lam. All rights reserved.
//

import RxSwift

final class MainViewController: UIViewController {
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func TopFree(_ sender: Any) {
        APIManager.Listing.getTopNFreeApps(n: 10).subscribe(onNext: { (response) in
            print("Top Free")
        }).disposed(by: disposeBag)
        
    }
    
    @IBAction func TopGrossing(_ sender: Any) {
        APIManager.Listing.getTopNGrossingApps(n: 10).subscribe(onNext: { (response) in
            print("Top Grossing")
        }).disposed(by: disposeBag)
    }
    @IBAction func GoToDetail(_ sender: Any) {
        APIManager.Detail.getAppDetails(id: "554499054").subscribe(onNext: { (response) in
            print("Top Free")
        }).disposed(by: disposeBag)
    }
}

