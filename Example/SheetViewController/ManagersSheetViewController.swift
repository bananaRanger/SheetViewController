// MIT License
//
// Copyright (c) 2020 Anton Yereshchenko
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import SheetViewController

class ManagersSheetViewController: SheetViewController {
  //MARK: properties
  private let cancelAction = "Contact"

  private let headerHeight: CGFloat = 38
  private let contentHeight: CGFloat = 128

  private var color: UIColor?

  private var managers = [Manager]()
  
  private var headerView: ManagerHeaderView?
  private var contentView: ManagersListView?
  
  //MARK: methods
  static func `default`(with color: UIColor) -> Self {
    let sheet = Self.init(
      with: nil,
      message: nil,
      alignmentType: .bottom,
      actionType: .inner) { configuration in
        configuration.actionBackgroundColor = color
        return configuration
    }
    sheet.color = color
    return sheet
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    guard !managers.isEmpty else { return }
    selectManager(with: .zero)
  }
}

//MARK: - ManagersSheetViewController extension (setup)
extension ManagersSheetViewController {
  func setup() {
    managers = .mockItems
    
    guard let managerHeader = ManagerHeaderView.instanceFromNib() else { return }
    managerHeader.translatesAutoresizingMaskIntoConstraints = false
    managerHeader.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
    containerView?.content?.addHeaderView(managerHeader)
    managerHeader.setup(with: managers.first)

    headerView = managerHeader
    
    guard let managersListView = ManagersListView.instanceFromNib() else { return }
    managersListView.translatesAutoresizingMaskIntoConstraints = false
    managersListView.heightAnchor.constraint(equalToConstant: contentHeight).isActive = true
    managersListView.collectionView.dataSource = self
    managersListView.collectionView.delegate = self
    managersListView.collectionView.register(
      UINib(nibName: ManagerCollectionViewCell.className, bundle: nil),
      forCellWithReuseIdentifier: ManagerCollectionViewCell.identifier
    )
    addView(managersListView)
    contentView = managersListView
    
    setCancelButton(title: cancelAction, and: nil)
  }
  
  private func selectManager(with index: Int, animated: Bool = false) {
    contentView?.collectionView.selectItem(
      at: IndexPath(row: index, section: .zero),
      animated: animated,
      scrollPosition: .centeredHorizontally
    )
  }
}

//MARK: - UICollectionViewDataSource extension
extension ManagersSheetViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return managers.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ManagerCollectionViewCell.identifier, for: indexPath)
      as? ManagerCollectionViewCell else { return UICollectionViewCell() }
    cell.setup(with: managers[indexPath.row])
    return cell
  }
}

//MARK: - UICollectionViewDelegate extension
extension ManagersSheetViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    headerView?.setup(with: managers[indexPath.row])
  }
}
