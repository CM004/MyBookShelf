import Foundation

struct GoogleBooksAPIResponse: Codable {
    let items: [Item]?
}

struct Item: Codable {
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String?
    let authors: [String]?
    let description: String?
} 