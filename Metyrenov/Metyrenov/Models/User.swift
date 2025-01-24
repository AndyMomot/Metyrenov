//
//  User.swift

import Foundation

struct User: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    var name: String
    var type: UserType
}

extension User {
    enum UserType: Codable {
        case company
        case personal
        
        var imageName: String {
            switch self {
            case .company:
                return Asset.companyType.name
            case .personal:
                return Asset.personalType.name
            }
        }
        
        var displayName: String {
            switch self {
            case .company:
                return "Właściciel firmy"
            case .personal:
                return "Osoba prywatna"
            }
        }
    }
}
