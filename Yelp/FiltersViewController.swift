//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Tushar Humbe on 10/22/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    @objc optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String:AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FilterTableViewCellDelegate {

    @IBOutlet weak var dealSwitch: UISwitch!
    @IBOutlet weak var distanceTableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortTableView: UITableView!
    var delegate: FiltersViewControllerDelegate?
    var selectedSort: YelpSortMode?
    var selectedDistance: Float?
    var selectedDeal: Bool?
    
    var distanceData = ["0.3 miles", "1 mile", "5 miles", "20 miles"]
    var distanceDataMiles = [Float](arrayLiteral: 482.8, 1609.3, 8046.72, 32186.9)
    var sortData : [YelpSortMode] = [YelpSortMode.bestMatched, YelpSortMode.distance, YelpSortMode.highestRated];
    var switchStates = [Int:Bool]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.red;
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        distanceTableView.delegate = self;
        distanceTableView.dataSource = self;
        
        sortTableView.delegate = self;
        sortTableView.dataSource = self;
        
    }
    
    @IBAction func onDealValueChanged(_ sender: AnyObject) {
        selectedDeal = dealSwitch.isOn
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if tableView == self.distanceTableView {
            let distanceCell = tableView.dequeueReusableCell(withIdentifier: "DistanceTableView.identifier", for: indexPath) as! DistanceTableViewCell
            distanceCell.distanceLabel!.text = distanceData[indexPath.row];
            return distanceCell
        }
        if tableView == self.sortTableView {
            let sortCell = tableView.dequeueReusableCell(withIdentifier: "SortTableView.identifier", for: indexPath) as! SortTableViewCell
            switch(sortData[indexPath.row]) {
                case YelpSortMode.bestMatched:
                    sortCell.sortLabel.text = "Best Matched"
                break
                
            case YelpSortMode.distance:
                sortCell.sortLabel.text = "Distance"
                break
                
            case YelpSortMode.highestRated:
                sortCell.sortLabel.text = "Highest Rated"
                break
                
            }
            return sortCell
        }
        
        if tableView == self.tableView {
            let categoryCell = tableView.dequeueReusableCell(withIdentifier: "FilterTableView.identifier", for: indexPath) as! FilterTableViewCell
            categoryCell.FilterNameLabel.text = categories[indexPath.row]["name"]
            categoryCell.delegate = self
            
            categoryCell.filterSwitch.isOn = switchStates[indexPath.row] ?? false
            return categoryCell;
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.distanceTableView {
            return distanceData.count;
        }
        
        if tableView == self.sortTableView {
            return sortData.count;
        }
        if tableView == self.tableView {
            return categories.count
        }
        
        return 0;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.sortTableView {
            selectedSort = sortData[indexPath.row]
        }
        if tableView == self.distanceTableView {
            selectedDistance = distanceDataMiles[indexPath.row]
        }
        
    }
    
    //tableView
    
    func filterSwitch(filterCell: FilterTableViewCell, didChangeValue: Bool) {
        let indexPath = tableView.indexPath(for: filterCell)!
        switchStates[indexPath.row] = didChangeValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onSearch(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        var filters = [String: AnyObject]()
        
        var selectedCat = [String]()
        for (row, isSelected) in switchStates {
            if (isSelected) {
                selectedCat.append(categories[row]["code"]!)
            }
        }
        if (selectedCat.count > 0) {
            filters["categories"] = selectedCat as AnyObject
        }
        if selectedSort != nil {
            filters["sort"] = selectedSort as AnyObject
        }
        if selectedDistance != nil {
            filters["distance"] = selectedDistance as AnyObject
        }
        if selectedDeal != nil {
            filters["deal"] = selectedDeal as AnyObject
        }
        
        
        
        delegate?.filtersViewController!(filtersViewController: self, didUpdateFilters: filters)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    let categories = [["name" : "Afghan", "code": "afghani"]
                    ]

}
