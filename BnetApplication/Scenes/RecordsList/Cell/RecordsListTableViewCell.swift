//
//  RecordsListTableViewCell.swift
//  BnetApplication
//
//  Created by Артем Григорян on 12/08/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol RecordsListCellViewModel {
    var body: String { get }
    var da: Date { get }
    var dm: Date { get }
}

class RecordsListTableViewCell: UITableViewCell {
    @IBOutlet private weak var daLabel: UILabel!
    @IBOutlet private weak var dmLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var dateOfModificationTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Так как изначально дата создания совпадает с датой модификации, то дата модификации показана не будет.
        dateOfModificationTextLabel.isHidden = true
        // Скрываем как текст "Дата модификации" так и само значение даты модификации.
        dmLabel.isHidden = true
    }

    func configureCell(viewModel: RecordsListCellViewModel) {
        // Заполним лейбл с текстом, который пользователь ввёл на экране CreateRecord.
        bodyLabel.text = viewModel.body
        // Заполним лейбл с датой создания вышеупомянутого текста.
        daLabel.text = getStringFromDate(date: viewModel.da)
        // Если дата создания не совпадает с датой модификации, то
        if viewModel.da != viewModel.dm {
            // покажем лейбл с датой модификации,
            dmLabel.isHidden = false
            // покажем лейбл "Дата модификации",
            dateOfModificationTextLabel.isHidden = false
            // установим значение в лейбл с датой модификации.
            dmLabel.text = getStringFromDate(date: viewModel.dm)
        }
    }
    
    private func getStringFromDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        formatter.timeZone = TimeZone.current
        
        let stringFromDate = formatter.string(from: date)
        
        return stringFromDate
    }
}
