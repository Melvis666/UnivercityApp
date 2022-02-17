//
//  ListViewModel.swift
//  UnivercityApp
//
//  Created by Назар Гузар on 16.02.2022.
//

import Foundation

protocol ListViewModelDelegate {
    func didUpdateList()
    func didFailWithError(_ text: String)
}

class ListViewModel {
    
    // MARK: - Properties
    
    var delegate: ListViewModelDelegate?

    var universityModels: [UniversityModel] = []
    var selectedUniversity: UniversityModel?
    
    let baseURLString = "http://universities.hipolabs.com/search?country="
    
    // MARK: - Parsing
    
    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    self.delegate?.didFailWithError(error.localizedDescription)
                    return
                }
                if let safeData = data {
                    self.universityModels = self.parseJSON(safeData)
                    self.delegate?.didUpdateList()
                } else {
                    let dataErrorText = "Incorrect data"
                    self.delegate?.didFailWithError(dataErrorText)
                }
            }
            task.resume()
        } else {
            let urlErrorText = "Incorrect URL"
            delegate?.didFailWithError(urlErrorText)
        }
    }
    
    private func parseJSON(_ data: Data) -> [UniversityModel] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([UniversityModel].self, from: data)
            return decodedData
        } catch {
            delegate?.didFailWithError(error.localizedDescription)
            return []
        }
    }

    
    // MARK: - FetchFunc

    func fetchUniversities(countryName: String) {
        var country = countryName
        country.unicodeScalars.removeAll(where: {
            !CharacterSet.whitespaces.contains($0) && !CharacterSet.letters.contains($0)})
        
        let urlString = baseURLString + country.split(separator: " ").joined(separator: "+")
        performRequest(with: urlString)
    }
}

