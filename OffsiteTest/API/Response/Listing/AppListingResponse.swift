//
//  AppListingResponse.swift
//  OffsiteTest
//
//  Created by Thomas Lam on 21/4/2018.
//  Copyright © 2018 Thomas Lam. All rights reserved.
//

import Foundation
public struct AppListingResponse : Codable {
	let feed : Feed?

	enum CodingKeys: String, CodingKey {

		case feed
	}

	public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        feed = try values.decodeIfPresent(Feed.self, forKey: .feed)
	}

}

public struct Attributes : Codable {
    let rel : String?
    let type : String?
    let href : String?
    
    enum CodingKeys: String, CodingKey {
        
        case rel = "rel"
        case type = "type"
        case href = "href"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rel = try values.decodeIfPresent(String.self, forKey: .rel)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        href = try values.decodeIfPresent(String.self, forKey: .href)
    }
    
}

public struct Author : Codable {
    let name : Name?
    let uri : Uri?
    
    enum CodingKeys: String, CodingKey {
        
        case name
        case uri
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(Name.self, forKey: .name)
        uri = try values.decodeIfPresent(Uri.self, forKey: .uri)
    }
    
}

public struct Category : Codable {
    let attributes : Attributes?
    
    enum CodingKeys: String, CodingKey {
        
        case attributes
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
    }
    
}

public struct Entry : Codable {
    let imname : Imname?
    let imimage : [Imimage]?
    let summary : Summary?
    let imprice : Imprice?
    let imcontentType : ImcontentType?
    let rights : Rights?
    let title : Title?
    let link : Link?
    let id : Id?
    let imartist : Imartist?
    let category : Category?
    let imreleaseDate : ImreleaseDate?
    
    enum CodingKeys: String, CodingKey {
        
        case imname
        case imimage = "imimage"
        case summary
        case imprice
        case imcontentType
        case rights
        case title
        case link
        case id
        case imartist
        case category
        case imreleaseDate
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imname = try values.decodeIfPresent(Imname.self, forKey: .imname)
        imimage = try values.decodeIfPresent([Imimage].self, forKey: .imimage)
        summary = try values.decodeIfPresent(Summary.self, forKey: .summary)
        imprice = try values.decodeIfPresent(Imprice.self, forKey: .imprice)
        imcontentType = try values.decodeIfPresent(ImcontentType.self, forKey: .imcontentType)
        rights = try values.decodeIfPresent(Rights.self, forKey: .rights)
        title = try values.decodeIfPresent(Title.self, forKey: .title)
        link = try values.decodeIfPresent(Link.self, forKey: .link)
        id = try values.decodeIfPresent(Id.self, forKey: .id)
        imartist = try values.decodeIfPresent(Imartist.self, forKey: .imartist)
        category = try values.decodeIfPresent(Category.self, forKey: .category)
        imreleaseDate = try values.decodeIfPresent(ImreleaseDate.self, forKey: .imreleaseDate)
    }
    
}

public struct Feed : Codable {
    let author : Author?
    let entry : [Entry]?
    let updated : Updated?
    let rights : Rights?
    let title : Title?
    let icon : Icon?
    let link : [Link]?
    let id : Id?
    
    enum CodingKeys: String, CodingKey {
        
        case author
        case entry = "entry"
        case updated
        case rights
        case title
        case icon
        case link = "link"
        case id
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author = try values.decodeIfPresent(Author.self, forKey: .author)
        entry = try values.decodeIfPresent([Entry].self, forKey: .entry)
        updated = try values.decodeIfPresent(Updated.self, forKey: .updated)
        rights = try values.decodeIfPresent(Rights.self, forKey: .rights)
        title = try values.decodeIfPresent(Title.self, forKey: .title)
        icon = try values.decodeIfPresent(Icon.self, forKey: .icon)
        link = try values.decodeIfPresent([Link].self, forKey: .link)
        id = try values.decodeIfPresent(Id.self, forKey: .id)
    }
    
}

public struct Icon : Codable {
    let label : String?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
    }
    
}

public struct Id : Codable {
    let label : String?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
    }
    
}

public struct Imartist : Codable {
    let label : String?
    let attributes : Attributes?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
        case attributes
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        attributes = try Attributes(from: decoder)
    }
    
}

public struct ImcontentType : Codable {
    let attributes : Attributes?
    
    enum CodingKeys: String, CodingKey {
        
        case attributes
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
    }
    
}

public struct Imimage : Codable {
    let label : String?
    let attributes : Attributes?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
        case attributes
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
    }
    
}

public struct Imname : Codable {
    let label : String?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
    }
    
}

public struct Imprice : Codable {
    let label : String?
    let attributes : Attributes?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
        case attributes
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
    }
    
}

public struct ImreleaseDate : Codable {
    let label : String?
    let attributes : Attributes?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
        case attributes
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
    }
    
}

public struct Link : Codable {
    let attributes : Attributes?
    
    enum CodingKeys: String, CodingKey {
        
        case attributes
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
    }
    
}

public struct Name : Codable {
    let label : String?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
    }
    
}

public struct Rights : Codable {
    let label : String?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
    }
    
}

public struct Summary : Codable {
    let label : String?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
    }
    
}

public struct Title : Codable {
    let label : String?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
    }
    
}

public struct Updated : Codable {
    let label : String?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
    }
    
}

public struct Uri : Codable {
    let label : String?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
    }
    
}
