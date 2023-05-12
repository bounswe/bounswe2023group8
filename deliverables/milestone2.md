
<h1 align="center">Milestone 2 Report</h2>

<h2 align="center">CMPE352 - Introduction to Software Engineering<h3> 
<h3 align="center">Group 8 - Web Info Aggregator<h4>

# 1. Executive Summary
 ## 1.1. Introduction/Project Description
Our goal is to provide a collaborative platform for users to identify, gather, and utilize information from resources across the web, which are often distributed across multiple websites and presented in different forms. By using this platform, we aim to enable users to contribute meta-information (e.g., fact, out of date) about the information they gather, and to help them search, group, and process the data in interesting and useful ways. Essentially, we want people to come together to gather relevant information and add to it, and our system will facilitate this collaborative effort by providing various features to enhance the user experience.

In this milestone, our team collaborated on the development of a web application that incorporated various APIs. Our primary focus was to gain hands-on experience in team development practices, utilizing GitHub as our central platform. Each team member contributed by selecting and integrating at least one API of their choice while also creating an API function. Through close collaboration and leveraging our project repository, we successfully built the web application and API, featuring a user-friendly interface that promotes effective collaboration. Our meticulous planning, effective communication, and mutual support were key factors in achieving our shared objectives.
 ## 1.2. Project Status
We have been working on our Web Info Aggregator in stages since the beginning of the semester. We started by identifying the requirements and classifying them. When we had doubts about the requirements, we contacted our teacher and teaching assistant for clarification. Following that, we produced mockups and scenarios to demonstrate the basic user-system interactions in our app. We created class-user-sequence diagrams to help us create a thorough implementation strategy. We created communication plan, project plans and a Resource Allocation Matrix (RAM) to track our progress. All of these projects are detailed in our Milestone 1 Report.

Considering the significant amount of pull requests, issues, and merges, becoming proficient in Git and GitHub was a crucial aspect of our project implementation. We familiarized ourselves with Git as a team, as many of us were new to its usage. Furthermore, each team member conducted research on APIs and selected frameworks. We held meetings to determine the most suitable tools for our application and ultimately settled on the React and Java Spring frameworks. We decided as a team on the IDE we will use, and we thought that Intellij would be the most comfortable to use. Individually, each team member identified a preferred public, external API. Commencing with the backend, every team member identified and developed their own set of required endpoints. Also, members completed unit tests for their endpoints. To ensure the proper functioning of our APIs, we carried out extensive testing, including manual tests utilizing Postman. As a team, we dockerize our projects locally. We also collectively checked each other's work by helping each other as a team.

 ## 1.3. Functionalities of Our Project
 
  ### 1.3.1. Fragments of the Project


