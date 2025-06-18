import Foundation

class GoogleBooksAPIService {

    static let shared = GoogleBooksAPIService() // Singleton

    private init() {}

    private let decodeBooks: (Data) throws -> [Book]? = { data in
        let apiResponse = try JSONDecoder().decode(GoogleBooksAPIResponse.self, from: data)
        return apiResponse.items?.compactMap { item in
            guard let title = item.volumeInfo.title else { return nil }
            return Book(title: title, authors: item.volumeInfo.authors, description: item.volumeInfo.description)
        }
    }

    private let sortBooksByTitle: ([Book]?) -> [Book]? = { books in
        return books?.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
    }

    func fetchBooks(query: String) async throws -> [Book]? {
        let formattedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(formattedQuery)") else {
            throw NSError(domain: "GoogleBooksAPIService", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let decodedBooks = try decodeBooks(data)
        let sortedBooks = sortBooksByTitle(decodedBooks)

        if let sortedBooks = sortedBooks {
            print("Fetched \(sortedBooks.count) books related to \"\(query)\".")
        }

        return sortedBooks
    }
}
