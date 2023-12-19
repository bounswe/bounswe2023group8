# Project Development Weekly Progress Report

**Team Name:** Web Info Aggregator

**Date:** 19.12.2023

## Progress Summary

### **This week**

**On the backend side,**

We added profile and interest area picture upload/delete features since customer asked for more visual material at milestone-2. Age restriction, an important requirement, is implemented. Changing password was made available. Most importantly, implementation of annotations started and going on. On the other hand, we were always in contact with the team to fix the API problems as fast as possible. Even if they are not recorded by issues, we solved some syntactic and semantic bugs within feature commits. We tried to keep backend deployed on cloud to allow front end teams develop application easily. 

**On the Web side**,

We progressed further on our design implementations but they need revisions. Spot voting functionality has been implemented. Annotations are still a work in progress. We can create annotations, highlight texts and see created annotations and filter them by hovering our cursor over highlighted areas. Spot comments are working partially but incomplete.

**On the Mobile side**,

We are completing our designs page by page as we approach to the last milestone. Though they are nearly completed, revisions are needed. Settings page, privacy&safety information view and profile page has been implemented. We completed explore page, home page, search page and bunch pages. We added about page to bunch pages. 

### **Next week**

**On the Backend,**

Annotations were planned to be completed for this week, the base functionality was finished however during the lab Bahadir learnt that the annotations should be based on another server and database, these changes will be implemented A.S.A.P. so that we can show annotations in the final milestone. We reviewed requirements and pointed the missing features. We also considered the feedback from milestone-2. Most of the tasks of this week are to meet missing requirements and the requests of customer. 

**On the Web side,**

As we head into the final milestone, we will complete the remaining redesigns. We will complete annotations and spot comments. We will implement report functionality and moderation dashboard used for handling reports. We will handle access level rendering of our components and implement filtering and sorting of Spots on Bunch pages. Hopefully, we will have our app ready for the milestone.

**On the Mobile side,**

For the last week, we will complete our design implementations. Settings pages, profile page, spot detail page, edit bunch page and edit spot page needs revisions. The endpoints that were finished last week and during this week will be implemented through functionalities to our project. The remaining functionalities are upload/delete profile image and bunch image, change password, delete account, suggest tags, spot age restriction and join request state information.

## What was planned for the week? How did it go?

