import UIKit
import FirebaseDatabase
import MapKit
//import MessageKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var msgTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var ref: DatabaseReference! = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref.observe(.childAdded, with: { snapshot in
              let postDict = snapshot.value as? [String : AnyObject] ?? [:]
//                print(postDict)
            if let name = postDict["name"] as? String, let message = postDict["message"] as? String {
                let text = self.textView.text
                let add = name + ":" + message
                self.textView.text = (text ?? "") + "\n" + add
            }
        })
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
        if let userName = nameTextField.text, let message = msgTextField.text {
                let messageData = ["name": userName, "message": message]
                ref.childByAutoId().setValue(messageData)
            nameTextField.text = ""
            msgTextField.text = ""
            }
        }
    }
    