Fragment | Owner | Description
-- | -- |  -- 
 1.Dictionary | [Begüm Yivli](/bounswe/bounswe2023group8/wiki/Begüm-Yivli-About) | Thanks to the API I've implemented, users can view different meanings and types when they search for words. They can also add the words they want to favorites and view the words they have added to the favourites. Our application connects with this API and offers the ability to add and display favorite words as a new feature.
 2.Number Fact | [Sude Konyalıoğlu](/bounswe/bounswe2023group8/wiki/Sude-Konyalıoğlu-About) | Our project aims to present a new way to aggregate information. But learning doesn't have to be a boring process. This functionality presents a fun way to learn about numbers. The user can search for various fun facts about numbers and see the most searched number.
 3.Wikidata | [Hasan Baki Küçükçakıroğlu](https://github.com/bounswe/bounswe2023group8/wiki/Hasan-Baki-K%C3%BC%C3%A7%C3%BCk%C3%A7ak%C4%B1ro%C4%9Flu-About) | This functionality allow user reach to Wikidata information. User can search for an entity either via name or id, easily see the properties of an entity vie clean user interface, recursively search for entities which are property values of another, and save the entity to bookmarks to later looks.
 4.Stocks | [Bahadır Gezer](https://github.com/bounswe/bounswe2023group8/wiki/Bahadır-Gezer-About) | This feature allows you to gather information about stocks available world-wide. You can search stocks and select the one you want from the dropdown autocomplete menu. The most recent price and volume info is displayed, which can also be updated. 
 5.Movies | [Ömer Faruk Çelik](https://github.com/bounswe/bounswe2023group8/wiki/Ömer-Faruk-Çelik-About) | With this feature, users can easily access the most popular movies of the day. As you browse through the pages, you can view the poster, title, rating, and release date for each movie. This makes it easy to discover new films and keep up with the latest releases.
 6.Weather | [Meriç Keskin](https://github.com/bounswe/bounswe2023group8/wiki/Meri%C3%A7-Keskin-About) | With this feature, users can search for the locations and save them to see the forecast information for that day in that location. This feature lets you to save the weather forecasts of the locations that you want most to visit.
 7.Astronomy | [Miraç Öztürk](https://github.com/bounswe/bounswe2023group8/wiki/Mira%C3%A7-%C3%96zt%C3%BCrk-About) | The Astronomy API provides comprehensive access to a wealth of astronomical data. With this API, you can explore a vast collection of celestial objects, including stars, planets, asteroids, and galaxies. Effortlessly search for specific objects of interest and retrieve detailed information about their properties, such as distance, size, composition, and orbital characteristics.
 8.IP | [Orkun Kılıç](https://github.com/bounswe/bounswe2023group8/wiki/Orkun-Mahir-K%C4%B1l%C4%B1%C3%A7-About) | The IP API provides the IP and location details of the caller. With this API, we can retrieve detailed info about our user and we can save it if s/he approves.
 9.Locations | [Egemen Kaplan](https://github.com/bounswe/bounswe2023group8/wiki/Egemen-Kaplan-About) | While using the feature, user can place a marker on the Google Map, which will return a list of addresses available around the coordinates of the marker. Then, the user can select one of these addresses and submit it under a title. Later, the user can access these stored addresses by doing a search by title.

**Dictionary**
<img width="1009" alt="Screenshot 2023-05-12 at 21 57 17" src="https://github.com/bounswe/bounswe2023group8/assets/88006241/4a443416-fc40-4e3a-bff8-332912f9e683">

**Number Fact**
![screenshot](https://github.com/bounswe/bounswe2023group8/assets/110811440/86d11766-1845-4ff8-b9a1-b046257a05a7)

**Wikidata**
<img width="1792" alt="Screenshot 2023-05-12 at 21 49 30" src="https://github.com/bounswe/bounswe2023group8/assets/61244299/5a4d8da9-bb2e-48a3-918b-03debbe2f64b">

**Movies**
![moviesapi](https://github.com/bounswe/bounswe2023group8/assets/79804837/dd31205c-6276-43f0-8881-7e912a3ecbf0)

**Weather**
![forecast](https://github.com/bounswe/bounswe2023group8/assets/88164767/f93517e3-d641-4c08-ad4e-c99293caa851)

**Locations**

<img width="1658" alt="image" src="https://github.com/bounswe/bounswe2023group8/assets/22966868/79dc06f1-6ba9-47f3-a157-6cdc7de2dc5d">

**IP**
<img width="1141" alt="Screenshot 2023-05-12 at 21 00 55" src="https://github.com/bounswe/bounswe2023group8/assets/29154729/a441f200-f446-41d7-9a00-28242b4e255b">

 ### 1.3.2. Practice App Guide
  * URL of practice app code and the tag
  * URL of your application that was deployed with docker
  * Any information we may need to test your application
  * Instructions for building the application with docker
  * API URL (the URL should take us to a documented API)

# 2. Lessons Learned

## 2.1. Evaluation of Tools

During the creation of our project, we encountered various tasks that required the use of different tools. We carefully considered several factors when selecting the appropriate tool for each task. One important consideration was the ability to divide responsibilities among team members and facilitate collaboration, enabling us to easily track and review each other's work. Additionally, since we were learning as we progressed, usability was another crucial requirement. In the following sections, we will provide a concise overview of the tools we utilized, their functions, and our evaluation of their effectiveness.

### 2.1.1. Discord
Although Discord is not our main communication platform, it has helped us a lot, especially when helping each other and communicating with the teaching assistant. We've created multiple text channels on Discord for a variety of purposes, including sharing research materials, participating in general conversations, and even having casual discussions during team meetings. Discord has proven to be a valuable communication tool due to its user-friendly nature and the fact that many of us are already familiar with its functionality. One of its particularly useful features was the ability to create separate text channels and multiple audio channels within the same group, allowing screen sharing so we could all watch while someone was showing something. In addition, thanks to its mobile application, it also provided the opportunity to communicate with our friends who did not have access to a computer at that time. Thanks to the notification and mention features, we were able to reach each other whenever we needed. Thanks to the file sharing feature, we shared code snippets from time to time. In summary, using discord has greatly increased our productivity.

### 2.1.2. Zoom
We found Zoom extremely useful for our team meetings.

First, Zoom allowed us to interact face-to-face even though we weren't next to each other. Seeing everyone's expressions and body language helped us make stronger connections within the team and improved our overall communication.

Second, the screen sharing feature in Zoom was incredibly useful. It allowed us to present our work in real time, share project updates, and collaborate on documents or designs. This feature has significantly improved our ability to provide visual explanations and get immediate feedback from team members.
With the chat feature, we can view the links we found simultaneously, etc. We shared it with each other and had effective meetings by talking about it.

Finally, Zoom seamlessly integrates with other collaboration tools we use. But to mention a disadvantage, the 40-minute call limit in the community version forced us from time to time. Because our meetings and the lesson in general took a lot of time, sometimes we had to hold 4-5 meetings in a row, and the re-entering of all group members each time caused a waste of time.

Overall, Zoom has proven to be a valuable tool for our team meetings, providing effective communication, collaboration, and efficient information sharing. It helped close the physical distance between team members and contributed to the success of our project.

### 2.1.3. GitHub
Our team has found GitHub to be an invaluable platform for our project, offering a host of features and benefits that enhance our collaboration and development process. Our GitHub repository acts as a comprehensive portfolio showcasing our progress and deliveries. It provides a central location where you can easily access information about our team, including our members and their roles, and the design and research we conduct, in the wiki section.

One of the key benefits of GitHub is its issue tracking system, which allows us to effectively manage tasks and monitor progress. Through regularly updated issues, we can clearly set expectations for our project and assign specific tasks to team members. This helps us maintain transparency and accountability within our team.

GitHub's version control features have been instrumental in the success of our project. We use Git's stable changes and branching capabilities to manage different aspects of our development. This keeps everyone working on the most up-to-date version of the codebase and allows for seamless collaboration between team members.

Also, GitHub's user-friendly interface and great user interaction make it a preferred choice for us. It offers a seamless integration of version control and knowledge wiki, allowing us to combine these two important aspects in one place. This not only streamlines our workflow, but simplifies the process for both contributors and observers.

Overall, GitHub has proven to be an essential tool for our team. Its comprehensive features, efficient task management and smooth version control have contributed significantly to the success of our project.

### 2.1.4. Spring Boot

Spring Boot, a widely adopted framework for Java-based applications, was chosen for our project due to its compelling advantages. With simplified configuration, Spring Boot reduces development time by providing sensible defaults and embracing convention over configuration. Its seamless integration with microservices architecture enables scalable and modular application development. Additionally, the robust ecosystem surrounding Spring Boot, coupled with its developer-friendly features, such as automatic dependency management and embedded application servers, enhances productivity and reduces infrastructure setup time.

The pros of Spring Boot include rapid application development, seamless integration with the Spring ecosystem, auto-configuration capabilities, robust testing support, and built-in production-ready features. However, it's important to consider potential cons, such as a learning curve for newcomers to the Spring ecosystem, increased memory consumption compared to minimal frameworks, runtime overhead, and occasional dependency management challenges. Despite these considerations, Spring Boot has proven to be a valuable tool, empowering us to streamline development processes, increase productivity, and deliver robust applications. Additionally, thanks to the members we have who knew Spring Boot extensively, we did not have any issues regarding to difficulties from the complexity of Spring Boot.


### 2.1.5. React.js
Initially, we conducted a thorough evaluation of front-end development options, ultimately narrowing our choices down to React.js and Vue.js. Following extensive discussions, we ruled out Vue.js due to its comparatively limited functionalities when compared to React. Despite our team's lack of prior experience with React.js, we decided to embrace the challenge and acquire proficiency in this framework. We recognized the immense value of learning React.js, considering its popularity and continuous growth in the industry, which we believed would greatly benefit our future careers. To establish a solid foundation for our project, we created a central app and routing file. Additionally, we adopted a modular approach by creating separate branches for each unique feature, implementing the corresponding screens under the '/client' directory. JavaScript played a key role in our development process, serving as the primary language for creating the necessary components and screens.

### 2.1.6. Postman
Postman is an essential tool in our project workflow, providing us with a comprehensive platform for testing and documenting our APIs. It has greatly streamlined our API development process by allowing us to effortlessly send requests, view responses, and analyze data. The user-friendly interface and intuitive features of Postman enable us to efficiently create and organize collections, saving valuable time and effort. With Postman, we can easily set up and configure request parameters, headers, and authentication methods, allowing us to thoroughly test our APIs and ensure their functionality and reliability. The ability to save and reuse requests, as well as the option to automate tests using scripts, has significantly enhanced our productivity. Moreover, Postman's powerful collaboration features enable seamless team collaboration, facilitating communication and coordination between team members. Overall, Postman has become an indispensable tool in our project, empowering us to deliver high-quality APIs with confidence.

Also we've been able to create automatic documentation using Postman. Here is our API documentation for our Postman collection.
[Postman API Documentation](https://documenter.getpostman.com/view/27173951/2s93ecwAS8)

### 2.1.7. Docker

## 2.2. Evaluation of Processes
 
### 2.2.1. Team Meetings
Throughout the semester, we adhered to a consistent communication plan for the development and planning of our practice project. Following the spring break, we scheduled weekly meetings on either Discord or Zoom, ensuring regular discussions about project progress and upcoming tasks. Before each meeting, we prepared an agenda, establishing a structured plan for our discussions. Our meetings began by reviewing the previous week's work and assessing the project's current status. To enhance collaboration and visualization, we utilized Discord's screen-sharing feature when needed, allowing us to work together on tasks requiring joint effort. To maintain comprehensive documentation, one team member took meeting notes, which were subsequently uploaded to our GitHub repository for easy access. These team meetings played a pivotal role in making crucial project decisions, such as the selection of technologies to be employed. Additionally, we fostered a supportive environment where we actively shared knowledge and provided assistance to overcome challenges. To promote collaborative learning, we organized coding sessions where we coded and learned together as a team.

### 2.2.2. Questions to TA Using Discord
When we had questions or uncertainties about our assignments or completed work, we had the support and accessibility of our teaching assistant and teacher to address our concerns and provide clarifications. We often reached out to them through our Discord channel for guidance. After these discussions, we implemented the necessary changes and updates in our project in line with the feedback we received from our teaching assistant.
For example; We consulted about the structure of the diagrams for Milestone 1. For Milestone 2, we misunderstood the practice app structure at first, then Alper teacher helped us to do it right by clearly explaining the requirements. The feedback we've received this term to all assistants and Suzan teacher has been more general, but has provided us with helpful tips to further our project.

### 2.2.3. Issue Creation and Management
Our team effectively used GitHub's issue management system for our project and used a variety of features to improve task tracking and streamline our progress. A notable addition is the assignment of specific reviewers to each issue to ensure that tasks receive appropriate attention and feedback. Additionally, we have implemented colored labels based on different criteria such as type, status, priority and effort to provide quick visual clues and facilitate efficient issue management.

These features have greatly improved the structure and efficiency of our task management process on GitHub. Leveraging custom reviewers, color labels, and the standard issue template, we've created a well-structured workflow that caters specifically to our project's needs. This allows us to effectively monitor and manage our progress while ensuring consistency and accountability within our team.

### 2.2.4. Links to meeting notes
  * [Meeting 9](https://github.com/bounswe/bounswe2023group8/wiki/Meeting-%239)
  * [Meeting 10](https://github.com/bounswe/bounswe2023group8/wiki/Meeting-%2310)


### 2.2.5. Pull Request Creation and Management

As our project progressed towards coding, we relied heavily on pull requests to manage our project. We ensured a structured approach by having every team member create their own branch, and merged those branches with pull requests. This helped us organize our work and reduce conflicts by creating separate branches for each feature and improvement. Moreover, we linked pull requests to specific issues to enhance our project's organization. We found that GitHub's pull request system was an excellent tool for version control and was especially useful in managing a project with multiple contributors working on similar areas.

## 2.3. Challenges

At the beginning of the project, we faced a major hurdle in acquiring new skills, libraries, and programming languages that were essential for developing the practice app. This was a mentally and physically exhausting task, but we managed to overcome it by effectively communicating with each other and helping out.
The second significant challenge we faced was choosing a framework for the project. Most of us was not familiar with any of the frameworks, so we decided to use Spring for the backend. However, this required a lot of research and practice, and we relied on experienced members of our team to guide and demonstrate how to work with it.
Lastly, we encountered difficulties in implementing the frontend part of the project, which was designed to present our work visually using React.js, a modern JavaScript framework. Again, it was really hard for non-experienced team members to work with it and learn meanwhile, but we handled it.
Overall, we faced these challenges because the project's subject matter and tools were unfamiliar to us, and we had to step out of our comfort zones to learn new things. However, we were able to overcome these obstacles by working collaboratively and supporting each other. Although it was challenging, we ultimately achieved a remarkable result.


## 3. Individual Contribution Reports
* [Bahri Alabey](https://github.com/bounswe/bounswe2023group8/wiki/Milestone-2-Bahri-Alabey-Individual-Report)
* [Ömer Faruk Çelik](https://github.com/bounswe/bounswe2023group8/wiki/Ömer-Faruk-Çelik-Individual-Contribution-Report-for-Milestone-2)
* [Bahadır Gezer](https://github.com/bounswe/bounswe2023group8/wiki/Bahadır-Gezer-Individual-Contribution-Report---Milestone-2)
* [Egemen Kaplan](https://github.com/bounswe/bounswe2023group8/wiki/Egemen-Kaplan's-Individual-Contribution-Report-for-Milestone-2)
* [Meriç Keskin](https://github.com/bounswe/bounswe2023group8/wiki/Individual-Contribution-Report-(Meri%C3%A7-Keskin))
* [Orkun Mahir Kılıç](https://github.com/bounswe/bounswe2023group8/wiki/Milestone-2-Orkun-K%C4%B1l%C4%B1%C3%A7-Individual-Report)
* [Sude Konyalıoğlu](https://github.com/bounswe/bounswe2023group8/wiki/Individual-Contribution-Report-(Sude-Konyal%C4%B1o%C4%9Flu))
* [Hasan Baki Küçükçakıroğlu](https://github.com/bounswe/bounswe2023group8/wiki/Hasan-Baki-Kucukcakiroglu's-Individual-Contribution-Report-for-Milestone-2)
* [İbrahim Furkan Özçelik]()
* [Miraç Öztürk](https://github.com/bounswe/bounswe2023group8/wiki/Individual-Contribution-Report-(Mira%C3%A7-%C3%96zt%C3%BCrk))
* [Enes Yıldız](https://github.com/bounswe/bounswe2023group8/wiki/Individual-Contribution-Report-(Enes-Yıldız)) 
* [Begüm Yivli](https://github.com/bounswe/bounswe2023group8/wiki/Milestone-2---Beg%C3%BCm-Yivli-Individual-Report)





