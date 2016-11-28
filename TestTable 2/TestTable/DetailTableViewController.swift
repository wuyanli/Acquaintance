//
//  DetailTableViewController.swift
//  TestTable
//
//  Created by 吴艳丽 on 2016/11/24.
//  Copyright © 2016年 吴艳丽. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
var person: PersonMO?
    //    NSLayoutConstraint!
   
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        nameTextField.text = person?.name
        if let photoData = person?.photo {
            photoImageView.image = UIImage(data: photoData as Data)
        } else {
            photoImageView.image = UIImage(named:"photoalbum")
        }
        notesTextField.text = person?.notes
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        if nameTextField.text == nil || nameTextField.text!.isEmpty {
            let alertController = UIAlertController(title: "Invalid Data", message: "The name cannot be empty", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "SaveToList", sender: self)
        }
    }
    @IBAction func cancelAdd(_ sender: UIBarButtonItem) {
        if presentingViewController is UINavigationController{
            dismiss(animated: true, completion: nil)
        }else{
            navigationController!.popViewController(animated: (animated:true))
        }
    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//        if segue.identifier == "SaveToList" {
//            if person == nil {
//                person = Person(nameTextField.text!)
//            } else {
//                person?.name = nameTextField.text!
//            }
//            person!.photo = photoImageView.image
//            person!.notes = notesTextField.text
//        }

        if segue.identifier == "SaveToList", let appDelegate = (UIApplication.shared.delegate as?
            AppDelegate) {
            let name = nameTextField.text!
            let photo = photoImageView.image
            let notes = notesTextField.text
            if person == nil { // add a new entry
                person = appDelegate.addToContext(name: name, photo: photo, notes: notes)
            } else { // update an existing entry
                appDelegate.updateToContext(person: person!, name: name, photo: photo, notes: notes)
            }
        
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if indexPath.section == 1,
            UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage { photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil) }
}
