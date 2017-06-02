//
//  AllUsersTableViewController.swift
//  SwotseAPI
//
//  Created by Sergey Leskov on 6/1/17.
//  Copyright © 2017 Sergey Leskov. All rights reserved.
//

import UIKit
import CoreData

class AllUsersTableViewController: UITableViewController {
    
    //==================================================
    // MARK: - Stored Properties
    //==================================================
    lazy var fetchResultController: NSFetchedResultsController<User> = {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }()
    
    
    //==================================================
    // MARK: - Main
    //==================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate
        fetchResultController.delegate = self
        
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error)
        }
        
        refreshUsers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //==================================================
    // MARK: - Table view data source
    //==================================================
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchResultController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let sections = fetchResultController.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AllUsersTableViewCell
        
        let user = fetchResultController.object(at: indexPath)
        
        cell.nameUI.text = user.userName
        
        if let lastLogin = user.lastLogin {
            cell.lastLogin.text = DateManager.dateAndTimeToString(date: lastLogin)
        } else {
            cell.lastLogin.text = "-"
        }
        
        
        return cell
    }
    
    
    //==================================================
    // MARK: - action
    //==================================================
    
    func refreshUsers()  {
        UserManager.getAllUsers() { (error) in
            if let error = error  {
                MessagerManager.showMessage(title: "Error", message: error, theme: .error, view: self.view)
                return
            }
        }

    }
    
    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
        refreshUsers()
    }
    
}


//==================================================
// MARK: - NSFetchedResultsControllerDelegate
//==================================================
extension AllUsersTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}

