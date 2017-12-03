//
//  ViewController.swift
//  Sections
//
//  Created by Victor Smirnov on 03/12/2017.
//  Copyright © 2017 Victor Smirnov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
  
  var sectionTableIdentifier = "SectionTableIdentifier"
  var names: [String: [String]]!
  var keys: [String]!

  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: sectionTableIdentifier)
    let path = Bundle.main.path(forResource: "sortednames", ofType: "plist")
    let nameDict = NSDictionary(contentsOfFile: path!)
    names = nameDict as! [String: [String]]
    keys = (nameDict!.allKeys as! [String]).sorted()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: Table Data Source
  func numberOfSections(in tableView: UITableView) -> Int {
    return keys.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let key = keys[section]
    let nameSection = names[key]!
    return nameSection.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return keys[section]
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: sectionTableIdentifier, for: indexPath)
    let key = keys[indexPath.section]
    let nameSection = names[key]!
    cell.textLabel?.text = nameSection[indexPath.row]
    return cell
  }
  
}

