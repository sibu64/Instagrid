import UIKit



class ViewController: UIViewController {
    // Gesture
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    // Parent container
    @IBOutlet weak var photoView: UIView!
    // Containers
    @IBOutlet weak var topLeftContainer: ContainerView?
    @IBOutlet weak var topRightContainer: ContainerView?
    @IBOutlet weak var bottomLeftContainer: ContainerView?
    @IBOutlet weak var bottomRightContainer: ContainerView?
    // Layout
    @IBOutlet weak var layout1: UIButton!
    @IBOutlet weak var layout2: UIButton!
    @IBOutlet weak var layout3: UIButton!
    // Collection IBOutlet
    @IBOutlet var photoButtons: [UIButton]?
    @IBOutlet var layoutButtons: [UIButton]!
    // Properties
    private var selectedContainer: ContainerView?
    private var selectedLayout: UIButton!
    private var photoCount = PhotoCount()
    private var imagePicker: ImagePicker!
    private var player = PlaySound()
    private var layout = Layout()
    private var shareImage = InstagridImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Controller passed as presentationController for the imagePicker so it'll be able to present the UIImagePickerController
        self.imagePicker = ImagePicker(presentationController: self, delegate: self as ImagePickerDelegate)
        
        layout3.isSelected = true
        //SelectedLayout = layout3
        layout.selectedLayout = layout.layoutTwo
        //Delegate
        shareImage.delegate = self
        
        //Delegate
        topLeftContainer?.delegate = self as ContainerViewDelegate
        topRightContainer?.delegate = self as ContainerViewDelegate
        bottomLeftContainer?.delegate = self as ContainerViewDelegate
        bottomRightContainer?.delegate = self as ContainerViewDelegate
    }
    // Notification that the view controller has its view added to a view hierarchy.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.changeSwipeGestureDirection()
    }
    //  Notification that the view controller has its view about to be added to a view hierarchy according the changing swipe's direction
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.changeSwipeGestureDirection()
    }
    // Handling of the device's orientation  to swipe left and up
    private func changeSwipeGestureDirection() {
        if UIDevice.current.orientation.isLandscape {
            swipeGesture.direction = .left
        }
        
        if UIDevice.current.orientation.isPortrait {
            swipeGesture.direction = .up
        }
    }
    // Selection to the right layout
    private func selectedLayoutForButton() ->Layout.LayoutGuideline {
        switch selectedLayout {
        case layout1: return layout.layoutOne
        case layout2: return layout.layoutTwo
        case layout3: return layout.layoutThree
        default: return layout.layoutThree
        }
    }
    
    // Actions(sound and setting up the right layout) when touching layout buttons
    @IBAction func touchLayoutsButtons(_ sender: UIButton) {
        player.playSound()
        selectedLayout = sender
        layout.selectedLayout = self.selectedLayoutForButton()
        
        resetLayoutButtons()
        
        //Setting up of the selected image on buttons
        sender.isSelected = true
        
        // Structuring of the layouts by handling visiblity of the containers
        switch sender {
        case layout1:
            topLeftContainer?.isHidden = true
            topRightContainer?.isHidden = false
            bottomLeftContainer?.isHidden = false
            bottomRightContainer?.isHidden = false
        case layout2:
            topLeftContainer?.isHidden = false
            topRightContainer?.isHidden = false
            bottomLeftContainer?.isHidden = true
            bottomRightContainer?.isHidden = false
        case layout3:
            topLeftContainer?.isHidden = false
            topRightContainer?.isHidden = false
            bottomLeftContainer?.isHidden = false
            bottomRightContainer?.isHidden = false
        default: break
        }
    }
    
    // Verifying that the containers' images are not empty to display a full graphic pasting
    private func isValidImageInLayout() ->Bool {
        switch selectedLayout {
        case layout1:
            if topRightContainer?.imageView?.image != nil && bottomLeftContainer?.imageView?.image != nil &&
                bottomRightContainer?.imageView?.image != nil {
                return true
            }
            return false
        case layout2:
            if topLeftContainer?.imageView?.image != nil && topRightContainer?.imageView?.image != nil &&
                bottomRightContainer?.imageView?.image != nil {
                return true
            }
            return false
        case layout3:
            if topLeftContainer?.imageView?.image != nil &&
            topRightContainer?.imageView?.image != nil &&
            bottomLeftContainer?.imageView?.image != nil &&
            bottomRightContainer?.imageView?.image != nil {
                return true
            }
            return false
        default: return false
        }
    }
    
    // Reseting layouts' buttons to render a perfect display
    private func resetLayoutButtons() {
        layoutButtons.forEach({
            $0.isSelected = false
        })
    }
    
   // Choosing the photo for each container
    private func choosePhoto(for container: ContainerView) {
        self.selectedContainer = container
        self.imagePicker.present()
    }
    
    // Reseting the photos of the buttons
    @IBAction func resetPhotoButtons(_ sender: UIButton) {
        if  sender.isSelected == true {
            photoButtons!.forEach({
                $0.isHidden = true
            })
        }
    }
    // Verifying of the validity of the images's number. If so, sharing, otherwise presenting alert
    @IBAction func actionSwipeToUpAndLeft(_ sender: UISwipeGestureRecognizer) {
        if photoCount.isValid(with: layout.selectedLayout) && self.isValidImageInLayout() {
            if let image = photoView.toImage {
                shareImage.share(with: image, controller: self)
            }
            return
        }
        self.presentAlert(message: "You must share more photos")
    }
}

   // Delegate
extension ViewController: ContainerViewDelegate {
    func didAction(container: ContainerView) {
        self.choosePhoto(for: container)
    }
}

  // Delegate
extension ViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.selectedContainer?.imageView?.image = image
        photoCount.add(image!)
    }
}

  // Delegate
extension ViewController: InstagridImageDelegate {
    func didSharedSuccess() {
        self.presentAlert(title: "Félicitation", message: "Votre photo à été partagé avec succès !")
    }
}
