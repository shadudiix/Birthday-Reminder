//
//  UITableView+Ext.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 10/12/2022.
//

import UIKit

extension UITableView {
    
    /// Register TableView Cell
    func registerNibCell(_ tableViewCell: UITableViewCell.Type) {
        let nibIdentifier = String(describing: tableViewCell)
        let baseNib = UINib.init(nibName: nibIdentifier, bundle: nil)
        self.register(baseNib, forCellReuseIdentifier: nibIdentifier)
    }
    
    /// Dequeue TableView Cell with type, no need for identifier
    func dequeueCell<RequiredTableViewCell: UITableViewCell>() -> RequiredTableViewCell {
        let cellIdentifer = String(describing: RequiredTableViewCell.self)
        guard let tableViewCell = self.dequeueReusableCell(withIdentifier: cellIdentifer) as? RequiredTableViewCell else {
            fatalError("Cannot dequeue cell with identifer \(cellIdentifer)")
        }
        return tableViewCell
    }
    
}
