//
//  ViewController.swift
//  ReadMe
//
//  Created by Himanshu  on 15/08/20.
//  Copyright © 2020 Himanshu . All rights reserved.
//

import UIKit

class LibraryHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "\(LibraryHeaderView.self)"
    @IBOutlet var titleLabel: UILabel!
}

class LibraryViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
        tableView.register(UINib(nibName: "\(LibraryHeaderView.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: LibraryHeaderView.reuseIdentifier)
    }
    
    @IBSegueAction func showDetailView(_ coder: NSCoder) -> DetailViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else { fatalError("Nothing Selected!") }
        let book = Library.books[indexPath.row]
        return DetailViewController(coder: coder, book: book)
    }
    
    // MARK:- Delegate
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 1 ? "Read Me!" : nil
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: LibraryHeaderView.reuseIdentifier) as? LibraryHeaderView else { return nil }
        headerView.titleLabel.text = "Read Me!"
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 1 ? 60 : 0
    }
    
    // MARK:- DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : Library.books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath == IndexPath(row: 0, section: 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewBookCell", for: indexPath)
            return cell
        }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BookCell.self)", for: indexPath) as? BookCell else { fatalError("Could not create Bookmark") }
            let book = Library.books[indexPath.row]
            cell.titleLabel.text = book.title
            cell.authorLabel.text = book.author
            cell.bookThumbnail.image = book.image
            cell.bookThumbnail.layer.cornerRadius = 12
            return cell

    }
}

