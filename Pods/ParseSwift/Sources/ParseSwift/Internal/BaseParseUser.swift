//
//  BaseParseUser.swift
//  
//
//  Created by Pranjal Satija on 7/19/20.
//

import Foundation

/// Used internally to form a concrete type representing `ParseUser`.
internal struct BaseParseUser: ParseUser {
    var authData: [String: [String: String]?]?
    var username: String?
    var email: String?
    var password: String?
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
}
