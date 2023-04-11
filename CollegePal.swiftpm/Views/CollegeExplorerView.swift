import SwiftUI

struct CollegeExplorerView: View {
    
    @ObservedObject var viewModel: CollegeExplorerVM = CollegeExplorerVM()
    
    @State private var searchText = ""
    
    @State private var displayStyle = CollegeExplorerViewOptions.Grid
    
    var body: some View {
        
        VStack {
            
            Picker("Display Style", selection: $displayStyle) {
                Text("Grid").tag(CollegeExplorerViewOptions.Grid)
                    .padding()
                Text("List").tag(CollegeExplorerViewOptions.List)
                    .padding()
            }
            .pickerStyle(.segmented)
            
            
            if displayStyle == .Grid {
                
                CollegeExploreGridView(colleges: filteredColleges)
                
            } else if displayStyle == .List {
                List(filteredColleges, id: \.name) { college in
                    Text(college.name)
                }
            }
            
        }
        .searchable(text: $searchText)
        .navigationTitle("Explore")
        .padding()
        
        var filteredColleges: [CollegeStruct] {
            if searchText.isEmpty {
                return viewModel.colleges
            } else {
                return viewModel.colleges.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
    }
}
