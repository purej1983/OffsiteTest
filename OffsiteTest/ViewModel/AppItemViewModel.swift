//
//  AppItemViewModel.swift
//  OffsiteTest
//
//  Created by Thomas Lam on 22/4/2018.
//  Copyright © 2018 Thomas Lam. All rights reserved.
//

import RxSwift
final class AppItemViewModel {
    public let id: String!
    public let vAppName: Variable<String> = Variable<String>("")
    public let vAppImage: Variable<String> = Variable<String>("")
    public let vAppCategory: Variable<String> = Variable<String>("")
    public let vAppUserRating: Variable<Double?> = Variable<Double?>(nil)
    public let vAppUserCommentCount: Variable<Int?> = Variable<Int?>(nil)
    private let name: String!
    private let category: String!
    private let author: String!
    private let summary: String!




    public convenience init(entry: Entry) {
        let id = entry.id?.attributes?.imid ?? ""
        let name = entry.imname?.label ?? ""
        let image = entry.imimage?[1].label ?? ""
        let category = entry.category?.attributes?.label ?? ""
        let author = entry.imartist?.label ?? ""
        let summary = entry.summary?.label ?? ""
        self.init(id: id, name: name, image: image, category: category, author: author, summary: summary)
    }

    private init(id: String,
                 name: String,
                 image: String,
                 category: String,
                 author: String,
                 summary: String,
                 rating: Double? = nil,
                 commentCount: Int? = nil) {
        self.id = id
        self.vAppName.value = name
        self.vAppImage.value = image
        self.vAppCategory.value = category
        self.vAppUserRating.value = rating
        self.vAppUserCommentCount.value = commentCount

        self.name = name
        self.category = category
        self.author = author
        self.summary = summary
    }

    public func containsKeyWord(text: String) -> Bool {

        return self.name.contains(text) ||
            self.category.contains(text) ||
            self.summary.contains(text) ||
            self.author.contains(text)
    }
}
