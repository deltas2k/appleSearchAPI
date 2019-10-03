//
//  SearchResultsTableViewController.swift
//  AppleSearch
//
//  Created by Matthew O'Connor on 10/3/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    @IBAction func segmentControllerValueChange(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
    var musicSearchResults: [MusicSearchResult] = []
    var appSearchResults: [AppSearchResult] = []
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {return}
        
        if segmentedController.selectedSegmentIndex == 0 {
            searchResultController.getMusicItems(searchText: searchText) { (results) in
                self.musicSearchResults = results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.searchBar.text = ""
                }
            }
        } else if segmentedController.selectedSegmentIndex == 1 {
            searchResultController.getAppItems(searchText: searchText) { (results) in
                self.appSearchResults = results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.searchBar.text = ""
                }
            }
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        var count = 0
        
        if segmentedController.selectedSegmentIndex == 0 {
            count = musicSearchResults.count
        } else if segmentedController.selectedSegmentIndex == 1 {
            count = appSearchResults.count
        }
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! ResultTableViewCell
        if segmentedController.selectedSegmentIndex == 0 {
            let searchResultItem = musicSearchResults[indexPath.row]
            cell.musicItem = searchResultItem
        } else if segmentedController.selectedSegmentIndex == 1 {
            let searchResultItem = appSearchResults[indexPath.row]
            cell.appItem = searchResultItem
            
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
