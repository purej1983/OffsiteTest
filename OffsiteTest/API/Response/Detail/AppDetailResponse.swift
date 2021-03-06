//
//  AppDetailResponse.swift
//  OffsiteTest
//
//  Created by Thomas Lam on 21/4/2018.
//  Copyright © 2018 Thomas Lam. All rights reserved.
//

import Foundation
public struct AppDetailResponse: Codable {
    let resultCount: Int?
    let results: [Results]?

    enum CodingKeys: String, CodingKey {

        case resultCount = "resultCount"
        case results = "results"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resultCount = try values.decodeIfPresent(Int.self, forKey: .resultCount)
        results = try values.decodeIfPresent([Results].self, forKey: .results)
    }

}

public struct Results: Codable {
    let screenshotUrls: [String]?
    let ipadScreenshotUrls: [String]?
    let appletvScreenshotUrls: [String]?
    let artworkUrl512: String?
    let artistViewUrl: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let advisories: [String]?
    let kind: String?
    let features: [String]?
    let supportedDevices: [String]?
    let isGameCenterEnabled: Bool?
    let averageUserRatingForCurrentVersion: Double?
    let languageCodesISO2A: [String]?
    let fileSizeBytes: String?
    let userRatingCountForCurrentVersion: Int?
    let trackContentRating: String?
    let trackCensoredName: String?
    let trackViewUrl: String?
    let contentAdvisoryRating: String?
    let minimumOsVersion: String?
    let currentVersionReleaseDate: String?
    let sellerName: String?
    let primaryGenreId: Int?
    let primaryGenreName: String?
    let isVppDeviceBasedLicensingEnabled: Bool?
    let currency: String?
    let wrapperType: String?
    let version: String?
    let artistId: Int?
    let artistName: String?
    let genres: [String]?
    let price: Int?
    let description: String?
    let bundleId: String?
    let releaseDate: String?
    let trackId: Int?
    let trackName: String?
    let genreIds: [String]?
    let releaseNotes: String?
    let formattedPrice: String?
    let averageUserRating: Double?
    let userRatingCount: Int?

    enum CodingKeys: String, CodingKey {

