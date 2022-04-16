
# Beyond List
Productivity app based on pruning and the Eisenhower box methodology for prioritization

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Minimalistic productivity app that allows users to choose the most important of there tasks, and maintain it through "Task Pruning".

### App Evaluation
**Category**: Social Networking

**Mobile**: Mobile is the best form for this app due to constant movement of individuals, and task ideas coming in at random spots. Functionality wouldn't be limited to mobile devices.

**Story**: A zen like list system that relaxes the user, and helps the user ultra focus on their tasks to achieve a positive change.

**Market**: Any individual who has a goal in mind, and wants a simple list

**Habit**: We can add animations, and badges to reward constant logins, and goal achievements. We can also add reward points that can change the animations of achieving goals. We lastly add a social aspect later on such as friends.

**Scope**: V1 would just be a simple pruning task list that can be given to friends to try out themselves. 
V2 With these tests, we would refine the list and give it to a wider market, such as productivity feeds or groups. We would add the habit-forming features in this version. 
V3 we would finally upload it to the market, and have it as a real product.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Welcome screen-->What is Task Pruning Screen in progress
* User login/Sign up (in progress)
* Create a Task (in progress)
* User logout / switch account (in progress)
* Delete a Task
* Search for a task
* Prune Tasks
* Move Task from Task Dump to Today or Tomorrow's list & vice-versa
* Use the Eisenhower box format to rank tasks automatically for a user. Basically give each task an importance and urgency score.

**Optional Nice-to-have Stories**

* Due date's for tasks overriding any Eisenhower priority
* Sync tasks across iCloud
* Users can be awarded a badge for each task done.
* Users can add friends
* Users can invite friends or join badge ranking races.
* Settings (in progress)
* User can load picture in profile (in progress)
* User can edit a caption in profile(in progress)
### 2. Screen Archetypes
* Welcome Screen
   * Animation showing how task pruning works
* Login Screen
  * login by using username and password
  *  click 'submit' butto to sign up an account after typing in user name and password
  * stay login
* Today Tab
   * Create a task
   * Display Today's Tasks
   * Ability to delete Tasks inline
   * Ability to check off Tasks as finished
   * Task Dump Top Tasks Preview
   * Edit Task Priority 
   * Move Task from Task Dump to Today
* Tomorrow Tab
   * Create a task
   * Display Tasks
   * Ability to delete Tasks inline
* Task Dump Tab
   *  Create a task
   * Display all tasks based on priority
   * Edit priority of Tasks
   * Move Task from Task Dump to Today or Tomorrow's list
 * Create a Task Screen
   * Add a name
   * Set Eisenhower priorities   
   * Set a due date (optional)
 * Profile Screen(optional)
   * Add photo
   * Profile
   * Badges(Can be Shared)/Friends(Can be added friends)/Ranking(Can be shared)
 * Setting Screen(optional)
   * Account setting
   * Language changed
   * Privacy
   * Switch account
   * Logout
### 3. Navigation

**Tab Navigation** (Tab to Screen)
* Today Tab
* Tomorrow Tab
* Task Dump
* Profile (Optional)
* Setting (Optional)

**Flow Navigation** (Screen to Screen)

* Welcome Screen --> login screen
* Login Screen --> Today Tab --> Create-a-Task screen
* Login Screen --> Tomorrow Tab --> Create-a-Task screen
* Login Screen --> Dump Tab --> Create-a-Task screen
* Login Screen --> Profile Tab --> Profile edit
* Login Screen --> Setting Tab --> Login screen

## Wireframes
<img src="https://raw.githubusercontent.com/mata-m/mata-m_public/main/Beyond.png" width=600>

