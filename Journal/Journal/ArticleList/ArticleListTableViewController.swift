//
//  ArticleListTableViewController.swift
//  Journal
//
//  Created by cindy on 2017/12/8.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//
import Foundation
import UIKit
import CoreData

protocol ArticleCellDelegate : class {
    
    func manager(_ manager: ArticleListTableViewController,didGet article: NSManagedObject)
    
}

class ArticleListTableViewController: UITableViewController{
    
    weak var delegate: ArticleCellDelegate?
    
    var articles: [NSManagedObject] = []
    
    let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Article")
        do {
            
            let sortByDate = NSSortDescriptor.init(key: "timestamp", ascending: false)
            
            fetchRequest.sortDescriptors = [sortByDate]
            
            articles = try managedContext.fetch(fetchRequest)
        
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
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
        
        let headerView = UIView.load(
            
            nibName:"ArticleHeaderView",
            
            bundle: nil
            
        ) as! ArticleHeaderView
        
        headerView.plusButton.addTarget(
            self,
            action: #selector(addArticle),
            for: .touchUpInside
        )
        
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
        
        cell.articleImageView.clipsToBounds = true
        
        cell.articleImageView.layer.cornerRadius = 10

        
        let article = articles[indexPath.row]
        
        cell.articleTitle.text = article.value(forKeyPath: "title") as? String

        
        guard
            let imageData = article.value(forKeyPath: "image") as? Data
            
        else { return cell }
            
        cell.articleImageView.image = UIImage(data: imageData)
        
        cell.articleImageView.contentMode = .scaleAspectFill
    


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let updateViewController = UITableViewController.loadViewController(
            
            UpdateViewController.self,
            
            from: .update
        )
        
        self.delegate?.manager(self, didGet: articles[indexPath.row])
        
        present(updateViewController, animated: true, completion: nil)
        
    }
 
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let article = articles[indexPath.row]
            
            managedObjectContext?.delete(article)
            
            do {
                try managedObjectContext?.save()
            }
            catch
                let error as NSError {
                print("Error While Deleting Note: \(error.userInfo)")
            }
            
            articles.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }

    
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

extension Date {
    /**
     Formats a Date
     
     - parameters format: (String) for eg dd-MM-yyyy hh-mm-ss
     */
    func format(format:String = "dd-MM-yyyy hh-mm-ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        if let newDate = dateFormatter.date(from: dateString) {
            return newDate
        } else {
            return self
        }
    }
}
