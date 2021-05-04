//
//  EntriesTableViewController.swift
//  Daily Journal
//
//  Created by Harris Zacharis on 4/5/21.
//

import UIKit

class EntriesTableViewController: UITableViewController {
    
    var entries = [Entry]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let entriesFromCoreData = try? context.fetch(Entry.fetchRequest()) as? [Entry] {
                entries = entriesFromCoreData
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let entry = entries[indexPath.row]
        
        cell.textLabel?.text = entry.text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = entries[indexPath.row]
        performSegue(withIdentifier: "segueToEntry", sender: entry)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let entryVC = segue.destination as? EntryViewController {
            if let entryToBePassed = sender as? Entry {
                entryVC.entry = entryToBePassed
            }
        }
    }
}
