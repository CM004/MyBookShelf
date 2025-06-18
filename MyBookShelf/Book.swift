import Foundation

struct Book: Codable {
    let title: String
    let authors: [String]?
    let description: String?
} 
