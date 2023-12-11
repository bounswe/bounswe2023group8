# Project Development Weekly Progress Report

**Team Name:** Web Info Aggregator

**Date:** 05.12.2023

## Progress Summary

### **This week**

**On the backend,**

We prepared most of the core functionality related to posts, interest areas and users. Most importantly, the logic system related to access levels and data access created and works properly.(e.g. A user cannot see the posts of a private interest area without being a member.) We also created some APIs like Home Page API, Profile Page API for convenience of frontend team. 

**On the Web side**,

We prepared our app for the Milestone 2. We integrated all our previously implemented UI elements with their CRUD endpoints. We have most of our app ready except for its compliance to the new mockups, annotations, moderation boards, report user and settings views. There are minor changes to be made for conditional renders.

**On the Mobile side**, 

We implemented many of the requirements to our mobile project until Milestone 2. New mock-up designs, annotations, moderation boards, report and suggestion functions and settings views. There are much to improve in the mobile project, but we are moving forward with solid steps.

### **Next week**

**On the Backend,**

Only a few general sections are left unimplemented in the backend. Apart from a general code cleanup, what's left is: reputation system, reporting and moderation portal for system users, reporting and moderation system inside the app, security and access levels throughout the app, user experience stuff like comments, upvotes and downvotes, annotations, finalization of the suggestion structure, endpoints for annotations, and the interesting issue of restricted content. 

For next week, the reputation system, reporting and moderation in its entirety as described in the requirements will be finished. User account deletion will be carefully checked off from the requirements. Access level management for interest areas which was leftover from milestone 2 will also be completed. 

****************************On the Web side,****************************

We will change our overall design according to the new mockups and start implementing annotation views.

****************On the Mobile Side,****************

The designs will be implemented according to updated mock-ups. It requires a week of work as they are detailed and rest of the features are getting ready.


## What was planned for the week? How did it go?

