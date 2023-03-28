//
//  AppsCompositionalView.swift
//  AppStoreJSONApis
//
//  Created by user on 27/03/2023.
//

import SwiftUI

enum SectionDirection {
    case vertical, horizontal
}

class SectionHeaderView: UICollectionReusableView {
    let label = UILabel(text: "Editor's Choice Games", font: .boldSystemFont(ofSize: 24))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CompositionalController: UICollectionViewController {
    
    private var headerApps = [AppHeaderApps]()
    private var topPaidApps: AppResult?
    private var topFreeApps: AppResult?
    
    init() {
        let layout = UICollectionViewCompositionalLayout { sectionNum, _ in
            if sectionNum == 0 {
                return CompositionalController.createSection(direction: .horizontal)
            } else {
                return CompositionalController.createSection(direction: .vertical)
            }
            
        }
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createSection(direction: SectionDirection) -> NSCollectionLayoutSection {
        
        var item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets.trailing = 12
        item.contentInsets.bottom = 16
        var group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.3)), subitems: [item])
        
        if direction == .vertical {
            item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)))
            item.contentInsets.trailing = 12
            item.contentInsets.bottom = 16
            group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.4)), subitems: [item])
        }
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets.leading = 12
        
        if direction == .vertical {
            section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
        }
        return section
    }
    
    private let sectionHeaderId = "sectionHeaderId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        navigationItem.title = "Apps"
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: "headerCell")
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderId)
        
        createDiffableDataSource()
//        fetchData()
    }
    
    enum AppSection {
        case topSocial
        case topPaid
        case topFree
    }
    
    lazy var diffableDataSource: UICollectionViewDiffableDataSource<AppSection, AnyHashable> = .init(collectionView: collectionView) { collectionView, indexPath, item in
        if let item = item as? AppHeaderApps{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCell", for: indexPath) as! AppsHeaderCell
            cell.companyLabel.text = item.name
            cell.titleLabel.text = item.tagline
            cell.titleImageView.sd_setImage(with: URL(string: item.imageUrl))
            return cell
        } else if let item = item as? FeedResults {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! AppRowCell
            cell.feedResult = item
            return cell
        }
        return nil
    }
 
    
    private func createDiffableDataSource() {
        
        collectionView.dataSource = diffableDataSource
        
        diffableDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            var title: String
            let snapshot = self.diffableDataSource.snapshot()
            guard let object = self.diffableDataSource.itemIdentifier(for: indexPath) else { return UICollectionViewCell() }
            let section = snapshot.sectionIdentifier(containingItem: object)
            if section == .topFree {
                title = "Top Free"
            } else {
                title = "Top Paid"
            }
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: self.sectionHeaderId, for: indexPath) as! SectionHeaderView
            header.label.text = title
            return header
        })
        
        
        
        Service.shared.fetchAppHeaderApps { appHeaderApps, err in
            self.checkErr(err: err)
            Service.shared.fetchTopPaid { topPaid, err in
                self.checkErr(err: err)
                Service.shared.fetchTopFree { topFree, err in
                    self.checkErr(err: err)
                    
                    var snapshot = self.diffableDataSource.snapshot()
                    snapshot.appendSections([.topSocial, .topPaid, .topFree])
                    snapshot.appendItems(appHeaderApps ?? [], toSection: .topSocial)
                    snapshot.appendItems(topPaid?.feed.results ?? [], toSection: .topPaid)
                    snapshot.appendItems(topFree?.feed.results ?? [], toSection: .topFree)
                    self.diffableDataSource.apply(snapshot)
                }
            }
            
            
            
        }
    }
    
}

struct AppsView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = CompositionalController()
        return UINavigationController(rootViewController: controller)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIViewController
    
}

struct AppsCompositionalView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView()
            .edgesIgnoringSafeArea(.all)
    }
}


extension CompositionalController {
    
    private func checkErr(err: Error?) {
        if let err = err {
            print("Failed to fetch header apps:", err)
            return
        }
    }
    
    private func fetchData() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        Service.shared.fetchAppHeaderApps { headerApps, err in
            dispatchGroup.leave()
            self.checkErr(err: err)
            self.headerApps = headerApps ?? []
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopPaid { appResult, err in
            dispatchGroup.leave()
            self.checkErr(err: err)
            self.topPaidApps = appResult
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopFree { appResult, err in
            dispatchGroup.leave()
            self.checkErr(err: err)
            self.topFreeApps = appResult
        }
        
        dispatchGroup.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
    
    //    override func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        0
    //    }
        
    //    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //        switch section {
    //        case 0:
    //            return headerApps.count
    //        case 1:
    //            return topPaidApps?.feed.results.count ?? 0
    //        case 2:
    //            return topFreeApps?.feed.results.count ?? 0
    //        default:
    //            return 0
    //        }
    //    }
        
    //    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //
    //        let apps = indexPath.section == 1 ? topPaidApps : topFreeApps
    //
    //        switch indexPath.section {
    //        case 0:
    //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCell", for: indexPath) as! AppsHeaderCell
    //            let app = headerApps[indexPath.item]
    //            cell.companyLabel.text = app.name
    //            cell.titleLabel.text = app.tagline
    //            cell.titleImageView.sd_setImage(with: URL(string: app.imageUrl))
    //            return cell
    //        default:
    //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! AppRowCell
    //            cell.feedResult = apps?.feed.results[indexPath.item]
    //            return cell
    //        }
    //    }
        
    //    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        switch indexPath.section {
    //        case 0:
    //            let app = headerApps[indexPath.item]
    //            let vc = AppDetailController(appId: app.id)
    //            navigationController?.pushViewController(vc, animated: true)
    //        default:
    //            let apps = indexPath.section == 1 ? topPaidApps : topFreeApps
    //            let id = apps?.feed.results[indexPath.item].id
    //            let vc = AppDetailController(appId: id ?? "")
    //            navigationController?.pushViewController(vc, animated: true)
    //        }
    //    }
    
    //        override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //
    //            let apps = indexPath.section == 1 ? topPaidApps : topFreeApps
    //
    //            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderId, for: indexPath) as! SectionHeaderView
    //            header.label.text = apps?.feed.title
    //            return header
    //        }
}
