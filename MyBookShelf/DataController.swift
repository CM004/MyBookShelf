import Foundation

class DataController {

    static let shared = DataController() // Singleton instance

    private let booksKey = "myBookshelfBooks"
    private var books: [Book] = []

    private init() {
        loadBooks()
    }

    

    func getBooks() -> [Book] {
        return books
    }

    func addBook(_ book: Book) {
        if !books.contains(where: { $0.title == book.title }) { // Avoid duplicates by title
            books.append(book)
            saveBooks()
        }
    }

    func addBooks(_ newBooks: [Book]) {
        for book in newBooks {
            if !books.contains(where: { $0.title == book.title }) {
                books.append(book)
            }
        }
        books.sort { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
        saveBooks()
    }

    func removeBook(at index: Int) {
        guard index >= 0 && index < books.count else { return }
        books.remove(at: index)
        saveBooks()
    }

    

    private func saveBooks() {
        let fileURL = booksFileURL()
        do {
            let data = try PropertyListEncoder().encode(books)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save books to plist: \(error)")
        }
    }

    private func loadBooks() {
        let fileURL = booksFileURL()
        do {
            let data = try Data(contentsOf: fileURL)
            books = try PropertyListDecoder().decode([Book].self, from: data)
        } catch {
            print("Failed to load books from plist: \(error)")
            books = []
        }
    }

    private func booksFileURL() -> URL {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("Books.plist")
    }
}
