
# Project Development Weekly Progress Report

**Team Name:** Web Info Aggregator

**Date:** 07.11.2023

## Progress Summary

**This week** **On the backend** 

**On the Web side**, our app has its base layout with a topbar and a sidebar set and we have a profile page ready only with mock data. Users can now create an account, login with their account and reset their password if they wish.  We managed to set the deployment mechanism for EC2.

**On the Mobile side**, we created the bottom navigation bar and navigation routes, implemented the profile view, created the necessary models and widgets, provided log out functionality through a button at settings page, also integrated the authentication endpoints to our application.

**Next week,** We are focusing on all the details related to Posts. We will implement both the API endpoints and the views for creating, viewing and updating posts.

## What was planned for the week? How did it go?

Description | Issue | Assignee | Due | Artifact | Estimated Duration | Actual Duration
-- | -- | -- | -- | -- | -- | --
Backend - /auth/logout | [#259](https://github.com/bounswe/bounswe2023group8/issues/259) | Bahadır | 31.10.2023 | [#249](https://github.com/bounswe/bounswe2023group8/pull/249) | 3hr |  
Backend - /auth/forgot-password | [#258](https://github.com/bounswe/bounswe2023group8/issues/258) | Baki | 31.10.2023 | [285](https://github.com/bounswe/bounswe2023group8/pull/285) | 5hr | 5hr
Backend - Dockerize | [#268](https://github.com/bounswe/bounswe2023group8/issues/268) | Bahadır | 31.10.2023 | [#235](https://github.com/bounswe/bounswe2023group8/pull/235), [#269](https://github.com/bounswe/bounswe2023group8/issues/269) | 3hr |  
Backend - Deployment | [269](https://github.com/bounswe/bounswe2023group8/issues/269) | Baki | 31.10.2023 | http://api.bunchup.com.tr | 5hr | 5hr
Mobile - Implement Bottom Navigation Bar | [#262](https://github.com/bounswe/bounswe2023group8/issues/262) | Ömer | 31.10.2023 | [#277](https://github.com/bounswe/bounswe2023group8/pull/277) | 2hr | 1.5hr
Mobile - Post Model / Widget | [#263](https://github.com/bounswe/bounswe2023group8/issues/263) | Furkan | 31.10.2023 | [#289](https://github.com/bounswe/bounswe2023group8/pull/289) | 2hr | 1.5hr
Mobile - Follower Pop Up | [#266](https://github.com/bounswe/bounswe2023group8/issues/266) | Begüm | 31.10.2023 | [#293](https://github.com/bounswe/bounswe2023group8/pull/293) | 3hr | 3hr
Mobile - Dockerize | [#267](https://github.com/bounswe/bounswe2023group8/issues/267) | Enes | 31.10.2023 | [#267](https://github.com/bounswe/bounswe2023group8/issues/267) | 1hr | 30min
Mobile - Profile Header | [#270](https://github.com/bounswe/bounswe2023group8/issues/270) | Ömer | 31.10.2023 | [#294](https://github.com/bounswe/bounswe2023group8/pull/294) | 3hr | 1.5hr
Mobile - Combine Components Finalize Profile View | [#272](https://github.com/bounswe/bounswe2023group8/issues/272) | Ömer | 231.10.2023 | [#299](https://github.com/bounswe/bounswe2023group8/pull/299) | 1hr | 2hr
Mobile - Following Pop Up | [#273](https://github.com/bounswe/bounswe2023group8/issues/273) | Meriç | 31.10.2023 | [#293](https://github.com/bounswe/bounswe2023group8/pull/293) | 3hr | 2hr
Create Mock Data for Posts | [#264](https://github.com/bounswe/bounswe2023group8/issues/264) | Furkan | 31.10.2023 | [#289](https://github.com/bounswe/bounswe2023group8/pull/289) | 1hr | 0.5hr
Web - Integrate Oauth Pages with Related Endpoints | [#265](https://github.com/bounswe/bounswe2023group8/issues/265) | Bahri, Egemen, Baki | 31.10.2023 | [#283](https://github.com/bounswe/bounswe2023group8/pull/283), [#297](https://github.com/bounswe/bounswe2023group8/pull/297) | 3hr | 2hr
Web - Dockerize | [#261](https://github.com/bounswe/bounswe2023group8/issues/261) | Egemen | 31.10.2023 | [#301](https://github.com/bounswe/bounswe2023group8/pull/301) | 2hr | 30min
Web - Wrappers | [#274](https://github.com/bounswe/bounswe2023group8/issues/274) | Egemen | 31.10.2023 | [#278](https://github.com/bounswe/bounswe2023group8/pull/278) | 2hr | 4hr
Web - Profile View | [#271](https://github.com/bounswe/bounswe2023group8/issues/271) | Egemen, Sude | 31.10.2023 | [#284](https://github.com/bounswe/bounswe2023group8/pull/284), [#291](https://github.com/bounswe/bounswe2023group8/pull/291), [#308](https://github.com/bounswe/bounswe2023group8/pull/308) | 7hr | 4hr
Improve the branch policy | [#213](https://github.com/bounswe/bounswe2023group8/issues/213) | Meriç | 3.11.2023 | [Branching Model](https://github.com/bounswe/bounswe2023group8/wiki/Branching-Model) | 2hr | 6hr

## Completed tasks that were not planned for the week

| Description | Issue | Assignee | Due | Artifact |
| --- | --- | --- | --- | --- |
| Web - Follower/Following Pop Up | [#282](https://github.com/bounswe/bounswe2023group8/issues/282) | Miraç | 31.10.2023 | [#308](https://github.com/bounswe/bounswe2023group8/pull/308) |
| Backend: Email Verification for User Registration | [#280](https://github.com/bounswe/bounswe2023group8/issues/280) | Baki | 31.10.2023 | [#285](https://github.com/bounswe/bounswe2023group8/pull/285) |
| Backend - Implementation of /auth/reset-password Endpoint for Password Renewal | [#288](https://github.com/bounswe/bounswe2023group8/issues/288) | Baki | 31.10.2023 | [#285](https://github.com/bounswe/bounswe2023group8/pull/285) |
| Create Milestone-1 | [#286](https://github.com/bounswe/bounswe2023group8/issues/286) | Baki | 31.10.2023 | [Milestone - 1](https://github.com/bounswe/bounswe2023group8/milestone/5) |
| Integrate parts of the application and deploy all | [#301](https://github.com/bounswe/bounswe2023group8/issues/301) | Baki, Egemen | 31.10.2023 | http://bunchup.com.tr/ |
| add assetlinks.json file and configure web server to serve it | [#302](https://github.com/bounswe/bounswe2023group8/issues/302) | Baki | 31.10.2023 | http://www.bunchup.com.tr/.well-known/assetlinks.json  |
| Create new release | [#307](https://github.com/bounswe/bounswe2023group8/issues/307)| Baki, Egemen | 31.10.2023 | [Alpha Release](https://github.com/bounswe/bounswe2023group8/releases/tag/customer-milestone-1) |
| Update Communication Plan | [#310](https://github.com/bounswe/bounswe2023group8/issues/310) | Baki | 31.10.2023 | [Communication Plan](https://github.com/bounswe/bounswe2023group8/wiki/Communication-Plan) |
| Create Individual Contribution Report | [#315](https://github.com/bounswe/bounswe2023group8/issues/315) | Baki | 31.10.2023 | [Report](https://github.com/bounswe/bounswe2023group8/wiki/Hasan-Baki-K%C3%BC%C3%A7%C3%BCk%C3%A7ak%C4%B1ro%C4%9Flu-%E2%80%90-Milestone-1) |
| Create Customer Milestone Report 1 | [#322](https://github.com/bounswe/bounswe2023group8/issues/322) | Baki | 31.10.2023 | [Deliverables](https://github.com/bounswe/bounswe2023group8/wiki/Customer-Milestone-1-Deliverables) |
| Adding Technologies to Be Used for Mobile | [#316](https://github.com/bounswe/bounswe2023group8/issues/316) | Meriç | 03.11.2023 | [Technologies](https://github.com/bounswe/bounswe2023group8/wiki/Technologies-to-be-Used) |
| Adding Summary of the Project Status to Milestone Review | [#319](https://github.com/bounswe/bounswe2023group8/issues/319) | Meriç | 03.11.2023 | [Milestone Review](https://github.com/bounswe/bounswe2023group8/wiki/Milestone-Review)|
| Add Unit Tests For The Auth Endpoints | [#304](https://github.com/bounswe/bounswe2023group8/issues/304) | Bahadır | 31.10.2023 | [#305](https://github.com/bounswe/bounswe2023group8/pull/305) |
| Fixing Project Plan | [#309](https://github.com/bounswe/bounswe2023group8/issues/309) | Egemen | 03.11.2023 | [Project Plan](https://github.com/bounswe/bounswe2023group8/wiki/Project-Plan) |
| Add list and status of deliverables | [#329](https://github.com/bounswe/bounswe2023group8/issues/329) | Egemen | 03.11.2023 | [Milestone Review](https://github.com/bounswe/bounswe2023group8/wiki/Milestone-Review) |
| Creating Individual Contributions Page and Editing Sidebar | [#312](https://github.com/bounswe/bounswe2023group8/issues/312) | Begüm | 03.11.2023 | - - - |
| Create Individual Contribution Report | [#313](https://github.com/bounswe/bounswe2023group8/issues/313) | Meriç | 03.11.2023 | [Report](https://github.com/bounswe/bounswe2023group8/wiki/Meri%C3%A7-Keskin-Individual-Contribution-Report-for-Milestone-1) |
| Create Individual Contribution Report | [#314](https://github.com/bounswe/bounswe2023group8/issues/314) | Miraç | 03.11.2023 | [Report](https://github.com/bounswe/bounswe2023group8/wiki/Mira%C3%A7-%C3%96zt%C3%BCrk-Individual-Report-for-Customer-Milestone-1-Deliverables) |
| Create Individual Contribution Report | [#328](https://github.com/bounswe/bounswe2023group8/issues/328) | Egemen | 03.11.2023 | [Report](https://github.com/bounswe/bounswe2023group8/wiki/Egemen-Kaplan-%E2%80%90-Milestone-1-Individual-Contributions-Report) |
| Create Individual Contribution Report | [#327](https://github.com/bounswe/bounswe2023group8/issues/327) | Ömer | 03.11.2023 | [Report](https://github.com/bounswe/bounswe2023group8/wiki/Ömer-Faruk-Çelik-%E2%80%90-Milestone-1-Individual-Contributions-Report) |
| Create Individual Contribution Report | [#326](https://github.com/bounswe/bounswe2023group8/issues/326) | Sude | 03.11.2023 | [Report](https://github.com/bounswe/bounswe2023group8/wiki/Sude-Konyalıoğlu-%E2%80%90-Milestone-1-Individual-Contributions-Report) |
| Create Individual Contribution Report | [#324](https://github.com/bounswe/bounswe2023group8/issues/324) | Furkan | 03.11.2023 | [Report](https://github.com/bounswe/bounswe2023group8/wiki/İbrahim-Furkan-Özçelik-%E2%80%90-Milestone-1-Individual-Contributions-Report) |
| Create Individual Contribution Report | [#317](https://github.com/bounswe/bounswe2023group8/issues/317) | Enes | 03.11.2023 | [Report](https://github.com/bounswe/bounswe2023group8/wiki/Enes-Yıldız-%E2%80%90-Milestone-1) |
| Create Individual Contribution Report | [#331](https://github.com/bounswe/bounswe2023group8/issues/331) | Bahri | 03.11.2023 | [Report](https://github.com/bounswe/bounswe2023group8/wiki/Bahri-Alabey-%E2%80%90-Milestone-1) |
| Create Individual Contribution Report | [#332](https://github.com/bounswe/bounswe2023group8/issues/332) | Bahadır Gezer | 03.11.2023 | [Report](https://github.com/bounswe/bounswe2023group8/wiki/Bahad%C4%B1r-Gezer-%E2%80%90-Milestone-1) |
| Mobile - Integrating Authentication Endpoints | [#292](https://github.com/bounswe/bounswe2023group8/issues/292) | Ömer | 31.10.2023 | [#300](https://github.com/bounswe/bounswe2023group8/pull/300) |
| The requirements addressed in this milestone. | [#321](https://github.com/bounswe/bounswe2023group8/issues/321) | Enes | 3.11.2023 | [Milestone Review](https://github.com/bounswe/bounswe2023group8/wiki/Milestone-Review) |
| Create Responsibility Assignment Matrix | [#318](https://github.com/bounswe/bounswe2023group8/issues/318) | Furkan | 3.11.2023 | [RAM](https://github.com/bounswe/bounswe2023group8/wiki/RAM(Responsibility-Assigment-Matrix)) |
| Create APK | [#306](https://github.com/bounswe/bounswe2023group8/issues/306) | Furkan | 3.11.2023 | [Release](https://github.com/bounswe/bounswe2023group8/releases/tag/customer-milestone-1) |

## Planned vs. Actual

## Your plans for the next week

| Description | Issue | Assignee | Due | Estimated Duration |
| --- | --- | --- | --- | --- |
| Backend - Tag Options API | [#352](https://github.com/bounswe/bounswe2023group8/issues/352) | Baki | 14.11.2023 | 3hr |
| Backend - Create Post CRUD APIs | [#334](https://github.com/bounswe/bounswe2023group8/issues/334) | Bahadır | 14.11.2023 | 3hr |
| Backend - Create Interest Area CRUD APIs | [#335](https://github.com/bounswe/bounswe2023group8/issues/335) | Baki | 14.11.2023 | 3hr |
| Backend - Tag Options API | [#352](https://github.com/bounswe/bounswe2023group8/issues/352) | Baki | 14.11.2023 | 4hr |
| Mobile - Visitor Bottom Bar | [#344](https://github.com/bounswe/bounswe2023group8/issues/344) | Ömer | 14.11.2023 | 1hr |
| Mobile - Member Home Page | [#345](https://github.com/bounswe/bounswe2023group8/issues/345) | Furkan | 14.11.2023 | 4hr |
| Mobile - Visitor Explore Page | [#346](https://github.com/bounswe/bounswe2023group8/issues/346) | Begüm | 14.11.2023 | 4hr |
| Mobile - Create Post Page | [#348](https://github.com/bounswe/bounswe2023group8/issues/348) | Furkan | 14.11.2023 | 4hr |
| Mobile - Edit Post Page | [#349](https://github.com/bounswe/bounswe2023group8/issues/349) | Enes | 14.11.2023 | 4hr |
| Mobile - Post Details | [#351](https://github.com/bounswe/bounswe2023group8/issues/351) | Meriç | 14.11.2023 | 4hr |
| Mobile - Member Post Page | [#353](https://github.com/bounswe/bounswe2023group8/issues/353) | Ömer | 14.11.2023 | 3hr |
| Mobile - Visitor Post Page | [#354](https://github.com/bounswe/bounswe2023group8/issues/354) | Ömer | 14.11.2023 | 3hr |
| Web - Create Post View | [#338](https://github.com/bounswe/bounswe2023group8/issues/338) | Bahri | 14.11.2023 | 3hr |
| Web - Detailed Post View | [#339](https://github.com/bounswe/bounswe2023group8/issues/339) | Sude | 14.11.2023 | 3hr |
| Web - Update Post View | [#343](https://github.com/bounswe/bounswe2023group8/issues/343) | Egemen | 14.11.2023 | 2hr |
| Web - Geolocation View | [#347](https://github.com/bounswe/bounswe2023group8/issues/347) | Egemen | 14.11.2023 | 2hr |
| Web - Timeline View | [#340](https://github.com/bounswe/bounswe2023group8/issues/340) | Miraç | 14.11.2023 | 1hr |
| Add Geolocation UI to Mockups | [#350](https://github.com/bounswe/bounswe2023group8/issues/350)| Sude | 11.11.2023 | 2hr |

## Risks

We did not do much work during the week of milestone 1. This might delay our progress throughout the semester. We might need to increase our weekly work to catch up.

## Participants

| Name | Participation |
| --- | --- |
| Bahadır Gezer | ✅ |
| Hasan Baki Küçükçakıroğlu | ✅ |
| Egemen Kaplan | ✅ |
| İbrahim Furkan Özçelik | ✅ |
| Ömer Faruk Çelik | ✅ |
| Begüm Yivli | ❌ |
| Enes Yıldız | ✅ |
| Sude Konyalıoğlu | ✅ |
| Bahri Alabey | ✅ |
| Miraç Öztürk | ❌ |
| Meriç Keskin | ✅ |