| Description | Issue | Assignee | Due | Artifact | Estimated Duration | Actual Duration |
| --- | --- | --- | --- | --- | --- | --- |
| Mobile - Settings Page | [Issue #561](https://github.com/bounswe/bounswe2023group8/issues/561) | Begüm | 18.12.2023 | [Pull #598](https://github.com/bounswe/bounswe2023group8/pull/598) | 4 hr | 4.5 hr |
| Backend - Upload/Delete profile picture API | [Issue #562](https://github.com/bounswe/bounswe2023group8/issues/562) | Baki | 18.12.2023 | [Pull #591](https://github.com/bounswe/bounswe2023group8/pull/591) | 3hr | 5hr |
| Backend - Restrict Posts by Age | [Issue #564](https://github.com/bounswe/bounswe2023group8/issues/564) | Baki | 18.12.2023 | [Pull #592](https://github.com/bounswe/bounswe2023group8/pull/592) | 3hr | 3hr |
| Backend - Upload/Delete interest area picture API | [Issue #573](https://github.com/bounswe/bounswe2023group8/issues/573) | Baki | 18.12.2023 | [Pull #590](https://github.com/bounswe/bounswe2023group8/pull/590) | 3hr | 3hr |
| Backend - Annotations | [Issue #566](https://github.com/bounswe/bounswe2023group8/issues/566) | Bahadır | 18.12.2023 | Not finished - in progress  | 8h | 3h |
| Backend - Add *And Implement* Role Management for Access Levels (Postponed to next week's report)  | [Issue #373](https://github.com/bounswe/bounswe2023group8/issues/373) | Bahadır | 15.12.2023 | Postponed - in progress  | 6h | - |
| Backend - Change Password API | [Issue #560](https://github.com/bounswe/bounswe2023group8/issues/560) | Bahadır | 18.12.2023 | [Pull #613](https://github.com/bounswe/bounswe2023group8/pull/613) | 3h | 0.5h |
| Mobile - Reporting | [Issue #570](https://github.com/bounswe/bounswe2023group8/issues/570) | Ömer | 18.12.2023 | [Pull #603](https://github.com/bounswe/bounswe2023group8/pull/603) | 2hr | 1hr |
| Mobile - Bunch Authorization Requests | [Issue #569](https://github.com/bounswe/bounswe2023group8/issues/569) | Ömer | 18.12.2023 | [Pull #604](https://github.com/bounswe/bounswe2023group8/pull/604) | 2hr | 2hr |
| Mobile - Comments CRUD Endpoints & Functionality Integration | [Issue #568](https://github.com/bounswe/bounswe2023group8/issues/568) | Ömer | 18.12.2023 | [Pull #606](https://github.com/bounswe/bounswe2023group8/pull/606) | 3hr | 1hr |
| Mobile - Upvote Downvote Post | [Issue #563](https://github.com/bounswe/bounswe2023group8/issues/563) | Ömer | 18.12.2023 | [Pull #600](https://github.com/bounswe/bounswe2023group8/pull/600) | 2hr | 2hr |
| Web - Compliance to Mockups - View Spot Details Page | [Issue #535](https://github.com/bounswe/bounswe2023group8/issues/535) | Egemen | 16.12.2023 | [Pull #602](https://github.com/bounswe/bounswe2023group8/pull/602) | 2hr | 2hr |
| Web - Compliance to Mockups - Update/Create Spot Page | [Issue #539](https://github.com/bounswe/bounswe2023group8/issues/539) | Egemen | 16.12.2023 | [Pull #602](https://github.com/bounswe/bounswe2023group8/pull/602) | 2hr | 1hr |
| Web - Spots Comment UI  | [Issue #580](https://github.com/bounswe/bounswe2023group8/issues/580) | Egemen | 18.12 2023 | - | 3hr | In progress - incomplete |
| Web - Comment CRUD | [Issue #581](https://github.com/bounswe/bounswe2023group8/issues/581) | Egemen | 18.12.2023 | - | 3hr | In progress - incomplete |
| Web - Fix signup flow after changes to backend | [Issue #586](https://github.com/bounswe/bounswe2023group8/issues/586) | Sude | 18.12.2023 | Not started | 1hr | - |
| Web - Fix follower/followings of user in profile | [Issue #579](https://github.com/bounswe/bounswe2023group8/issues/579) | Sude | 18.12.2023 | Not finished - in progress  | 2hr | - |
| Web - Compliance to Mockups - Timeline Page | [Issue #534](https://github.com/bounswe/bounswe2023group8/issues/534) | Sude | 18.12.2023 | Postponed | 2hr | - |
| Web - Bunch view request | [Issue #578](https://github.com/bounswe/bounswe2023group8/issues/578) | Bahri | 16.12.2023 | [Pull #614](https://github.com/bounswe/bounswe2023group8/pull/614) | 2hr | 3hr |
| Web - Add report functionality to bunches | [Issue #577](https://github.com/bounswe/bounswe2023group8/issues/577) | Bahri | 16.12.2023 | [Pull #612](https://github.com/bounswe/bounswe2023group8/pull/612) | 3hr | 3hr |
| Web - Update Bunches add privacy levels | [Issue #576](https://github.com/bounswe/bounswe2023group8/issues/576) | Bahri | 16.12.2023 | Not finished - in progress | 3hr | 2hr |
| Web - Add custom anchor tags | [Issue #574](https://github.com/bounswe/bounswe2023group8/issues/574) | Bahri | 16.12.2023 | [Pull #597](https://github.com/bounswe/bounswe2023group8/pull/597) | 1hr | 1hr |
| Complete annotation logic on Spots | [Issue #575](https://github.com/bounswe/bounswe2023group8/issues/575) | Furkan | 16.12.2023 | [Pull #619](https://github.com/bounswe/bounswe2023group8/pull/619) | 2hr | 2.5hr |
| Web - Annotations - Create Annotation | [Issue #528](https://github.com/bounswe/bounswe2023group8/issues/528) | Furkan | 16.12.2023 | [Pull #619](https://github.com/bounswe/bounswe2023group8/pull/619) | 2hr | 1.5hr |
| Web - Annotations - Sidebar view | [Issue #531](https://github.com/bounswe/bounswe2023group8/issues/531) | Furkan | 16.12.2023 | [Pull #619](https://github.com/bounswe/bounswe2023group8/pull/619) | 2hr | 1hr |
| Add Annotation Mock-ups | [Issue #517](https://github.com/bounswe/bounswe2023group8/issues/517) | Meriç | 16.12.2023 | - | 3hr | Canceled |
| Add Edit View Mock-up to Bunch Page | [Issue #521](https://github.com/bounswe/bounswe2023group8/issues/521) | Meriç | 16.12.2023 | [Edit Bunch](https://github.com/bounswe/bounswe2023group8/wiki/Mock-ups#edit-bunch) | 1hr | 2h |
| Implementing Home Page Design to Mobile | [Issue #522](https://github.com/bounswe/bounswe2023group8/issues/522) | Meriç | 19.12.2023 | [Pull #596](https://github.com/bounswe/bounswe2023group8/pull/596) | 2hr | 4hr |
| Implementing Search Page Design to Mobile | [Issue #523](https://github.com/bounswe/bounswe2023group8/issues/523) | Meriç | 19.12.2023 | [Pull #608](https://github.com/bounswe/bounswe2023group8/pull/608) | 2hr | 3hr |
| Implementing Explore Page Design to Mobile | [Issue #525](https://github.com/bounswe/bounswe2023group8/issues/525) | Meriç | 19.12.2023 | [Pull #607](https://github.com/bounswe/bounswe2023group8/pull/607) | 2hr | 2hr |
| Mobile - Sort and Filter Functionalities for Spots | [Issue #583](https://github.com/bounswe/bounswe2023group8/issues/583) | Meriç | 19.12.2023 | [Issue #631](https://github.com/bounswe/bounswe2023group8/issues/631) | 3hr | Transferred |
| Updating Spot Detail, Create Spot and Edit Spot Mock-ups for Web | [Issue #585](https://github.com/bounswe/bounswe2023group8/issues/585) | Meriç | 16.12.2023 | [Spot Pages](https://github.com/bounswe/bounswe2023group8/wiki/Mock-ups#spot) | 2hr | 6hr |
| Mobile - Profile Page and Pop-up modification | [Issue #518](https://github.com/bounswe/bounswe2023group8/issues/518) | Enes | 19.12.2023 | [Pull #611](https://github.com/bounswe/bounswe2023group8/pull/611) | 3hr | 4hr |

## Completed tasks that were not planned for the week

| Description | Issue | Assignee | Due | Artifact | Actual Duration |
| --- | --- | --- | --- | --- | --- |
| Web - Upvote/Downvote Spots Functionality | [Issue #601](https://github.com/bounswe/bounswe2023group8/issues/601) | Egemen | 18.12.2023 | [Pull #602](https://github.com/bounswe/bounswe2023group8/pull/602) | 3hr |
| Mobile - Privacy and Safety Page | [Issue #593](https://github.com/bounswe/bounswe2023group8/issues/593) | Begüm | 18.12.2023 | [Pull #598](https://github.com/bounswe/bounswe2023group8/pull/598) | 1.5 hr |
| Mobile - Spot Card | [Issue #522](https://github.com/bounswe/bounswe2023group8/issues/522) | Meriç | 19.12.2023 | [Pull #596](https://github.com/bounswe/bounswe2023group8/pull/596) | 2hr |
| Mobile - Revise Bunch Pages | [Issue #599](https://github.com/bounswe/bounswe2023group8/issues/599) | Meriç | 19.12.2023 | [Pull #605](https://github.com/bounswe/bounswe2023group8/pull/605) | 7hr |

## Planned vs. Actual

We were planning to complete redesigning our app according to the mockups by now but it was a much larger task than we thought. We hope to at least complete it in a satisfactory way before the final milestone.

## Your plans for the next week

| Description | Issue | Assignee | Due | Estimated Duration |
| --- | --- | --- | --- | --- |
| Project - API Endpoints | [Issue #629](https://github.com/bounswe/bounswe2023group8/issues/629) | Bahadır, Baki | 25.12.2023 | 4hr |
| Project - User Interface / User Experience - Web | [Issue #651](https://github.com/bounswe/bounswe2023group8/issues/651) | Egemen | 29.12.2023 | 3hr |
| Project - User Interface / User Experience - Mobile | [Issue #638](https://github.com/bounswe/bounswe2023group8/issues/638) | Meriç | 29.12.2023 | 4hr |
| Project - Annotations | [Issue #630](https://github.com/bounswe/bounswe2023group8/issues/630) | Furkan, Bahadır | 29.12.2023 | 4hr |
| Project - Scenarios | [Issue #642](https://github.com/bounswe/bounswe2023group8/issues/642) | Meriç | 25.12.2023 | 2hr |
| Project - Use and Maintenance - Web | [Issue #652](https://github.com/bounswe/bounswe2023group8/issues/652) | Bahri | 29.12.2023 | 2hr |
| Project - Use and Maintenance - Mobile | [Issue #639](https://github.com/bounswe/bounswe2023group8/issues/639) | Ömer | 29.12.2023 | 2hr |
| Project - User Manual | [Issue #635](https://github.com/bounswe/bounswe2023group8/issues/635) | Begüm, Sude | 29.12.2023 | 4hr |
| Project - System Manual | [Issue #649](https://github.com/bounswe/bounswe2023group8/issues/649) | Baki, Ömer | 29.12.2023 | 4hr |
| Project - Software Requirements Specification (SRS) | [Issue #640](https://github.com/bounswe/bounswe2023group8/issues/640) | Furkan | 29.12.2023 | 4hr |
| Project - Software Design Documents (using UML) | [Issue #653](https://github.com/bounswe/bounswe2023group8/issues/653) | Bahri | 29.12.2023 | 3hr |
| Project - User Scenarios (Use Cases) | [Issue #646](https://github.com/bounswe/bounswe2023group8/issues/646) | Enes | 29.12.2023 | 3hr |
| Project - Mock-ups | [Issue #647](https://github.com/bounswe/bounswe2023group8/issues/647) | Meriç | 29.12.2023 | 4hr |
| Project - Research | [Issue #654](https://github.com/bounswe/bounswe2023group8/issues/654) | Begüm | 29.12.2023 | 3hr |
| Project - Project Plan | [Issue #644](https://github.com/bounswe/bounswe2023group8/issues/644) | Enes | 29.12.2023 | 4hr |
| Project - Unit Tests and Reports | [Issue #628](https://github.com/bounswe/bounswe2023group8/issues/628) | Bahadır, Baki | 25.12.2023 | 4hr |
| Project - Software | [Issue #637](https://github.com/bounswe/bounswe2023group8/issues/637) | Egemen, Baki | 25.12.2023 | 4hr |
| Project - Data for at least 100 realistic posts | [Issue #634](https://github.com/bounswe/bounswe2023group8/issues/634) | Begüm, Sude | 25.12.2023 | 4hr |
| Web - Filter/Sort Spot in interest area pages | [Issue #632](https://github.com/bounswe/bounswe2023group8/issues/632) | Furkan | 25.12.2023 | 2hr |
| Web - Adjustments to Annotation after team feedback at lab | [Issue #633](https://github.com/bounswe/bounswe2023group8/issues/633) | Furkan | 25.12.2023 | 5hr |
| Web - Fix signup flow after changes to backend | [Issue #586](https://github.com/bounswe/bounswe2023group8/issues/586) | Sude | 25.12.2023 | 4hr |
| Web - Fix follower/followings of user in profile | [Issue #579](https://github.com/bounswe/bounswe2023group8/issues/579) | Sude | 25.12.2023 | 3hr |
| Web - Display user vote badge on profile | [Issue #650](https://github.com/bounswe/bounswe2023group8/issues/650) | Sude | 25.12.2023 | 2hr |
| Web - Update Bunches add privacy levels | [Issue #576](https://github.com/bounswe/bounswe2023group8/issues/576) | Bahri | 25.12.2023 | 4hr |
| Web - Rendering pages depending on access levels | [Issue #648](https://github.com/bounswe/bounswe2023group8/issues/648) | Bahri | 25.12.2023 | 2hr |
| Web - Add post report functionality | [Issue #618](https://github.com/bounswe/bounswe2023group8/issues/618) | Bahri | 25.12.2023 | 3hr |
| Web - Add user reporting functionality | [Issue #617](https://github.com/bounswe/bounswe2023group8/issues/617) | Bahri | 25.12.2023 | 3hr |
| Web - Moderation Board | [Issue #641](https://github.com/bounswe/bounswe2023group8/issues/641) | Egemen | 25.12.2023 | 6hr |
| Web - Get User Notifications - warnings from reports | [Issue #643](https://github.com/bounswe/bounswe2023group8/issues/643) | Egemen | 25.12.2023 | 2hr |
| Web - Spots Comment UI | [Issue #580](https://github.com/bounswe/bounswe2023group8/issues/580) | Egemen | 25.12.2023 | 2hr |
| Web - Comment CRUD | [Issue #581](https://github.com/bounswe/bounswe2023group8/issues/581) | Egemen | 25.12.2023 | 1hr |
| Web - Suggest Spot/Bunch tags | [Issue #645](https://github.com/bounswe/bounswe2023group8/issues/645) | Egemen | 25.12.2023 | 4hr |
| Mobile - Modify Create and Edit Bunch | [Issue #625](https://github.com/bounswe/bounswe2023group8/issues/625) | Enes | 25.12.2023 | 5hr |
| Mobile - Annotations Feature | [Issue #620](https://github.com/bounswe/bounswe2023group8/issues/620) | Ömer | 25.12.2023 | 5hr |
| Mobile - Settings UI / Functionalities | [Issue #621](https://github.com/bounswe/bounswe2023group8/issues/621) | Ömer | 25.12.2023 | 3hr |
| Mobile - Spot age restriction mechanism | [Issue #622](https://github.com/bounswe/bounswe2023group8/issues/622) | Ömer | 25.12.2023 | 1hr |
| Mobile - Profile/Bunch Images | [Issue #623](https://github.com/bounswe/bounswe2023group8/issues/623) | Ömer | 25.12.2023 | 2hr |
| Mobile - Redirects within the App | [Issue #624](https://github.com/bounswe/bounswe2023group8/issues/624) | Ömer | 25.12.2023 | 2hr |
| Mobile - Revising Settings Pages | [Issue #609](https://github.com/bounswe/bounswe2023group8/issues/609) | Meriç | 25.12.2023 | 2hr |
| Mobile - Revising Static Widgets | [Issue #610](https://github.com/bounswe/bounswe2023group8/issues/610) | Meriç | 25.12.2023 | 5hr |
| Mobile - Revising Profile Page | [Issue #636](https://github.com/bounswe/bounswe2023group8/issues/636) | Meriç | 25.12.2023 | 3hr |
| Mobile - Sort and Filter Functionalities for Spots | [Issue #631](https://github.com/bounswe/bounswe2023group8/issues/631) | Begüm | 25.12.2023 | 6hr |
| Backend - Post New Tag Suggestion APIs | [Issue #615](https://github.com/bounswe/bounswe2023group8/issues/615) | Baki | 25.12.2023 | 4hr |
| Backend - Interest Area New Tag Suggestion APIs | [Issue #616](https://github.com/bounswe/bounswe2023group8/issues/616) | Baki | 25.12.2023 | 4hr |
| Backend - Interest Area Follow Request Indicator | [Issue #626](https://github.com/bounswe/bounswe2023group8/issues/626) | Baki | 25.12.2023 | 3hr |
| Backend - Basic Data of Private Interest Area Should Be Visible To Non-Following Users | [Issue #627](https://github.com/bounswe/bounswe2023group8/issues/627) | Baki | 25.12.2023 | 2hr |


## Risks

Applying design changes and new features at the same time carries the risk of not completing the app before our final milestone.

## Participants

Name | Participation
-- | --
Bahadır Gezer | ✅
Hasan Baki Küçükçakıroğlu | ✅
Egemen Kaplan | ✅
İbrahim Furkan Özçelik | ✅
Ömer Faruk Çelik | ❌
Begüm Yivli | ✅
Enes Yıldız | ✅
Sude Konyalıoğlu | ✅
Bahri Alabey | ✅
Miraç Öztürk | ❌
Meriç Keskin | ✅
