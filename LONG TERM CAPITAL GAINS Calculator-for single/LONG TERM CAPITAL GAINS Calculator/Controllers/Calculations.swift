//
//  Calculations.swift
//  LONG TERM CAPITAL GAINS Calculator
//
//  Created by Anas Mansuri on 23/07/19.
//  Copyright © 2019 Anas Mansuri. All rights reserved.
//

import Foundation

class Calculations
{
    class func calculateValues(quantity : Int, buyingPrice : Double, sellingPrice:Double ) -> (Double, Double){
        
        var  finalValue : Double = 0
        var  LTCG  : Double = 0
        
        let buyingCost = Double(quantity) * buyingPrice
        let sellingCost = Double(quantity) * sellingPrice
        
        let profite = sellingCost - buyingCost
        
        LTCG = profite
        
        if profite > 100000{
            
            let exemption : Double = 100000
            let exvalue  = profite - exemption
            
            let dividevalue = exvalue * 10 / 100
            let cessvalue = dividevalue * 4 / 100
            finalValue = dividevalue + cessvalue
            
            return (LTCG, finalValue)
        }else{
            return (LTCG, 0)
        }
        
    }

}
