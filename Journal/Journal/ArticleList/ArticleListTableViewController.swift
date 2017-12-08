//
//  ArticleListTableViewController.swift
//  Journal
//
//  Created by cindy on 2017/12/8.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//
import Foundation
import UIKit

class ArticleListTableViewController: UITableViewController {
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        
    }
    
    func setUpTableView() {
        
        let nib = UINib(
            nibName: "ArticleListTableViewCell",
            bundle: nil
        )
        
        tableView.register(
            nib,
            forCellReuseIdentifier: "ArticleListTableViewCell"
        )
        
        tableView.estimatedRowHeight = 212
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.separatorStyle = .none
        
    }
    
    


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    @objc func addArticle() {
        
        let editViewController = UITableViewController.loadViewController(
            EditViewController.self,
            from: .edit
        )
        
      
        present(editViewController, animated: true, completion: nil)

    }
   
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.load(nibName:"ArticleHeaderView", bundle: nil) as! ArticleHeaderView
        
        headerView.plusButton.addTarget(self, action: #selector(addArticle), for: .touchUpInside)
        
       return headerView
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return articles.count
    }
    


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            
            withIdentifier: "ArticleListTableViewCell",
            
            for: indexPath
            
        ) as! ArticleListTableViewCell
        
        


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editViewController = EditViewController()
        
        present(editViewController, animated: true)
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension UITableViewController {
    
    static func loadViewController<VC: UIViewController>(_ type: VC.Type, from storyboard: UIStoryboard) -> VC {
        
        let identifier = String(describing: type)
        
        let controller = storyboard
            .instantiateViewController(withIdentifier: identifier)
        
        // swiftlint:disable force_cast
        return controller as! VC
        // swiftlint:enable force_cast
        
    }
    
}
