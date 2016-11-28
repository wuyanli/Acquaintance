//
//  TvTableViewController.swift
//  TestTable
//
//  Created by 吴艳丽 on 2016/11/23.
//  Copyright © 2016年 吴艳丽. All rights reserved.
//

import UIKit
//import Person

class TvTableViewController: UITableViewController {
//    let acqList = ["ts","wwb","lty"]
    var acqNames = ["Ameir Al-Zoubi", "Bill Dudney", "Bob McCune", "Brent Simmons", "Cesare Rocchi", "Chad Sellers", "Conrad Stoll", "Daniel Pasco", "Jaimee Newberry", "James Dempsey", "Josh Abernathy", "Justin Miller", "Ken Auer", "Kevin Harwood", "Kyle Richter", "Manton Reece", "Marcus Zarra", "Mark Pospesel", "Matt Drance", "Michael Simmons", "Michele Titolo", "Michael Simmons", "Rene Cacheaux", "Rob Napier", "Scott McAlister", "Sean McMains"]
    
    //var acqList = [Person("Ameir Al-Zoubi"), Person("Bill Dudney"), Person("Bob McCune"), Person("Brent Simmons"), Person("Cesare Rocchi"), Person("Chad Sellers"), Person("Conrad Stoll"), Person("Daniel Pasco"), Person("Jaimee Newberry"), Person("James Dempsey"), Person("Josh Abernathy"), Person("Justin Miller"), Person("Ken Auer"), Person("Kevin Harwood"), Person("Kyle Richter"), Person("Manton Reece"), Person("Marcus Zarra"), Person("Mark Pospesel"), Person("Matt Drance"), Person("Michael Simmons"), Person("Michele Titolo"), Person("Michael Simmons"), Person("Rene Cacheaux"), Person("Rob Napier"), Person("Scott McAlister"), Person("Sean McMains")]

    var acqList = [PersonMO]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            if !FileManager().fileExists(atPath:PersonMO.StoreURL.path) {
            for name in acqNames {
                let person = appDelegate.addToContext(name: name, photo: UIImage(named: name),            notes: nil)
                acqList.append(person) }
        } else {
            if let fetchedList = appDelegate.fetchContext() {
                acqList += fetchedList }
            } }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    /*    for person in acqList{
            if let name = person?.name{ //if let把option检查一下，如果不为空。。。
                person?.photo = UIImage(named:name)
                person?.notes = "this is the memo for" + name
            }
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

  /*  override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    //统计有多少行
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return acqList.count
    }

    
    //用行号检索
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "tvCell", for: indexPath)

        // Configure the cell...
//        cell.textLabel?.text = acqList[indexPath.row]
//        cell.imageView?.image = UIImage(named:acqList[indexPath.row])
//        cell.detailTextLabel?.text = "this is a memo for " + acqList[indexPath.row]
        
//        cell.textLabel?.text = acqList[indexPath.row]?.name
//        cell.imageView?.image = acqList[indexPath.row]?.photo
//        cell.detailTextLabel?.text = acqList[indexPath.row]?.notes
        let cell = tableView.dequeueReusableCell(withIdentifier: "tvCell", for: indexPath) as!
        ListTableViewCell
        let person = acqList[indexPath.row]
        // Configure the cell...
        if let photoData = person.photo {
        cell.photoImageView.image = UIImage(data: photoData as Data) } else {
        cell.photoImageView.image = UIImage(named:"photoalbum") }
        cell.nameLabel.text = person.name
        cell.notesLabel.text = person.notes
        return cell

    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let person = acqList[indexPath.row]
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                appDelegate.deleteFromContext(person: person)
                acqList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade) }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         //Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetail", let destVC = segue.destination as? DetailTableViewController,
            let indexPath = tableView.indexPathForSelectedRow{
            let person = acqList[indexPath.row]
            destVC.person = person
        }
    }
 
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    @IBAction func unwindToList(segue:UIStoryboardSegue) {
        if segue.identifier == "SaveToList",
            let detailViewController = segue.source as? DetailTableViewController, let person = detailViewController.person {
            if let selectedIndexPath = tableView.indexPathForSelectedRow { // Update an existing person.
                acqList[(selectedIndexPath as NSIndexPath).row] = person
                tableView.reloadRows(at: [selectedIndexPath], with: .none) } else {
                // Add a new person.
                let newIndexPath = IndexPath(row: acqList.count, section: 0)
                acqList.append(person)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
        }
    }
    
}
