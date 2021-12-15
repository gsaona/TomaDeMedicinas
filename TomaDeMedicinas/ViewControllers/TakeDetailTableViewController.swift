//
//  TakingDetailTableViewController.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 2/12/21.
//

import UIKit

class TakeDetailTableViewController: UITableViewController {

    private let takingDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    // Detail
    @IBOutlet var personTextField: UITextField!
    @IBOutlet var medicineNameTextField: UITextField!
    @IBOutlet var medicineDosisTextField: UITextField!
    @IBOutlet var medicineDosisUnitTextField: UITextField!
    @IBOutlet var takeDatePicker: UIDatePicker!
  
    // Pattern
    @IBOutlet var beginDatePicker: UIDatePicker!
    @IBOutlet var numberOfDaysTextField: UITextField!
    @IBOutlet var takingIntervalTextField: UITextField!
    
    var take: Take?
    
    init?(coder: NSCoder, take: Take?){
        self.take = take
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    var takes: [Take]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.addGestureRecognizer(settingTapGestureRecognizer())
        
        medicineDosisTextField.keyboardType = .decimalPad
        
        takeDatePicker.date = Calendar.current.startOfDay(for: Date())
            
        if let takeToModify = take {
            title = "Modificar Toma"
            personTextField.text = takeToModify.profile
            medicineNameTextField.text = takeToModify.medicationName
            medicineDosisTextField.text = String(takeToModify.quantity ?? 0)
            medicineDosisUnitTextField.text = takeToModify.unitOfQuantity
            takeDatePicker.date = takeToModify.dateTime ?? Date.now
            navigationItem.leftBarButtonItem = nil
        } else {
            title = "Añadir Toma"
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        }
    }
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func settingTapGestureRecognizer() -> UITapGestureRecognizer {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.numberOfTouchesRequired = 1
        tapGestureRecognizer.cancelsTouchesInView = false
        return tapGestureRecognizer
    }

    // MARK: - Table view data source
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var take = self.take ?? Database.shared.addTake()
        
        take.profile = personTextField.text!
        take.medicationName = medicineNameTextField.text ?? ""
        take.quantity = Double(medicineDosisTextField.text!) ?? 0
        take.unitOfQuantity = medicineDosisUnitTextField.text ?? ""
        take.dateTime = takeDatePicker.date
        
        Database.shared.updateAndSave(take)
    }
    
}