![image](https://user-images.githubusercontent.com/93957786/161389820-c7702c7d-fc25-4cd3-8eaa-8c393be5e769.png)

### [BONUS] Digital Wireframes & Mockups

<img width="721" alt="mockupshots" src="https://user-images.githubusercontent.com/93957786/162555758-beb46c64-6ff6-4782-9907-2e73735cb0ee.png">





https://www.figma.com/file/sHubGPDgs3uiNYQueYGwMX/Beyond-Demo-(Copy)?node-id=193%3A3

### [BONUS] Interactive Prototype

https://recordit.co/tlNEhmMDG6.gif


https://www.figma.com/proto/sHubGPDgs3uiNYQueYGwMX/Beyond-Demo-(Copy)?node-id=201%3A1034&starting-point-node-id=201%3A1034

## Schema 
[This section will be completed in Unit 9]
### Models
Tasks
| Objects  | Type | Description|
| ------------- | ------------- |------------- |
| Description  | Text| describe task |
| Title | String  | Title of tasks |
| Priority | Enum  | Non-Important,Important |
| Urgency  | Enum | Non-Urgent, Urgent |
| Date Made| Date | date task was made|
|Date of Completion| Date| when will this Task need to be completed|
| UserID  | Pointer to User (Foreign Key)| Connects to Profiles Table|
  -------------  -------------  -------------
  
Profiles
| Objects  | Type | Description|
| ------------- | ------------- |------------- |
| UserID | Unique String (Primary Key) | Username and loginID|
| Password | String | Password to Login |
| Image        |  Image            |  Optional Profile Image          |
  -------------  -------------  -------------
  
Tommorow Tasks
| Objects  | Type | Description|
| ------------- | ------------- |------------- |
| Task ID | Tasks  | Tasks that will be scheduled next morning Limited to 3 |
  -------------  -------------  -------------
  
Todays Tasks
| Objects  | Type | Description|
| ------------- | ------------- |------------- |
| Task ID  | Tasks | Tasks that are due today belong to this list Limited to 3 |
  -------------  -------------  -------------

Task Dump
| Objects  | Type | Description|
| ------------- | ------------- |------------- |
| Task ID | Tasks  | Tasks that dont have a due date belong in this list|
  -------------  -------------  -------------

Settings will be saved in User Defaults on the Local APP

| Objects  | Type | Description|
| ------------- | ------------- |------------- |
| Language | String |  String to choose which language app will display |
| Enable Notifications | Boolean | Boolean to decide if alerts are permissable |

Log out will just be a function on the local APP
## Networking
### List of Network Request by Screen
* Login Screen
  
(Read/GET) 
   
* Today Tab
  *(Create) Create a new Task
  *(Read/GET) Read all tasks and list them on Page
  *(Update)  Update a Task
  *(Delete) Delete a Task
  

   
* Tomorrow Tab
  * (Create) Create a new Task
  * (Read/GET) Read all tasks and list them on Page
  * (Update)  Update a Task
  * (Delete) Delete a Task

* Task Dump
  * (Create) Create a new Task
  * (Read/GET) Read all tasks and list them on Page
  * (Update)  Update a Task
  * (Delete) Delete a Task

      

* Profile (Optional)
  * (Read/GET) Read Profile information such as images
  * (Update) Update profile
* Setting (Optional)
   * (Read/GET) Read Settings
   * (Update) Update Settings
   * Delete user's account

  
  
 * Existing API Endpoints
  ** Base URL - https://parseapi.back4app.com
  ** Base URL - https://github.com/Alamofire/AlamofireImage
# Build Progress 1 
<img src='https://recordit.co/tlNEhmMDG6.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
Required Must-have Stories

# Completed User stories
  * ~~login/Sign up (Completed)~~
  * Logout(completed)
  * Read Profile information(completed)
  * Load image and caption(completed
  * Create a Task (in-Progress)
  * Delete a Task (in-Progress)
  * Search for a task (in-Progress)
  * Prune Tasks
  * Move Task from Task Dump to Today or Tomorrow's list & vice-versa
  * Use the Eisenhower box format to rank tasks automatically for a user. Basically give each task an importance and
   Urgency.
