//
//  UniversityViewController.swift
//  UniversityApp
//
//  Created by Назар Гузар on 16.02.2022.
//

import UIKit
import WebKit

class UniversityViewController: UIViewController, UIWebViewDelegate {
    
    // MARK: - Properties
    
    var university: UniversityModel?
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - Actions
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        nameLabel.tintColor = UIColor.darkGray
        nameLabel.shadowColor = UIColor.black
        countryLabel.font = UIFont.boldSystemFont(ofSize: 17)
        countryLabel.tintColor = UIColor.darkGray
        codeLabel.font = UIFont.boldSystemFont(ofSize: 17)
        codeLabel.tintColor = UIColor.darkGray
        stateLabel.font = UIFont.boldSystemFont(ofSize: 17)
        stateLabel.tintColor = UIColor.darkGray
        
        guard let university = university else { return }
        
        nameLabel.text = university.name
        countryLabel.text = university.country
        codeLabel.text = university.alphaTwoCode
        if let stateProvince = university.stateProvince,
           !stateProvince.isEmpty {
            stateLabel.text = stateProvince
        } else {
            stateLabel.isHidden = true
        }
        if let webPage = university.webPageURL.first,
           let url = URL(string: webPage) {
            webView.load(URLRequest(url: url))
        }
    }
}

