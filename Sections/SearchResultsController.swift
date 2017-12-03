//
//  SearchResultsController.swift
//  Sections
//
//  Created by Victor Smirnov on 03/12/2017.
//  Copyright © 2017 Victor Smirnov. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController, UISearchResultsUpdating {
  
  private static let longNameSize = 6
  private static let shortNameButtonIndex = 1
  private static let longNamesButtonIndex = 2
  
  let sectionsTableIdentifier = "SectionsTableIdentifier"
  var names: [String :[String]] = [String: [String]]()
  var keys: [String] = []
  var filteredNames: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: sectionsTableIdentifier)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return filteredNames.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: sectionsTableIdentifier)
    cell?.textLabel?.text = filteredNames[indexPath.row]
    return cell!
  }
  
  // MARK: Search Results Updater Delegate
  func updateSearchResults(for searchController: UISearchController) {
    if let searchString = searchController.searchBar.text {
      let buttonIndex = searchController.searchBar.selectedScopeButtonIndex
      filteredNames.removeAll(keepingCapacity: true)
      
      if !searchString.isEmpty {
        let filter: (String) -> Bool = { name in
          let nameLength = name.count
          if (buttonIndex == SearchResultsController.shortNameButtonIndex && nameLength >= SearchResultsController.longNameSize) || (buttonIndex == SearchResultsController.longNamesButtonIndex && nameLength < SearchResultsController.longNameSize) {
            return false
          }
          let range = name.range(of: searchString, options: NSString.CompareOptions.caseInsensitive, range: nil, locale: nil)
          return range != nil
        }
        for key in keys {
          let namesForKey = names[key]!
          let matches = namesForKey.filter(filter)
          filteredNames += matches
        }
      }
    }
    tableView.reloadData()
  }
  
}
