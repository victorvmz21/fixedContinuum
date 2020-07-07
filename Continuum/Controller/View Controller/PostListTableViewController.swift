//
//  PostListTableViewController.swift
//  Continuum
//
//  Created by Victor Monteiro on 6/30/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    var results: [Post] = []
    var isSearching: Bool = false
    var dataSource: [Post] {
        return isSearching ? results : PostController.shared.posts
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        results = PostController.shared.posts
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        
        let post = PostController.shared.posts[indexPath.row]
        cell.post = post

        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVc" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let posts = PostController.shared.posts[indexPath.row]
            guard let destinationVC = segue.destination as? PostDetailTableViewController else { return }
            destinationVC.posts = posts
        }
    }
}

extension PostListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.isEmpty {
            results = PostController.shared.posts.filter { $0.matches(searchTerm: searchText) }
            tableView.reloadData()
        } else {
            results = PostController.shared.posts
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        results = PostController.shared.posts
        tableView.reloadData()
        
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
}