        case screenshotUrls = "screenshotUrls"
        case ipadScreenshotUrls = "ipadScreenshotUrls"
        case appletvScreenshotUrls = "appletvScreenshotUrls"
        case artworkUrl512 = "artworkUrl512"
        case artistViewUrl = "artistViewUrl"
        case artworkUrl60 = "artworkUrl60"
        case artworkUrl100 = "artworkUrl100"
        case advisories = "advisories"
        case kind = "kind"
        case features = "features"
        case supportedDevices = "supportedDevices"
        case isGameCenterEnabled = "isGameCenterEnabled"
        case averageUserRatingForCurrentVersion = "averageUserRatingForCurrentVersion"
        case languageCodesISO2A = "languageCodesISO2A"
        case fileSizeBytes = "fileSizeBytes"
        case userRatingCountForCurrentVersion = "userRatingCountForCurrentVersion"
        case trackContentRating = "trackContentRating"
        case trackCensoredName = "trackCensoredName"
        case trackViewUrl = "trackViewUrl"
        case contentAdvisoryRating = "contentAdvisoryRating"
        case minimumOsVersion = "minimumOsVersion"
        case currentVersionReleaseDate = "currentVersionReleaseDate"
        case sellerName = "sellerName"
        case primaryGenreId = "primaryGenreId"
        case primaryGenreName = "primaryGenreName"
        case isVppDeviceBasedLicensingEnabled = "isVppDeviceBasedLicensingEnabled"
        case currency = "currency"
        case wrapperType = "wrapperType"
        case version = "version"
        case artistId = "artistId"
        case artistName = "artistName"
        case genres = "genres"
        case price = "price"
        case description = "description"
        case bundleId = "bundleId"
        case releaseDate = "releaseDate"
        case trackId = "trackId"
        case trackName = "trackName"
        case genreIds = "genreIds"
        case releaseNotes = "releaseNotes"
        case formattedPrice = "formattedPrice"
        case averageUserRating = "averageUserRating"
        case userRatingCount = "userRatingCount"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        screenshotUrls = try values.decodeIfPresent([String].self, forKey: .screenshotUrls)
        ipadScreenshotUrls = try values.decodeIfPresent([String].self, forKey: .ipadScreenshotUrls)
        appletvScreenshotUrls = try values.decodeIfPresent([String].self, forKey: .appletvScreenshotUrls)
        artworkUrl512 = try values.decodeIfPresent(String.self, forKey: .artworkUrl512)
        artistViewUrl = try values.decodeIfPresent(String.self, forKey: .artistViewUrl)
        artworkUrl60 = try values.decodeIfPresent(String.self, forKey: .artworkUrl60)
        artworkUrl100 = try values.decodeIfPresent(String.self, forKey: .artworkUrl100)
        advisories = try values.decodeIfPresent([String].self, forKey: .advisories)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
        features = try values.decodeIfPresent([String].self, forKey: .features)
        supportedDevices = try values.decodeIfPresent([String].self, forKey: .supportedDevices)
        isGameCenterEnabled = try values.decodeIfPresent(Bool.self, forKey: .isGameCenterEnabled)
        averageUserRatingForCurrentVersion = try values.decodeIfPresent(Double.self, forKey: .averageUserRatingForCurrentVersion)
        languageCodesISO2A = try values.decodeIfPresent([String].self, forKey: .languageCodesISO2A)
        fileSizeBytes = try values.decodeIfPresent(String.self, forKey: .fileSizeBytes)
        userRatingCountForCurrentVersion = try values.decodeIfPresent(Int.self, forKey: .userRatingCountForCurrentVersion)
        trackContentRating = try values.decodeIfPresent(String.self, forKey: .trackContentRating)
        trackCensoredName = try values.decodeIfPresent(String.self, forKey: .trackCensoredName)
        trackViewUrl = try values.decodeIfPresent(String.self, forKey: .trackViewUrl)
        contentAdvisoryRating = try values.decodeIfPresent(String.self, forKey: .contentAdvisoryRating)
        minimumOsVersion = try values.decodeIfPresent(String.self, forKey: .minimumOsVersion)
        currentVersionReleaseDate = try values.decodeIfPresent(String.self, forKey: .currentVersionReleaseDate)
        sellerName = try values.decodeIfPresent(String.self, forKey: .sellerName)
        primaryGenreId = try values.decodeIfPresent(Int.self, forKey: .primaryGenreId)
        primaryGenreName = try values.decodeIfPresent(String.self, forKey: .primaryGenreName)
        isVppDeviceBasedLicensingEnabled = try values.decodeIfPresent(Bool.self, forKey: .isVppDeviceBasedLicensingEnabled)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        wrapperType = try values.decodeIfPresent(String.self, forKey: .wrapperType)
        version = try values.decodeIfPresent(String.self, forKey: .version)
        artistId = try values.decodeIfPresent(Int.self, forKey: .artistId)
        artistName = try values.decodeIfPresent(String.self, forKey: .artistName)
        genres = try values.decodeIfPresent([String].self, forKey: .genres)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        bundleId = try values.decodeIfPresent(String.self, forKey: .bundleId)
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
        trackId = try values.decodeIfPresent(Int.self, forKey: .trackId)
        trackName = try values.decodeIfPresent(String.self, forKey: .trackName)
        genreIds = try values.decodeIfPresent([String].self, forKey: .genreIds)
        releaseNotes = try values.decodeIfPresent(String.self, forKey: .releaseNotes)
        formattedPrice = try values.decodeIfPresent(String.self, forKey: .formattedPrice)
        averageUserRating = try values.decodeIfPresent(Double.self, forKey: .averageUserRating)
        userRatingCount = try values.decodeIfPresent(Int.self, forKey: .userRatingCount)
    }

}
