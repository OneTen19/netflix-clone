//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by OneTen on 7/1/24.
//

import UIKit

class SearchViewController: UIViewController {

    private var titles: [Title] = [Title]()
    
    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(discoverTable)
        
        discoverTable.delegate = self
        discoverTable.dataSource = self
        
        fetchDiscoverMovies()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }


    private func fetchDiscoverMovies() {
        APICaller.shared.getDiscoverMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.discoverTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, 
                                                       for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: (title.original_title ?? title.name) ?? "Unknown title",
                                            posterURL: title.poster_path ?? ""))
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
