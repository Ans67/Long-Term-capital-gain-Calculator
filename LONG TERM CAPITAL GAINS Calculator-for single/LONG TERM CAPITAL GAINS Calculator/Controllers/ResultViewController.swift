//
//  ResultViewController.swift
//  LONG TERM CAPITAL GAINS Calculator
//
//  Created by Anas Mansuri on 26/07/19.
//  Copyright © 2019 Anas Mansuri. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var lblTotalLTCG: UILabel!
    @IBOutlet weak var lblExemption: UILabel!
    @IBOutlet weak var lblcessTax: UILabel!
    
    var totalLTCG = ""
    var totalCessTax = ""
    
    class func present(totalLTCGText: String, totalCesstax: String, from controller: UIViewController) {
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController {
            vc.totalLTCG = totalLTCGText
            vc.totalCessTax = totalCesstax
            controller.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupValues()
    }
    
    func setupValues(){
        self.lblTotalLTCG.text = totalLTCG
        self.lblcessTax.text = totalCessTax
    }
    
    @IBAction func buttonback_cliked(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
}
