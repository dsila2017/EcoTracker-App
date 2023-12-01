//
//  SpeciesResultView.swift
//  EcoTracker App
//
//  Created by nika razmadze on 30.11.23.
//

import UIKit

final class SpeciesResultView: UIViewController {

    var cityID: Int = 0
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = CustomColors.background
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SpeciesTableViewCell.self, forCellReuseIdentifier: "speciesCell")
        return tableView
    }()
    
    private var viewModel = SpeciesResultsViewModel()
    private var species = [SpeciesInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColors.background
        setupTableView()
        fetchData()
    }
    
    private func fetchData(){
        viewModel.fetchSpeciesInfo(for: cityID) { [weak self] result in
            switch result {
            case .success(let species):
                self?.species = species
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching species info: \(error)")
            }
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}

extension SpeciesResultView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        species.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "speciesCell", for: indexPath) as? SpeciesTableViewCell else {
            fatalError("Could not dequeue NewsCell")
        }
        cell.configure(with: species[indexPath.row])
        return cell
    }
}


