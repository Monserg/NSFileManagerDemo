//
//  ViewController.swift
//  NSFileManagerDemo
//
//  Created by msm72 on 08.05.17.
//  Copyright © 2017 Omniesoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Propvaries
    var folders = [Folder]()
    var selectedFolder: Folder!
    let items: [FileManager.SearchPathDirectory] = [.adminApplicationDirectory, .applicationDirectory, .applicationSupportDirectory, .cachesDirectory, .demoApplicationDirectory, .coreServiceDirectory, .developerDirectory, .documentationDirectory, .demoApplicationDirectory, .documentDirectory, .downloadsDirectory, .libraryDirectory, .picturesDirectory, .userDirectory]
    
    // Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    
    // MARK: - Class Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for value in items {
            if let folder = Folder.init(fromSearchPathDirectory: value) {
                folders.append(folder)
            }
        }
        
        let tempFolder = Folder.init(withURL: URL.init(string: NSTemporaryDirectory())!)
        folders.append(tempFolder)
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Custom Functions
    func alertViewDidShow(withTitle title: String, andMessage message: String, completion: @escaping (() -> ())) {
        let alertViewController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        let alertViewControllerAction = UIAlertAction.init(title: "Ok", style: .default, handler: { action in
            return completion()
        })
        
        alertViewController.addAction(alertViewControllerAction)
        present(alertViewController, animated: true, completion: nil)
    }
    
    func fileDidSave(withMessage message: String) {
        if (selectedFolder.name == "Documents") {
            alertViewDidShow(withTitle: "Info", andMessage: "\(message) in a \'Documents\' folder", completion: { _ in })
            print("Selected folder is \'\(selectedFolder.name)\' - alert view show")
        } else {
            print("Selected folder is \'\(selectedFolder.name)\' - alert view hide")
        }
    }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UINib(nibName: cellIdentifier, bundle: nil).instantiate(withOwner: nil, options: nil).first as! UITableViewCell?
        }
        
        let folder = folders[indexPath.row]
        cell!.textLabel?.text = folder.name
        cell!.accessoryType = (folder.isSelected) ? .checkmark : .none
        
        return cell!
    }
}


// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell!.accessoryType = .checkmark
        folders[indexPath.row].isSelected = true
        
        selectedFolder = folders[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell!.accessoryType = .none
        folders[indexPath.row].isSelected = false
    }
}
