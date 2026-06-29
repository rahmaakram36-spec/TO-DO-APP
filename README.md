# FLUTTER TO-DO APP (BLOC / CUBIT)

## OVERVIEW

This project is a clean and scalable **To-Do List application** developed using Flutter, utilizing **Cubit (from Flutter Bloc)** for efficient and predictable state management.

The application enables users to:

* Add new tasks
* Mark tasks as completed
* Delete tasks
* Track pending and completed tasks in real time

---

## ARCHITECTURE

The project follows a structured separation of concerns into three main layers:

### 1. PRESENTATION LAYER (UI)

Responsible for rendering the user interface and reacting to state changes.

Key components:

* `TaskScreen` → Main screen layout
* `Cards` → Displays task statistics (pending & completed)
* `TaskContainer` → Displays task list

Uses:

* `BlocBuilder` to listen to state updates and rebuild UI accordingly

---

### 2. BUSINESS LOGIC LAYER (CUBIT)

Located in: business logic/cubit/tasks_cubit.dart

Handles all application logic, including:

* Adding tasks → `addTask(String title)`
* Deleting tasks → `deleteTask(int index)`
* Updating task status → `toggleTask(int index)`

State is managed using:

* `emit()` to output updated task lists

---

### 3. DATA LAYER

Located in: data/model.dart

Defines the core data structure:

**Task Model:**

* `title` (String) → Task description
* `isDone` (bool) → Completion status

---

## STATE MANAGEMENT

This application uses **Cubit** for lightweight and efficient state management.

Core concepts:

* `BlocBuilder` → Listens and rebuilds UI on state changes
* `context.read<TasksCubit>()` → Executes actions
* State structure → `List<Task>`

Workflow:

1. User performs an action (add / delete / toggle)
2. Cubit updates state using `emit()`
3. UI rebuilds automatically

---

## CORE FEATURES

### ADD TASK

* Input is captured using `TextEditingController`
* Task is added via:

```dart
addTask(controller.text);
```

---

### TOGGLE TASK STATUS

* Checkbox updates task completion state
* Triggered via:

```dart
toggleTask(index);
```

---

### DELETE TASK

* Removes task based on its index:

```dart
deleteTask(index);
```

---

### TASK STATISTICS

* Pending tasks:

```dart
tasks.where((t) => !t.isDone).length;
```

* Completed tasks:

```dart
tasks.where((t) => t.isDone).length;
```

---

## USER INTERFACE BEHAVIOR

* Completed tasks:

  * Displayed in grey
  * Strikethrough text applied

* Pending tasks:

  * Displayed in standard black text

* Empty state:

  * Shows a placeholder message: *"No tasks yet"*

* UI Enhancements:

  * `AnimatedContainer` for smooth transitions
  * `BoxShadow` for depth and modern styling
  * Filled `TextField` for improved usability

---

## 🛠️ TECHNOLOGIES USED

* Flutter
* Dart
* Flutter Bloc (Cubit)