| Description | Issue | Assignee | Due | Artifact | Estimated Duration | Actual Duration |
| --- | --- | --- | --- | --- | --- | --- |
| Web - Integrate create IA with wiki endpoint | [#407](https://github.com/bounswe/bounswe2023group8/issues/407) | Bahri | 27.11.2023 | [PR #439](https://github.com/bounswe/bounswe2023group8/pull/439) | 1hr | 2hr |
| Web - Integrate create IA request with the backend side | [#408](https://github.com/bounswe/bounswe2023group8/issues/408) | Bahri | 23.11.2023 | [PR #429](https://github.com/bounswe/bounswe2023group8/pull/429) | 1hr | 2hr |
| Web - Integrate create post with wiki endpoint | [#409](https://github.com/bounswe/bounswe2023group8/issues/409) | Bahri | 27.11.2023 | [PR #445](https://github.com/bounswe/bounswe2023group8/pull/445) | 1hr | 1hr |
| Web - Integrate update post with wiki endpoint | [#411](https://github.com/bounswe/bounswe2023group8/issues/411) | Bahri | 27.11.2023 | [PR #445](https://github.com/bounswe/bounswe2023group8/pull/445) | 1hr | 2hr |
| Web - Update Interest Area Page | [#412](https://github.com/bounswe/bounswe2023group8/issues/412) | Bahri | 27.11.2023 | [PR #448](https://github.com/bounswe/bounswe2023group8/pull/448) | 2hr | 4hr |
| Web - Profile Page CRUD Integration and Polish Page | [#418](https://github.com/bounswe/bounswe2023group8/issues/418) | Egemen | 27.11.2023 | [PR #472](https://github.com/bounswe/bounswe2023group8/pull/472) | 2hr | 3hr |
| Web - Timeline CRUD Integration | [#422](https://github.com/bounswe/bounswe2023group8/issues/422) | Egemen  | 27.11.2023 | [PR #490](https://github.com/bounswe/bounswe2023group8/pull/490) | 2hr | 1hr |
| Web - Finalize Post CRUD Integration | [#424](https://github.com/bounswe/bounswe2023group8/issues/424) | Egemen | 27.11.2023 | [PR #480](https://github.com/bounswe/bounswe2023group8/pull/480) | 2hr | 2hr |
| Web - General Search | [#425](https://github.com/bounswe/bounswe2023group8/issues/425) | Bahri | 27.11.2023 | [PR #487](https://github.com/bounswe/bounswe2023group8/pull/487) | 3hr |  |
| Mobile - Posts CRUD Endpoints Integration | [#378](https://github.com/bounswe/bounswe2023group8/issues/378) | Ömer | 28.11.2023 | [PR #474](https://github.com/bounswe/bounswe2023group8/pull/474) | 5hr |  |
| Update Mock-ups according to needs occurred when integration of pages | [#419](https://github.com/bounswe/bounswe2023group8/issues/419) | Meriç, Sude | 24.11.2023 | [Wiki](https://github.com/bounswe/bounswe2023group8/wiki/Mock-ups) | 10hr | 16hr |
| Backend - Interest Area Page API | [#414](https://github.com/bounswe/bounswe2023group8/issues/414) | Baki | 24.11.2023 | [PR #438](https://github.com/bounswe/bounswe2023group8/pull/438) | 4hr | 5hr |
| Backend - Interest Area Search API | [#415](https://github.com/bounswe/bounswe2023group8/issues/415) | Baki | 24.11.2023 | [PR #431](https://github.com/bounswe/bounswe2023group8/pull/431) | 2hr | 3hr |
| Backend - Home(Feed) Page API | [#416](https://github.com/bounswe/bounswe2023group8/issues/416) | Baki | 24.11.2023 | [PR #441](https://github.com/bounswe/bounswe2023group8/pull/441) | 4hr | 5hr |
| Backend - Create Comment Model and CRUD APIs | [#337](https://github.com/bounswe/bounswe2023group8/issues/337) | Baki | 27.11.2023 | Not completed since it is removed from milestone | 3hr | — |
| Backend - Create Post CRUD APIs | [#334](https://github.com/bounswe/bounswe2023group8/issues/334) | Baki | 27.11.2023 | [PR #432](https://github.com/bounswe/bounswe2023group8/pull/432) | 6hr | 6hr |
| Mobile - Integrating Home Page Api | [#413](https://github.com/bounswe/bounswe2023group8/issues/413) | Ömer | 27.11.2023 | [PR #457](https://github.com/bounswe/bounswe2023group8/pull/457) | 2hr |  |
| Mobile - Integrating Profile Api | [#417](https://github.com/bounswe/bounswe2023group8/issues/417) | Ömer | 27.11.2023 | [PR #447](https://github.com/bounswe/bounswe2023group8/pull/447) | 2hr |  |
| Mobile - Integrating Search Api | [#420](https://github.com/bounswe/bounswe2023group8/issues/420) | Ömer | 27.11.2023 | [PR #460](https://github.com/bounswe/bounswe2023group8/pull/460) | 3hr |  |
| Mobile - Integrating Follow Api | [#421](https://github.com/bounswe/bounswe2023group8/issues/421) | Ömer | 27.11.2023 | [PR #468](https://github.com/bounswe/bounswe2023group8/pull/468) | 2hr |  |
| Mobile - Geolocation support when creating a post | [#423](https://github.com/bounswe/bounswe2023group8/issues/423) | Furkan | 27.11.2023 |  | 5hr |  |
| Web - Integrate adding IA with nestedIAs | [#426](https://github.com/bounswe/bounswe2023group8/issues/426) | Bahri | 27.11.2023 | [PR #443](https://github.com/bounswe/bounswe2023group8/pull/443) | 3hr | 4hr |

## Completed tasks that were not planned for the week

| Description | Issue | Assignee | Due | Artifact | Actual Duration |
| --- | --- | --- | --- | --- | --- |
| Dockerize and Deploy Project for Milestone 2 | [#482](https://github.com/bounswe/bounswe2023group8/issues/482) | Egemen, Baki | 27.11.2023 | [PR #483](https://github.com/bounswe/bounswe2023group8/pull/483) | 1hr |
| Prepare API documentation for Milestone 2 | [#505](https://github.com/bounswe/bounswe2023group8/issues/505) | Egemen | 03.11.2023 | [Postman Docs](https://documenter.getpostman.com/view/30817138/2s9YRGy9fA#2df72471-37a0-4443-aa03-4564563ef565) | 1hr |
| Testing Web UI using Trailblu | [#513](https://github.com/bounswe/bounswe2023group8/issues/513) | Egemen, Baki | 03.11.2023 | - | 2hr |
| Updating assets of Mobile Project | [#462](https://github.com/bounswe/bounswe2023group8/issues/462) | Meriç | 27.11.2023 | [PR #463](https://github.com/bounswe/bounswe2023group8/pull/463) | 2hr |
| Updating Mobile Project according to Mock-ups changes | [#428](https://github.com/bounswe/bounswe2023group8/issues/428) | Meriç | 27.11.2023 | [PR #477](https://github.com/bounswe/bounswe2023group8/pull/477) | 3hr |
| Mobile - Interest Area Page API Integration | [#449](https://github.com/bounswe/bounswe2023group8/issues/449) | Ömer | 27.11.2023 | [PR #451](https://github.com/bounswe/bounswe2023group8/pull/451) | 2hr |
| Mobile - Update Sign Up Endpoint and Add Logout Function | [#452](https://github.com/bounswe/bounswe2023group8/issues/452) | Ömer | 27.11.2023 | [PR #453](https://github.com/bounswe/bounswe2023group8/pull/453) | 2hr |
| Mobile - Search Screens | [#459](https://github.com/bounswe/bounswe2023group8/issues/459) | Ömer | 27.11.2023 | [PR #461](https://github.com/bounswe/bounswe2023group8/pull/461) | 3hr |
| Mobile - ReImplement Post Widget | [#465](https://github.com/bounswe/bounswe2023group8/issues/465) | Ömer | 27.11.2023 | [PR #466](https://github.com/bounswe/bounswe2023group8/pull/466) | 2hr |
| Milestone Report-Summary of Customer Feedback | [#494](https://github.com/bounswe/bounswe2023group8/issues/494) | Begüm | 01.12.2023 | [Wiki](https://github.com/bounswe/bounswe2023group8/wiki/Milestone-2-Review) | 1hr |
| Milestone Report-Describing Changes | [#495](https://github.com/bounswe/bounswe2023group8/issues/495) | Begüm, Sude | 01.12.2023 | [Wiki](https://github.com/bounswe/bounswe2023group8/wiki/Milestone-2-Review) | 0.5hr |
| Milestone Report-List and Status of Deliverables | [#497](https://github.com/bounswe/bounswe2023group8/issues/497) | Begüm | 01.12.2023 | [Wiki](https://github.com/bounswe/bounswe2023group8/wiki/Milestone-2-Review) | 0.5hr |
| Milestone Report-The General Test Plan for Project | [#499](https://github.com/bounswe/bounswe2023group8/issues/499) | Begüm, Sude | 01.12.2023 | [Wiki](https://github.com/bounswe/bounswe2023group8/wiki/Milestone-2-Review) | 0.5hr |
| Backend - Arrange Exceptions and Exception Handlings | [#433](https://github.com/bounswe/bounswe2023group8/issues/433) | Baki | 24.11.2023 | [PR #434](https://github.com/bounswe/bounswe2023group8/pull/434) | 2hr |
| Backend - Refactor Big Services | [#435](https://github.com/bounswe/bounswe2023group8/issues/435) | Baki | 27.11.2023 | [PR #436](https://github.com/bounswe/bounswe2023group8/pull/436) | 2hr |
| Backend - Home(Feed) Page API | [#416](https://github.com/bounswe/bounswe2023group8/issues/416) | Baki | 27.11.2023 | [PR #441](https://github.com/bounswe/bounswe2023group8/pull/441) | 4hr |
| Create customer-milstone-2 release | [#484](https://github.com/bounswe/bounswe2023group8/issues/484) | Baki | 28.11.2023 | [Release](https://github.com/bounswe/bounswe2023group8/releases/tag/customer-milestone-2) | 1hr |

## Planned vs. Actual

Overall, we were planning to implement annotations before the search function, but we implemented the search function before annotations. We planned to implement lots of things and present a satisfactory application in the milestone, and we achieved.

## Your plans for the next week

| Description | Issue | Assignee | Due | Estimated Duration |
| --- | --- | --- | --- | --- |
| Backend - Add Role Management for Access Levels | [#373](https://github.com/bounswe/bounswe2023group8/issues/373) | Bahadır | 12.12.2023 | 6h |
| Backend - User Account Deletion | [#515](https://github.com/bounswe/bounswe2023group8/issues/515) | Bahadır | 12.12.2023 | 3h |
| Backend - Add The Reputation System | [#516](https://github.com/bounswe/bounswe2023group8/issues/516) | Bahadır | 12.12.2023 | 8h |
| Backend - Implement Reporting and Moderation Core Function - Moderation Dashboard | [#526](https://github.com/bounswe/bounswe2023group8/issues/526) | Bahadır | 12.12.2023 | 12h |
| Backend - Create Comment Model and CRUD APIs | [#337](https://github.com/bounswe/bounswe2023group8/issues/337) | Baki | 12.12.2023 | 4hr |
| Backend - Down/Upvoting a post. | [#524](https://github.com/bounswe/bounswe2023group8/issues/524) | Baki | 12.12.2023 | 4hr |
| Backend - List, Accept/Reject Interest Area Join Requests | [#527](https://github.com/bounswe/bounswe2023group8/issues/527) | Baki | 12.12.2023 | 5hr |
| Add Annotation Mock-ups | [#517](https://github.com/bounswe/bounswe2023group8/issues/517) | Meriç | 11.12.2023 | 2hr |
| Add Edit View Mock-up to Bunch Page | [#521](https://github.com/bounswe/bounswe2023group8/issues/521) | Meriç | 11.12.2023 | 2hr |
| Implementing Home Page Design to Mobile | [#522](https://github.com/bounswe/bounswe2023group8/issues/522) | Meriç | 11.12.2023 | 2hr |
| Implementing Search Page Design to Mobile | [#523](https://github.com/bounswe/bounswe2023group8/issues/523) | Meriç | 11.12.2023 | 2hr |
| Implementing Explore Page Design to Mobile | [#525](https://github.com/bounswe/bounswe2023group8/issues/525) | Meriç | 11.12.2023 | 2hr |
| Web - Create CSS classNames according to mockups and add common assets/icons from figma | [#529](https://github.com/bounswe/bounswe2023group8/issues/529) | Egemen | 09.12.2023 | 2hr |
| Web - Compliance to Mockups - View Bunch Page | [#530](https://github.com/bounswe/bounswe2023group8/issues/530) | Bahri | 11.12.2023 | 2hr |
| Web - Compliance to Mockups - Update/Create Bunch Page | [#532](https://github.com/bounswe/bounswe2023group8/issues/532) | Bahri | 11.12.2023 | 2hr |
| Web - Compliance to Mockups - View Spot Details Page | [#535](https://github.com/bounswe/bounswe2023group8/issues/535) | Miraç | 11.12.2023 | 2hr |
| Web - Compliance to Mockups - Update/Create Spot Page | [#539](https://github.com/bounswe/bounswe2023group8/issues/539) | Miraç | 11.12.2023 | 2hr |
| Web - Compliance to Mockups - Small Spot Card Preview | [#540](https://github.com/bounswe/bounswe2023group8/issues/540) | Egemen | 11.12.2023 | 2hr |
| Web - Compliance to Mockups - Topbar/Sidebar | [#538](https://github.com/bounswe/bounswe2023group8/issues/538) | Furkan | 11.12.2023 | 2hr |
| Web - Compliance to Mockups - Auth Modals | [#537](https://github.com/bounswe/bounswe2023group8/issues/537) | Furkan | 11.12.2023 | 2hr |
| Web - Compliance to Mockups - Profile Page | [#536](https://github.com/bounswe/bounswe2023group8/issues/536) | Sude | 11.12.2023 | 2hr |
| Web - Compliance to Mockups - Timeline Page | [#534](https://github.com/bounswe/bounswe2023group8/issues/534) | Sude | 11.12.2023 | 2hr |
| Web - Annotations - Annotation display on Spot body and search | [#533](https://github.com/bounswe/bounswe2023group8/issues/533) | Furkan | 11.12.2023 | 4hr |
| Web - Annotations - Sidebar view | [#531](https://github.com/bounswe/bounswe2023group8/issues/531) | Bahri | 11.12.2023 | 4hr |
| Web - Annotations - Create Annotation | [#528](https://github.com/bounswe/bounswe2023group8/issues/528) | Egemen | 11.12.2023 | 4hr |
| Mobile - Modify Create Bunch View | [#520](https://github.com/bounswe/bounswe2023group8/issues/520) | Ömer | 11.12.2023 | 2hr |
| Mobile - Modify Spot Details View | [#519](https://github.com/bounswe/bounswe2023group8/issues/519) | Ömer | 11.12.2023 | 2hr |
| Mobile - Updating Bunch Member | [#470](https://github.com/bounswe/bounswe2023group8/issues/470) | Begüm | 11.12.2023 | 3hr |
| Mobile - Geolocation support when creating a post | [#423](https://github.com/bounswe/bounswe2023group8/issues/423) | Ömer | 11.12.2023 | 4hr |

## Risks

Changing overall design in such a way may complicate our work moving forward. We don’t have much time left till the 3rd Milestone. 

## Participants

| Name | Participation |
| --- | --- |
| Bahadır Gezer | ✅ |
| Hasan Baki Küçükçakıroğlu | ✅ |
| Egemen Kaplan | ✅ |
| İbrahim Furkan Özçelik | ✅ |
| Ömer Faruk Çelik | ✅ |
| Begüm Yivli | ✅ |
| Enes Yıldız | ✅ |
| Sude Konyalıoğlu | ✅ |
| Bahri Alabey | ✅ |
| Miraç Öztürk | ❌ |
| Meriç Keskin | ✅ |

**ORDER OF IMPORTANCE:**

1) 1.2.1.4 Annotations: Most important because it is the customer's most requested feature and it fits our platform.

2) 1.1.2.5 Users shall have control over privacy settings of IAs. (e.g. public, private and personal). Also very important because customer asked last meeting and crucial to ensure privacy.

3) 1.1.4.1.4 Down/Upvoting a post. Quite necessary feature because it gives an idea about which posts are most liked or hated, good for user experience.

4) 1.1.4.1.3 Commenting on a post. Also necessary for better user experience because users could explain their ideas and give new information. 

5) 1.2.4 Moderation Necessary for better user experience because it prevents usage of the apps against the ToS. 

6) 1.1.3.3 Vote on other users based on their profile, behavior, and activity on the platform which will affect the target's reputation scores (See "1.2.3.2 Reputation system") Nice feature but do not affect the overall purpose of the platform, so not that critical.

7) 1.1.4.1.5 Reporting inappropriate posts to IA moderators. (See "1.1.4.2.7" for more info in Moderators) Good for safety, can be implemented later.

8) 1.1.4.2.7 Reporting inappropriate IAs to System Administrators. Good for safety, can be implemented later.

9) 1.2.3 Labeling We have some labeling features, but it should be improved, for example, suggesting labels to post or IA but not that critical right now.

10) 1.2.2.2 The system shall enable post filtering by interest areas, date, location, and other metadata. Good for user experience but can be implemented later because it doesn’t affect the overall purpose of the platform. 

11) 1.2.2.3 The system shall enable the user to sort search results by relevance, date, and popularity We have a search function but search results cannot be sorted yet. Good for user experience but can be implemented later because it doesn’t affect the overall purpose of the platform.

12) 1.1.2.2 Users shall be able to delete their accounts. Good for user experience but can be implemented later because if a user doesn’t want to be seen, his/her posts or IAs, he/she can make it private. 

13) 1.1.4.1.7 Suggesting additional tags to posts created by other users. Nice feature but not that critical. 

14) 1.1.4.2.6 Suggesting additional tags to IAs created by other users. Nice feature but not that critical. 
15) 2.4 Restricted Content


