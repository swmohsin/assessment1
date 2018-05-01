//
//  Topic.swift
//  assessment1
//
//  Created by Admin on 2018-04-30.
//  Copyright © 2018 Test. All rights reserved.
//

struct Icon: Decodable {
    let url:String?
    
    enum CodingKeys: String, CodingKey {
        case url = "URL"
    }
}

struct Topic: Decodable {
    let text:String?
    let icon:Icon?
    let url:String?
    let name:String?
    let topics:[Topic]?
    
    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case url = "FirstURL"
        case name = "Name"
        case icon = "Icon"
        case topics = "Topics"
    }
}

struct Topics: Decodable {
    let topics: [Topic]
    
    enum CodingKeys: String, CodingKey {
        case topics = "RelatedTopics"
    }
}
