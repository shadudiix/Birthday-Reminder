//
//  BaseUITableView.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 09/12/2022.
//

import UIKit

@IBDesignable
class BaseUITableView: UITableView {
    
    // MARK: - Properties

    private var emptyMessageLabel: UILabel = {
        let baseLabel = UILabel()
        baseLabel.font = .preferredFont(forTextStyle: .headline)
        baseLabel.textAlignment = .center
        baseLabel.textColor = .secondaryLabel
        baseLabel.numberOfLines = 0
        baseLabel.isHidden = true
        baseLabel.backgroundColor = .systemGroupedBackground
        return baseLabel
    }()
    
    @IBInspectable var emtpyMessageText: String! {
        didSet {
            self.emptyMessageLabel.text = emtpyMessageText
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupTableView()
    }
    
    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }

    // MARK: - View overrided delegates
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.endEditing(true)
    }
    
    // MARK: - Functions
    
    private func setupTableView() {
        self.backgroundView = self.emptyMessageLabel
    }
    
    func showEmptyMessageLabel() {
        if(self.emptyMessageLabel.isHidden == true) {
            self.emptyMessageLabel.isHidden.toggle()
        }
    }
    
    func hideEmptyMessageLabel() {
        if(self.emptyMessageLabel.isHidden == false) {
            self.emptyMessageLabel.isHidden.toggle()
        }
    }

}
