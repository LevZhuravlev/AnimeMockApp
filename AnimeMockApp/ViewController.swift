//
//  ViewController.swift
//  AnimeMockApp
//
//  Created by Журавлев Лев on 01.12.2023.
//

import UIKit

class ViewController: UIViewController {

    let animeDetailService = AnimeDetailService()
    let reportService = ReportService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportService.fetchReport(for: .anime) { report, err in
            print(report)
        }
                
        
        let exampleAnimeId = "4658"
        animeDetailService.fetchAnimeDetails(for: exampleAnimeId) { result in
            switch result {
            case .success(let reponse):
                print(reponse)
            case .failure(let error):
                print(error)
            }
        }
    }


}

