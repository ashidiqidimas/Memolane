import SwiftUI

struct HomeScreenView: View {
    @ObservedObject var vm = HomeScreenViewModel()
    @State var columnVisibility = NavigationSplitViewVisibility.doubleColumn
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            GeometryReader { geo in
                ZStack {
                    List {
                        ForEach(vm.memoryItems, id: \.self) { item in
                            MemoryCard(memoryItem: item, selectedIndex: Binding(projectedValue: $vm.selectedIndex), memoryItems: $vm.memoryItems)
                        }
                    }
                    .environment(\.defaultMinListRowHeight, 116)
                    //                    .listStyle(.plain)
                    .listRowBackground(Color.clear)
                    .background(Color.backgroundSecondary)
                    
                    Button {
                        print("add memory item added")
                        vm.addMemoryItem()
                        
                    } label: {
                        VStack {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .tint(.white)
                                .background {
                                    Circle()
                                        .fill(Color.primaryColor)
                                        .frame(width: 52, height: 52)
                                }
                        }
                        .frame(width: 52, height: 52)
                    }
                    .position(x: geo.size.width - 42, y: geo.size.height - 32)
                }
            }
            .navigationTitle("Memolane")
            .navigationBarTitleDisplayMode(.large)
            .navigationSplitViewColumnWidth(400)
            .toolbar {
                NavigationLink {
                    MuseumView(memoryItems: vm.memoryItems, columnVisibility: $columnVisibility)
                } label: {
                    Text("See in AR")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.white)
                        .padding(
                            EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
                        )
                        .background(Color.primaryColor)
                        .cornerRadius(100)
                }
                .simultaneousGesture(TapGesture().onEnded{
                    columnVisibility = NavigationSplitViewVisibility.detailOnly
                })
            }
        } detail: {
            //            if $vm.selectedMemoryItem != nil {
            //                MemoryView(selectedMemoryItem: Binding(vm.memoryItems[vm.selectedIndex!]))
            //                .frame(maxHeight: .infinity, alignment: .topLeading)
            //                .padding(.horizontal, 16)
            //                .navigationTitle(selectedMemoryItem.title)
            //                .navigationBarTitleDisplayMode(.large)
            
            if vm.selectedIndex != nil {
                MemoryView(memoryItems: $vm.memoryItems, selectedIndex: Binding($vm.selectedIndex)!)
            } else {
                Text("Choose a memory on the left or create new memory")
            }
        }
        .navigationSplitViewStyle(.balanced)
        .preferredColorScheme(.light)
    }
    
    
}
