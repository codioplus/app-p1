/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Json4Swift_Base : Codable {
	let mom_ref : String?
	let uid : String?
	let country_name : String?
	let country_name_ar : String?
	let country_id : Int?
	let doctor_id : Int?
	let doctor_name : String?
	let doctor_ref : String?
	let profile_image : String?
	let mom_name : String?
	let kid : [Kid]?

	enum CodingKeys: String, CodingKey {

		case mom_ref = "mom_ref"
		case uid = "uid"
		case country_name = "country_name"
		case country_name_ar = "country_name_ar"
		case country_id = "country_id"
		case doctor_id = "doctor_id"
		case doctor_name = "doctor_name"
		case doctor_ref = "doctor_ref"
		case profile_image = "profile_image"
		case mom_name = "mom_name"
		case kid = "kid"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		mom_ref = try values.decodeIfPresent(String.self, forKey: .mom_ref)
		uid = try values.decodeIfPresent(String.self, forKey: .uid)
		country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
		country_name_ar = try values.decodeIfPresent(String.self, forKey: .country_name_ar)
		country_id = try values.decodeIfPresent(Int.self, forKey: .country_id)
		doctor_id = try values.decodeIfPresent(Int.self, forKey: .doctor_id)
		doctor_name = try values.decodeIfPresent(String.self, forKey: .doctor_name)
		doctor_ref = try values.decodeIfPresent(String.self, forKey: .doctor_ref)
		profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
		mom_name = try values.decodeIfPresent(String.self, forKey: .mom_name)
		kid = try values.decodeIfPresent([Kid].self, forKey: .kid)
	}

}
