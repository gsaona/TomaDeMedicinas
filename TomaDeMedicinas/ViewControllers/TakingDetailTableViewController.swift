//
//  TakingDetailTableViewController.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 2/12/21.
//

import UIKit

class TakingDetailTableViewController: UITableViewController {

    private let datePickerHeight = CGFloat(216)
    
    private let takingDateLabelCellIndexPath = IndexPath(row: 3, section: 0)
    private let takingDatePickerCellIndexPath = IndexPath(row: 4, section: 0)

    private let takingDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    @IBOutlet var personTextField: UITextField!
    @IBOutlet var medicineNameTextField: UITextField!
    @IBOutlet var medicineDosisTextField: UITextField!
    @IBOutlet var medicineDosisUnitTextField: UITextField!
    @IBOutlet var takingDateLabel: UILabel!
    @IBOutlet var takingDatePicker: UIDatePicker!
    
    var isTakingDatePickerShown: Bool = false {
        didSet {
            takingDatePicker.isHidden = !isTakingDatePickerShown
        }
    }
    
    var taking: Taking?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.addGestureRecognizer(settingTapGestureRecognizer())
        
        medicineDosisTextField.keyboardType = .decimalPad
        
        takingDatePicker.date = Calendar.current.startOfDay(for: Date())
        
        updateTakingDatePickerUI()
        
        if let taking = taking {
            title = "Modificar Toma"
            personTextField.text = taking.profile
            medicineNameTextField.text = taking.medicationName
            medicineDosisTextField.text = String(taking.quantity!)
            medicineDosisUnitTextField.text = taking.unitOfQuantity
            takingDatePicker.date = taking.date!
            updateTakingDatePickerUI()
            navigationItem.leftBarButtonItem = nil
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        }
        
    }
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func updateTakingDatePickerUI() {
        takingDateLabel.text = takingDateFormatter.string(from: takingDatePicker.date)
    }
    
    func settingTapGestureRecognizer() -> UITapGestureRecognizer {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.numberOfTouchesRequired = 1
        tapGestureRecognizer.cancelsTouchesInView = false
        return tapGestureRecognizer
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == takingDateLabelCellIndexPath.section &&
           indexPath.row == takingDateLabelCellIndexPath.row {
            updateTakingDatePickerUI()
            isTakingDatePickerShown.toggle()
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath {
        case takingDatePickerCellIndexPath where isTakingDatePickerShown == false:
            return 0.01
        case takingDatePickerCellIndexPath where isTakingDatePickerShown == true:
            return datePickerHeight
        default:
            return 44
        }
    }
    
    @IBAction func takingDatePickerValueChanged(_ sender: UIDatePicker) {
        updateTakingDatePickerUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var taking = self.taking ?? Database.shared.addTaking()
        
        taking.profile = personTextField.text!
        taking.medicationName = medicineNameTextField.text ?? ""
        taking.quantity = Double(medicineDosisTextField.text!) ?? 0
        taking.unitOfQuantity = medicineDosisUnitTextField.text ?? ""
        taking.date = takingDatePicker.date
        
        Database.shared.updateAndSave(taking)
    }
    
}
