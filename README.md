<div align="center">
   <h3 align="center">@Tractian Challenge 🧢</h3>
   A high-performance mobile application for industrial asset management, designed to organize and visualize large volumes of complex data in a hierarchical tree structure.
</div>

## Application Overview

Below you will find screenshots of the main screens of the application.

#### Application (v.17.11.2024)
![Aplicação](https://github.com/erickerate/Assets-Manager/blob/main/assets/app-overview-1.png)
![Aplicação](https://github.com/erickerate/Assets-Manager/blob/main/assets/app-overview-2.png)
![Aplicação](https://github.com/erickerate/Assets-Manager/blob/main/assets/app-overview-3.png)

## Tree Construction and Filtering Algorithms

### Tree Construction

To build the tree efficiently, a Map data structure based on key/value pairs was used, allowing a direct construction of the tree by associating each asset in the list with a specific node through an id -> TreeItem pair. Each item stores direct references to both its first-level children and its ancestors up to the root of the tree. This allows:

1. Quick access to any node in the structure, without the need for repeated iterations.
2. Facilitating direct access to the children and ancestors of each item.
3. Optimization of tree building and filtering operations.

Additionally, tree linearization has been incorporated to generate a linear list of items, respecting the hierarchy and expansion state of each node. This linearization has been implemented using a stack-based approach, and is necessary to build the ListView.Builder interface component, which displays items in hierarchical order and in an optimized manner. The list is dynamically recalculated to reflect changes in the expansion state of the nodes without reprocessing the entire tree.

This algorithm can be called **Hierarchical tree construction algorithm with hash-based direct mapping, path compression and linearization**, and is defined as follows:

1. **Initializing Nodes and Map**:
   - Create a map of items, where each key represents the item id and the value is the corresponding item (TreeItem).
   - For each asset in the list, instantiate a TreeItem and add it to the map, using the item's id as the key.
2. **Building the Tree Hierarchy**:
   - For each item:
      - If the item has a parent, locate it directly via the map and add the item to that parent's child collection.
      - Otherwise, add it to the tree's root collection.
3. **Consolidating the Ascendants**:
   - Walking from the root to the ends of the tree, set the ancestor collection of each item to the ancestor collection of the parent item, plus the item itself.
4. **Linearizing the Tree**:
   - Using a stack, add the root nodes to the initial stack.
   - As long as the stack is not empty:
      - Remove the next node from the stack and add it to the linear list of items.
      - If the node contains children, add them to the stack, ensuring the correct order.

### Asymptotic Complexity
- **Tree Construction**: Each map access operation (get or put) is performed in constant time 𝑂(1). With 𝑛 items to process, the overall complexity of building the tree is 𝑂(𝑛).
- **Consolidation of Ascendants**: Each node is processed only once, accessing and copying the parent's list of ancestors. Since the total cost of accessing and constructing all the ancestor lists is distributed among all nodes, the complexity of this step is also 𝑂(𝑛).
- **Tree Linearization**: The algorithm traverses each visible node once and performs constant-time operations to process the stack, resulting in a complexity of 𝑂(𝑛), where 𝑛 is the total number of nodes.

### Tree Filtering

To apply the filters, an approach was adopted that displays the items that meet the filter criteria, together with their ascending elements up to the root, so as to display the entire hierarchy of items. The filtering algorithm is implemented as follows:

1. **Setting items that meet the filters**: Apply filters to get only matching items. Set each item in this collection as visible.
2. **Making ancestors visible**: For each item that meets the filters, iterate through the collection of ancestors marking them as visible.

Since access to items and their ancestors is done directly, **the asymptotic complexity of this algorithm approaches 𝑂(𝑛)**.

### Filter processing with Isolates

To avoid crashes when applying filters to very large trees, Isolates was used so that the filtering operation is processed in a separate thread, freeing up the main UI and ensuring smooth navigation. Using this technique allows the app to maintain stable performance, even in scenarios where the number of assets is high.

### Virtualizing Asset Listing with ListView.builder

To avoid performance issues, especially with large asset lists, ListView.builder has been implemented at all levels of the tree to render the tree virtually. This component loads only the currently visible items, unlike a simple ListView, which renders all items at once. This approach increases the efficiency of the application by keeping memory usage and rendering time low, providing a more fluid navigation experience.

## Architecture

The application emphasizes separation of concerns, adhering to SOLID, Clean Architecture/Code, and Domain-Driven Design (DDD) principles.

1. **Presentation Layer**: Includes an application using MobX as a state management standard.
2. **Service Layer**: Consists of command handlers, models, results, and services.
3. **Domain Layer**: Includes entities, commands, validations, and repository abstractions.
4. **Data Layer**: Implements data access repositories.

## Projects

Assets Manager is comprised of four main projects, each playing a specific role in the system architecture:

- [**assets-manager-app**](https://github.com/erickerate/Assets-Manager/tree/main/src/application): A mobile app built with Flutter.
- [**assets-manager-domain**](https://github.com/erickerate/Assets-Manager/tree/main/src/domain): The domain package, covering abstractions for assets, locations, components, models, repository abstraction, and more.
- [**assets-manager-data**](https://github.com/erickerate/Assets-Manager/tree/main/src/data): O pacote para gerir acesso a dados, contendo implementações dos repositórios.
- [**assets-manager-service**](https://github.com/erickerate/Assets-Manager/tree/main/src/service): The service package, responsible for connecting business rules with the data layer.

## Future technical improvements

1. **Tree builder algorithm optimization**: Improve the asset tree construction algorithm to have low asymptotic complexity ✅
2. **Optimize filter processing**: Implement the use of isolate to filter assets ✅
3. **Virtualization rendering techniques***: Apply virtual rendering at all levels of the tree to improve efficiency and user experience ✅
4. **Testing and coverage strategies**: Implement unit, integration and test coverage tests. ⌛
5. **Handling unexpected exceptions**: Implement strategies to capture errors and unexpected exceptions, ensuring stability and providing appropriate responses to critical failures in the application ⌛
6. **Theme Customization**: Add support for light and dark theme selection, allowing users to switch between modes and improve the visual experience according to their preference or environment ⌛
7. **Internationalization and localization**: Configure support for multiple languages ​​and regional formats, allowing the application to adapt to users in different locations ⌛

## Future features

1. **Authentication and Access Control**: Implement user authentication and access control to limit which resources can be viewed or edited. This would be useful for environments with different hierarchical levels of security and control.
2. **Real-Time Notifications**: Implement a notification system to alert the user to critical changes in assets. This feature could be integrated via push notifications or WebSocket, ensuring that the user always receives the latest information, even when outside the application.
3. **Inspect Assets**: Enable viewing of assets in greater detail, making it possible to schedule automatic maintenance or generate inspection checklists. This ensures that the application not only assists in monitoring, but also facilitates preventive maintenance.
4. **Service Registration**: Enable the creation of services for an asset or group of assets. Each service can contain information such as the type of maintenance (preventive, corrective, predictive), date performed, photographic records, and others. Based on knowledge of the asset structure, the application would allow the selection of components or materials needed to perform the service. Each material can be associated with its respective ERP code, facilitating logistics planning and the requisition of parts from the inventory system. It is also possible to export a Service Report containing the items mentioned above. In this additional module, a history of services performed on the assets can be maintained, containing the materials used, execution time and professionals involved. This history can be used for predictive analysis, helping to identify failure patterns and improve the predictability of problems. In addition, knowing the list of materials and maintenance schedule of the assets, the application can automatically generate and schedule service orders, saving time and reducing the risk of errors and delays.
5. **Geospatial Mapping**: Incorporate a geospatial map that displays the location of each unit and its assets, allowing for quick navigation and providing a macro-level view.
   
## Getting Started
  
### Requisitos
* Dart SDK '>=3.4.0 <4.0.0'
* Flutter '3.22.0'

### Installation

1. Clone this repository
   ```sh
   gh repo clone erickerate/Assets-Manager
   ```

2. Open the workspace
   ```sh
   src/assets-manager
   ```
   
3. Run
   ```sh
   flutter pub get
   ```
   ```sh
   flutter run
   ```

## Demonstration
https://github.com/user-attachments/assets/dae2f135-b721-4010-ad4c-9b6a9cc35e65
