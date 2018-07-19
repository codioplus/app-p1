/*
 Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar
 
 */

import Foundation
import ObjectMapper

struct Chart : Mappable {
    var id : String?
    var age : String?
    var l : String?
    var m : String?
    var s : String?
    var p01 : String?
    var p1 : String?
    var p3 : String?
    var p5 : String?
    var p10 : String?
    var p15 : String?
    var p25 : String?
    var p50 : String?
    var p75 : String?
    var p85 : String?
    var p90 : String?
    var p95 : String?
    var p97 : String?
    var p99 : String?
    var p999 : String?
    var gender : String?
    var type : String?
    
     init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        age <- map["age"]
        l <- map["l"]
        m <- map["m"]
        s <- map["s"]
        p01 <- map["p01"]
        p1 <- map["p1"]
        p3 <- map["p3"]
        p5 <- map["p5"]
        p10 <- map["p10"]
        p15 <- map["p15"]
        p25 <- map["p25"]
        p50 <- map["p50"]
        p75 <- map["p75"]
        p85 <- map["p85"]
        p90 <- map["p90"]
        p95 <- map["p95"]
        p97 <- map["p97"]
        p99 <- map["p99"]
        p999 <- map["p999"]
        gender <- map["gender"]
        type <- map["type"]
    }
    
}
