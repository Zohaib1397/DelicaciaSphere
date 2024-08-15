//
//  User.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 8/15/24.
//

import Foundation
import SwiftData

@Model
class User: Identifiable{
    @Attribute(.unique) var id = UUID()
    var name: String
    var email: String
    var username: String
    var password: String
    
    init(id: UUID = UUID(), name: String, email: String, username: String, password: String) {
        self.id = id
        self.name = name
        self.email = email
        self.username = username
        self.password = password
    }
}

class UserPersistent: Codable {
    var id = UUID()
    var email: String
    var username: String
    var password: String
    
    init(id: UUID = UUID(), email: String, username: String, password: String) {
        self.id = id
        self.email = email
        self.username = username
        self.password = password
    }
}
