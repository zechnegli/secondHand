//
//  HomeLocationPickerView.swift
//  secondHand
//
//  Created by ZechengLi on 7/15/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit

class HomeLocationPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    private var locations: [location]!
    public var selectedVlaue: String?
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLocations()
        self.showsSelectionIndicator = true
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - initialize locations array
    private func initializeLocations() {
        locations = [location]()
        for loca in location.allLocation {
            locations.append(loca)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locations[row].rawValue
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       selectedVlaue = locations[row].rawValue
    
    }
    
    
    
    

}

//TODO: add more data
extension HomeLocationPickerView {
    enum location: String {
        typealias RawValue = String
        case San_Francisco = "San Francisco"
        case Berkeley
        case Davis
        case Los_Angeles = "Los Angeles"
        case Irvine
        case Santa_Barbara = "Santa_Barbara"
        case San_Diego = "San Diego"
        
        static var allLocation: [location] {
            get {
                var locations = [location]()
                locations.append(location.San_Francisco)
                locations.append(location.Berkeley)
                locations.append(location.Davis)
                locations.append(location.Los_Angeles)
                locations.append(location.Irvine)
                locations.append(location.Santa_Barbara)
                locations.append(location.San_Diego)
                return locations
            }
        }
    }
}


