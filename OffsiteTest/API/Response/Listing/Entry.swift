/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Entry : Codable {
	let im:name : Im:name?
	let im:image : [Im:image]?
	let summary : Summary?
	let im:price : Im:price?
	let im:contentType : Im:contentType?
	let rights : Rights?
	let title : Title?
	let link : Link?
	let id : Id?
	let im:artist : Im:artist?
	let category : Category?
	let im:releaseDate : Im:releaseDate?

	enum CodingKeys: String, CodingKey {

		case im:name
		case im:image = "im:image"
		case summary
		case im:price
		case im:contentType
		case rights
		case title
		case link
		case id
		case im:artist
		case category
		case im:releaseDate
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		im:name = try Im:name(from: decoder)
		im:image = try values.decodeIfPresent([Im:image].self, forKey: .im:image)
		summary = try Summary(from: decoder)
		im:price = try Im:price(from: decoder)
		im:contentType = try Im:contentType(from: decoder)
		rights = try Rights(from: decoder)
		title = try Title(from: decoder)
		link = try Link(from: decoder)
		id = try Id(from: decoder)
		im:artist = try Im:artist(from: decoder)
		category = try Category(from: decoder)
		im:releaseDate = try Im:releaseDate(from: decoder)
	}

}