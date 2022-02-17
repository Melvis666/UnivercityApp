//
//  ListViewController.swift
//  UnivercityApp
//
//  Created by Назар Гузар on 16.02.2022.
//

import UIKit

class ListViewController: UIViewController {

    // MARK: - Properties
    
    let listViewModel: ListViewModel = ListViewModel()
    
    // MARK: - Subviews

    @IBOutlet weak var countryTextField: UITextField! {
        didSet {
           
            countryTextField.delegate = self
            countryTextField.keyboardType = .alphabet
            countryTextField.placeholder = "Enter a university to start"
        }
    }
    @IBOutlet weak var universitiesTableView: UITableView! {
        didSet {
            universitiesTableView.delegate = self
            universitiesTableView.dataSource = self
            universitiesTableView.rowHeight = 50
            universitiesTableView.register(
                UINib(nibName: "UniversityTableViewCell", bundle: nil),
                forCellReuseIdentifier: "universityTableViewCell"
            )
        }
    }
    @IBOutlet weak var noUniversitiesLabel: UILabel! {
        didSet {
            noUniversitiesLabel.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listViewModel.delegate = self
        universitiesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FirstSegue" {
            if let destinationVC = segue.destination as? UniversityViewController,
               let selectedUniversity = listViewModel.selectedUniversity {
                destinationVC.university = selectedUniversity
            }
        }
    }
}

// MARK: - ListViewModelDelegate

extension ListViewController: ListViewModelDelegate {
    func didUpdateList() {
        DispatchQueue.main.async {
            if self.listViewModel.universityModels.isEmpty {
                self.noUniversitiesLabel.text = "No universities found"
                self.noUniversitiesLabel.isHidden = false
                self.universitiesTableView.isHidden = true
            } else {
                self.universitiesTableView.reloadData()
                self.universitiesTableView.isHidden = false
                self.noUniversitiesLabel.isHidden = true
            }
        }
    }
    
    func didFailWithError(_ text: String) {
        DispatchQueue.main.async {
            self.noUniversitiesLabel.text = text
            self.noUniversitiesLabel.isHidden = false
            self.universitiesTableView.isHidden = true
        }
    }
}

// MARK: - UITextFieldDelegate

extension ListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let enteredText = textField.text,
           !enteredText.isEmpty {
            listViewModel.fetchUniversities(countryName: enteredText)
        }
        return true
    }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listViewModel.selectedUniversity = listViewModel.universityModels[indexPath.row]
        performSegue(withIdentifier: "FirstSegue", sender: nil)
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.universityModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "universityTableViewCell", for: indexPath) as? UniversityTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setCountryName(listViewModel.universityModels[indexPath.row].name)
        
        return cell
    }
}
