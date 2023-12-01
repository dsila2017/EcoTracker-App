//
//  SpeciesResultView.swift
//  EcoTracker App
//
//  Created by nika razmadze on 30.11.23.
//

import UIKit

final class SpeciesResultView: UIViewController {
    private var city: City?
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = CustomColors.background
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SpeciesTableViewCell.self, forCellReuseIdentifier: "speciesCell")
        return tableView
    }()
    
    private var viewModel = SpeciesResultsViewModel()
    private var species = [SpeciesInfo]()
    
    //MARK: - Init
    init(city: City?) {
        super.init(nibName: nil, bundle: nil)
        self.city = city
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColors.background
        viewModel.delegate = self
        setupTableView()
        fetchData()
    }
    
    private func fetchData(){
        if let cityID = city?.id {
            viewModel.viewDidLoad(for: cityID)
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

//MARK: - TableView DataSource
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

//MARK: - ViewModel Delegate
extension SpeciesResultView: SpeciesResultViewDelegate {
    func speciesFetched(_ species: [SpeciesInfo]) {
        self.species = species
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        print("error")
    }
    
    
}
