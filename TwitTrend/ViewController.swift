//
//  ViewController.swift
//  TwitTrend
//
//  Created by Majd Khadra on 2022-02-03.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        manageConstraints()
        view.backgroundColor = .systemBlue
        // Do any additional setup after loading the view.
    }

}

extension ViewController {
    func manageConstraints() {
        let views: [String : UIView] = [<#string#>:<#view#>]
        let metrics: [String: CGFloat] = [<#string#>:<#metric#>]
        let constraints: [String] = [<#string#>]
        
        view.addConstraints(constraints: constraints, metrics: metrics, views: views)
    }
}
