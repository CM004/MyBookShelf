//
//  BooksTableViewController.swift
//  MyBookShelf
//
//  Created by Chandramohan  on 17/06/25.
//

import UIKit

class BooksTableViewController: UITableViewController {

    private var books: [Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Swift Books Collection"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BookCell")

        // Setup Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(fetchBooksAndReload), for: .valueChanged)
        
        fetchBooksAndReload()

        let headerLabel = UILabel()
        headerLabel.text = "Swift Books Collection"
        headerLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        headerLabel.textAlignment = .center
        headerLabel.numberOfLines = 0
        headerLabel.backgroundColor = .white
        headerLabel.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 60)
        tableView.tableHeaderView = headerLabel
    }

    @objc private func fetchBooksAndReload() {
        Task {
            do {
                let fetchedBooks = try await GoogleBooksAPIService.shared.fetchBooks(query: "Swift")
                if let books = fetchedBooks {
                    DataController.shared.addBooks(books)
                }
                self.books = DataController.shared.getBooks()
                self.tableView.reloadData()
            } catch {
                print("Error fetching books: \(error.localizedDescription)")
            }
            self.refreshControl?.endRefreshing()
        }
    }

}
extension BooksTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "BookCell")
        let book = books[indexPath.row]
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.authors?.joined(separator: ", ") ?? "Unknown Author"
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        
            DataController.shared.removeBook(at: indexPath.row)
            self.books = DataController.shared.getBooks()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    }

// MARK: - Table view data source



//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return books.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "BookCell")
//        let book = books[indexPath.row]
//        cell.textLabel?.text = book.title
//        cell.detailTextLabel?.text = book.authors?.joined(separator: ", ") ?? "Unknown Author"
//        cell.textLabel?.numberOfLines = 0
//        cell.detailTextLabel?.numberOfLines = 0
//        return cell
//    }
//
//    // MARK: - Table view delegate
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//
//            DataController.shared.removeBook(at: indexPath.row)
//            self.books = DataController.shared.getBooks()
//
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }

/*
// Override to support conditional editing of the table view.
override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
}
*/

/*
// Override to support editing the table view.
override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        // Delete the row from the data source
        tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
*/

/*
// Override to support rearranging the table view.
override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

}
*/

/*
// Override to support conditional rearranging of the table view.
override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
}
*/

/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}
*/
