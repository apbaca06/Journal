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
        
        
//        let nib2 = UINib(
//            nibName: "ArticleHeaderView",
//            bundle: nil
//        )
//
//        tableView.register(nib2, forHeaderFooterViewReuseIdentifier: "ArticleHeaderView")
        
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
   
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

//        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ArticleHeaderView")
//            as! ArticleHeaderView
        
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        headerView.backgroundColor = .white
        
        let title = UILabel(frame: CGRect(x: 30, y: 14, width: 200, height: 24))
        
        title.text = "My Journals"
        
        title.textColor = UIColor(red: 67/255, green: 87/255, blue: 97/255, alpha: 1)
        
        headerView.addSubview(title)
        
        let plusButton = UIButton(frame: CGRect(x: 323, y: 2, width: 44, height: 44))
        
        headerView.addSubview(plusButton)
        
        plusButton.setImage(#imageLiteral(resourceName: "icon_plus"), for: .normal)
        
        plusButton.imageView?.tintColor = UIColor(red: 237/255, green: 96/255, blue: 81/255, alpha: 1)
        
        plusButton.addTarget(self, action: #selector(addArticle), for: .touchUpInside)

       return headerView
    }
    
    @objc func addArticle() {
        storyboard?.instantiateViewController(withIdentifier: "EditViewController")
        present(EditViewController.self, animated: true) {
            print("yes~")
        }
        print("yes")
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleListTableViewCell", for: indexPath) as! ArticleListTableViewCell


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editViewController = EditViewController()
        present(editViewController, animated: true) {
            print("u")
        }
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
