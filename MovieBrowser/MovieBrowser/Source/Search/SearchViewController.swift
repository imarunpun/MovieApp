//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Arun on 28/10/21.
//  Copyright © 2021 Arun. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: String(describing: MovieTVCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieTVCell.self))
        }
    }
    
    var movies = [Movie]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? MovieDetailViewController, let indexPath = sender as? IndexPath {
            viewController.movie = movies[indexPath.row]
        }
    }
    
    @IBAction func searchGoClicked() {
        if let text = searchBar.text {
            searchMovie(query: text.lowercased())
        }
    }
    
    func searchMovie(query: String) {
        let url = String(format: ApiList.searchMovie, query)
        guard let request = URLRequest.createRequestWith(url: url, method: .get) else {
            return
        }
        
        NetworkManager.sharedManager.callWith(request: request, completion: { (result: Result<MovieResults, Error>) in
            switch result {
            case .success(let response):
                self.movies = response.results
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        })
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            movies.removeAll()
            tableView.reloadData()
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieTVCell.self), for: indexPath) as? MovieTVCell else {
            return UITableViewCell()
        }
        
        let movie = movies[indexPath.row]
        cell.configureWith(movie: movie, imageSize: ImageSize.small)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "showMovieDetail", sender: indexPath)
    }
}
