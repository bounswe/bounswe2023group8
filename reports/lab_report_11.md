# Project Development Weekly Progress Report

**Team Name:** Web Info Aggregator

**Date:** 12.12.2023

## Progress Summary

### **This week**

**On the backend side,**

Reputation system is completed. This system lets users rate other users, give comments on them and gives badges to each according to the votes, and other information about the user. Moderation and reporting system is completed. This system lets the IA moderators ban, unban, warn users, and also includes endpoints for the system administrator dashboard. Plus a small but unfinished business, the user deletion endpoint is also completed. The role and access management issue is not completed as of writing this lab report, just a small part of it is included in another pull request. This issue will be completed by Friday and will encompass the securitization of all the endpoints. Post up/down vote system is completed. Moreover, users now can comment on posts. Most importantly, private interest area owners now can see follow requests and accept/reject them.

**On the Web side**,

We started applying the new design changes to our web app UI. This task ended up being more monumental than it appeared at first. We will need more time to apply all the changes especially after losing another member in the web team. We also started implementing annotations but implementing all the parts of it at the same time did not work. We needed to wait for previous parts to be completed first. 

**On the Mobile side**,

We progressed on implementing the design changes to our mobile project. As our mobile UI is building to completion, we also added geolocation view for the location selection functionality. The geolocation was an important addition as it was already included to the web project.

### **Next week**

**On the Backend,**

We’ve analyzed requirements to see what is missing and listed them as following: 

- Annotations(1.2.1.4 Annotations)
- Change password(1.1.2.3.1 Users shall be able to change passwords…)
- Upload/Delete profile picture(Not in requirements but it is cool to have profile picture.)
- Upload/Delete interest area picture(Not in requirements but customer wanted to see more visual content)
- Age Restricted Content(1.2.5.5 The system shall check the birthday of a user during the access to age-restricted content. This information is immutable after account creation.)

We will complete these this week to give front-end and mobile teams some time flexibility for integrations of APIs. 

**On the Web side,**

We are planning to finish implementing most of the new design changes, annotations, comments under spots, bunch privacy setting and its consequences. We also noticed some missing parts from the previously implemented functions and plan to fix them.

**On the Mobile Side,**

We will complete the designs for our project by finalizing the bunch pages, updating profile pages and implementing the settings pages. Besides, we will implements several functionalities to our project which are sorting and filtering spots, comment CRUDs, voting spots, join request to bunches and accepting requests, and reporting users, spots and bunches. We have 2 weeks until final milestone, so we geared up a bit.

## What was planned for the week? How did it go?

| Description | Issue | Assignee | Due | Artifact | Estimated Duration | Actual Duration |
| --- | --- | --- | --- | --- | --- | --- |
| Backend - Add Role Management for Access Levels | [Issue #373](https://github.com/bounswe/bounswe2023group8/issues/373) | Bahadır | 12.12.2023 | A part of it is in [#556](https://github.com/bounswe/bounswe2023group8/pull/556), however completion is postponed to Friday | 6h | 1h (not finished) |
| Backend - User Account Deletion | [Issue #515](https://github.com/bounswe/bounswe2023group8/issues/515) | Bahadır | 12.12.2023 | [PR #558](https://github.com/bounswe/bounswe2023group8/pull/558) | 3h | 2.5h |
| Backend - Add The Reputation System | [Issue #516](https://github.com/bounswe/bounswe2023group8/issues/516) | Bahadır | 12.12.2023 | [PR #557](https://github.com/bounswe/bounswe2023group8/pull/557) | 8h | 2.5h |
| Backend - Implement Reporting and Moderation Core Function - Moderation Dashboard | [Issue #526](https://github.com/bounswe/bounswe2023group8/issues/526) | Bahadır | 12.12.2023 | [PR #556](https://github.com/bounswe/bounswe2023group8/pull/556) | 12h | 3h |
| Backend - Create Comment Model and CRUD APIs | [Issue #337](https://github.com/bounswe/bounswe2023group8/issues/337) | Baki | 12.12.2023 | [PR #545](https://github.com/bounswe/bounswe2023group8/pull/545) | 4hr | 4hr |
| Backend - Down/Upvoting a post. | [Issue #524](https://github.com/bounswe/bounswe2023group8/issues/524) | Baki | 12.12.2023 | [PR #542](https://github.com/bounswe/bounswe2023group8/pull/542) | 4hr | 4hr |
| Backend - List, Accept/Reject Interest Area Join Requests | [Issue #527](https://github.com/bounswe/bounswe2023group8/issues/527) | Baki | 12.12.2023 | [PR #544](https://github.com/bounswe/bounswe2023group8/pull/544) | 5hr | 5hr |
| Add Annotation Mock-ups | [Issue #517](https://github.com/bounswe/bounswe2023group8/issues/517) | Meriç | 11.12.2023 | - | 2hr | In progress |
| Add Edit View Mock-up to Bunch Page | [Issue #521](https://github.com/bounswe/bounswe2023group8/issues/521) | Meriç | 11.12.2023 | - | 2hr | In progress |
| Implementing Home Page Design to Mobile | [Issue #522](https://github.com/bounswe/bounswe2023group8/issues/522) | Meriç | 11.12.2023 | [PR #582](https://github.com/bounswe/bounswe2023group8/pull/582) | 2hr | 3hr |
| Implementing Search Page Design to Mobile | [Issue #523](https://github.com/bounswe/bounswe2023group8/issues/523) | Meriç | 11.12.2023 | - | 2hr | In progress |
| Implementing Explore Page Design to Mobile | [Issue #525](https://github.com/bounswe/bounswe2023group8/issues/525) | Meriç | 11.12.2023 | - | 2hr | In progress |
| Web - Create CSS classNames according to mockups and add common assets/icons from figma | [Issue #529](https://github.com/bounswe/bounswe2023group8/issues/529) | Egemen | 09.12.2023 | [PR #546](https://github.com/bounswe/bounswe2023group8/pull/546) | 2hr | 1hr |
| Web - Compliance to Mockups - View Bunch Page | [Issue #530](https://github.com/bounswe/bounswe2023group8/issues/530) | Bahri | 11.12.2023 | [PR #555](https://github.com/bounswe/bounswe2023group8/pull/555) | 2hr | 4hr |
| Web - Compliance to Mockups - Update/Create Bunch Page | [Issue #532](https://github.com/bounswe/bounswe2023group8/issues/532) | Bahri | 11.12.2023 | [PR #567](https://github.com/bounswe/bounswe2023group8/pull/567) | 2hr | 4hr |
| Web - Compliance to Mockups - View Spot Details Page | [Issue #535](https://github.com/bounswe/bounswe2023group8/issues/535) | Miraç | 11.12.2023 | - | 2hr | - |
| Web - Compliance to Mockups - Update/Create Spot Page | [Issue #539](https://github.com/bounswe/bounswe2023group8/issues/539) | Miraç | 11.12.2023 | - | 2hr | - |
| Web - Compliance to Mockups - Small Spot Card Preview | [Issue #540](https://github.com/bounswe/bounswe2023group8/issues/540) | Egemen | 11.12.2023 | [PR #554](https://github.com/bounswe/bounswe2023group8/pull/554) | 2hr | 3hr |
| Web - Compliance to Mockups - Topbar/Sidebar | [Issue #538](https://github.com/bounswe/bounswe2023group8/issues/538) | Furkan | 11.12.2023 | [Issue #538](https://github.com/bounswe/bounswe2023group8/issues/538) | 2hr | 1hr |
| Web - Compliance to Mockups - Auth Modals | [Issue #537](https://github.com/bounswe/bounswe2023group8/issues/537) | Furkan | 11.12.2023 | [Issue #537](https://github.com/bounswe/bounswe2023group8/issues/537) | 2hr | Not finished |
| Web - Compliance to Mockups - Profile Page | [Issue #536](https://github.com/bounswe/bounswe2023group8/issues/536) | Sude | 11.12.2023 | [Issue #536](https://github.com/bounswe/bounswe2023group8/issues/536) | 2hr | 2hr |
| Web - Compliance to Mockups - Timeline Page | [Issue #534](https://github.com/bounswe/bounswe2023group8/issues/534) | Sude | 11.12.2023 | [Issue #534](https://github.com/bounswe/bounswe2023group8/issues/534) | 2hr | 1hr (not finished) |
| Web - Annotations - Annotation display on Spot body and search | [Issue #533](https://github.com/bounswe/bounswe2023group8/issues/533) | Furkan | 11.12.2023 | [Issue #533](https://github.com/bounswe/bounswe2023group8/issues/533) | 4hr | 5hr |
| Web - Annotations - Sidebar view | [Issue #531](https://github.com/bounswe/bounswe2023group8/issues/531) | Bahri | 11.12.2023 | - | 4hr | Incomplete |
| Web - Annotations - Create Annotation | [Issue #528](https://github.com/bounswe/bounswe2023group8/issues/528) | Egemen | 11.12.2023 | - | 4hr | Incomplete |
| Mobile - Modify Create Bunch View | [Issue #520](https://github.com/bounswe/bounswe2023group8/issues/520) | Ömer | 11.12.2023 | [PR #549](https://github.com/bounswe/bounswe2023group8/pull/549) | 2hr | 2hr |
| Mobile - Modify Spot Details View | [Issue #519](https://github.com/bounswe/bounswe2023group8/issues/519) | Ömer | 11.12.2023 | [PR #553](https://github.com/bounswe/bounswe2023group8/pull/553) | 2hr | 3hr |
| Mobile - Updating Bunch Member | [Issue #470](https://github.com/bounswe/bounswe2023group8/issues/470) | Begüm | 11.12.2023 | [PR #559](https://github.com/bounswe/bounswe2023group8/pull/559) | 3hr | 4 hr |
| Mobile - Geolocation support when creating a post | [Issue #423](https://github.com/bounswe/bounswe2023group8/issues/423) | Ömer | 11.12.2023 | [PR #548](https://github.com/bounswe/bounswe2023group8/pull/548) | 4hr | 3hr |
## Completed tasks that were not planned for the week

| Description | Issue | Assignee | Due | Artifact | Actual Duration |
| --- | --- | --- | --- | --- | --- |
| Web - Update CSS for mockups | [Issue #550](https://github.com/bounswe/bounswe2023group8/issues/550) | Bahri | 10.12.2023 | [PR #551](https://github.com/bounswe/bounswe2023group8/pull/551) | 1hr |
| Mobile - Updating Spot Card | [Issue #584](https://github.com/bounswe/bounswe2023group8/issues/584) | Meriç | 12.12.2023 | [PR #582](https://github.com/bounswe/bounswe2023group8/pull/582) | 3hr |
| Updating Spot Detail, Create Spot and Edit Spot Mock-ups for Mobile | [Issue #572](https://github.com/bounswe/bounswe2023group8/issues/572) | Meriç | 12.12.2023 | - | 2hr |

## Planned vs. Actual

On the backend, user access levels and app security were planned, however, it is not finished. This issue will encompass the security from access levels and roles of all endpoints to ensure proper endpoint usage. It will be finished after a discussion with the front team to understand the current usage of the API and will be secured accordingly to not break the app. Other than that, we completed all issues which have a deadline for this week.

On the web side, we were supposed to be done with annotation UI this week but it didn’t happen. Our only saving grace is that remaining unimplemented features are single pages with not much difficulty to implement.

On the mobile, we planned to finalize our designs other than settings and annotation, but we did not achieve that goal. We implemented our designs as much as possible, but there are parts that are in progress and delayed to next week.

## Your plans for the next week

| Description | Issue | Assignee | Due | Estimated Duration |
| --- | --- | --- | --- | --- |
| Mobile - Settings Page | [Issue #561](https://github.com/bounswe/bounswe2023group8/issues/561) | Begüm | 18.12.2023 | 4 hr |
| Backend - Upload/Delete profile picture API | [Issue #562](https://github.com/bounswe/bounswe2023group8/issues/562) | Baki | 18.12.2023 | 3hr |
| Backend - Restrict Posts by Age | [Issue #564](https://github.com/bounswe/bounswe2023group8/issues/564) | Baki | 18.12.2023 | 3hr  |
| Backend - Upload/Delete interest area picture API | [Issue #573](https://github.com/bounswe/bounswe2023group8/issues/573) | Baki | 18.12.2023 | 3hr |
| Backend - Annotations | [Issue #566](https://github.com/bounswe/bounswe2023group8/issues/566) | Bahadır | 18.12.2023 |  |
| Backend - Add *And Implement* Role Management for Access Levels (Postponed to next week's report)  | [Issue #373](https://github.com/bounswe/bounswe2023group8/issues/373) | Bahadır | 15.12.2023 | 6h |
| Backend - Change Password API | [Issue #560](https://github.com/bounswe/bounswe2023group8/issues/560) | Bahadır | 18.12.2023 |  |
| Mobile - Reporting | [Issue #570](https://github.com/bounswe/bounswe2023group8/issues/570) | Ömer | 18.12.2023 | 2hr |
| Mobile - Bunch Authorization Requests | [Issue #569](https://github.com/bounswe/bounswe2023group8/issues/569) | Ömer | 18.12.2023 | 2hr |
| Mobile - Comments CRUD Endpoints & Functionality Integration | [Issue #568](https://github.com/bounswe/bounswe2023group8/issues/568) | Ömer | 18.12.2023 | 3hr |
| Mobile - Upvote Downvote Post | [Issue #563](https://github.com/bounswe/bounswe2023group8/issues/563) | Ömer | 18.12.2023 | 2hr |
| Web - Annotations - Sidebar view | [Issue #531](https://github.com/bounswe/bounswe2023group8/issues/531) | Furkan | 15.12.2023 | 4hr |
| Web - Compliance to Mockups - View Spot Details Page | [Issue #535](https://github.com/bounswe/bounswe2023group8/issues/535) | Egemen | 16.12.2023 | 2hr |
| Web - Compliance to Mockups - Update/Create Spot Page | [Issue #539](https://github.com/bounswe/bounswe2023group8/issues/539) | Egemen | 16.12.2023 | 2hr |
| Web - Spots Comment UI  | [Issue #580](https://github.com/bounswe/bounswe2023group8/issues/580) | Egemen | 18.12 2023 | 3hr |
| Web - Comment CRUD | [Issue #581](https://github.com/bounswe/bounswe2023group8/issues/581) | Egemen | 18.12.2023 | 3hr |
| Web - Fix signup flow after changes to backend | [Issue #586](https://github.com/bounswe/bounswe2023group8/issues/586) | Sude | 18.12.2023 | 1hr |
| Web - Fix follower/followings of user in profile | [Issue #579](https://github.com/bounswe/bounswe2023group8/issues/579) | Sude | 18.12.2023 | 2hr |
| Web - Compliance to Mockups - Timeline Page | [Issue #534](https://github.com/bounswe/bounswe2023group8/issues/534) | Sude | 18.12.2023 | 2hr |
| Web - Bunch view request | [Issue #578](https://github.com/bounswe/bounswe2023group8/issues/578) | Bahri | 16.12.2023 | 2hr |
| Web - Add report functionality to bunches | [Issue #577](https://github.com/bounswe/bounswe2023group8/issues/577) | Bahri | 16.12.2023 | 3hr |
| Web - Update Bunches add privacy levels | [Issue #576](https://github.com/bounswe/bounswe2023group8/issues/576) | Bahri | 16.12.2023 | 3hr |
| Web - Add custom anchor tags | [Issue #574](https://github.com/bounswe/bounswe2023group8/issues/574) | Bahri | 16.12.2023 | 1hr |
| Complete annotation logic on Spots | [Issue #575](https://github.com/bounswe/bounswe2023group8/issues/575) | Furkan | 16.12.2023 | 2hr |
| Web - Annotations - Create Annotation | [Issue #528](https://github.com/bounswe/bounswe2023group8/issues/528) | Furkan | 16.12.2023 | 2hr |
| Web - Annotations - Sidebar view | [Issue #531](https://github.com/bounswe/bounswe2023group8/issues/531) | Furkan | 16.12.2023 | 2hr |
| Add Annotation Mock-ups | [Issue #517](https://github.com/bounswe/bounswe2023group8/issues/517) | Meriç | 16.12.2023 | 3hr |
| Add Edit View Mock-up to Bunch Page | [Issue #521](https://github.com/bounswe/bounswe2023group8/issues/521) | Meriç | 16.12.2023 | 1hr |
| Implementing Home Page Design to Mobile | [Issue #522](https://github.com/bounswe/bounswe2023group8/issues/522) | Meriç | 19.12.2023 | 2hr |
| Implementing Search Page Design to Mobile | [Issue #523](https://github.com/bounswe/bounswe2023group8/issues/523) | Meriç | 19.12.2023 | 2hr |
| Implementing Explore Page Design to Mobile | [Issue #525](https://github.com/bounswe/bounswe2023group8/issues/525) | Meriç | 19.12.2023 | 2hr |
| Mobile - Sort and Filter Functionalities for Spots | [Issue #583](https://github.com/bounswe/bounswe2023group8/issues/583) | Meriç | 19.12.2023 | 3hr |
| Updating Spot Detail, Create Spot and Edit Spot Mock-ups for Web | [Issue #585](https://github.com/bounswe/bounswe2023group8/issues/585) | Meriç | 16.12.2023 | 2hr |

## Risks

Applying design changes and new features at the same time carries the risk of not completing the app before our final milestone.

## Participants


Name | Participation
-- | --
Bahadır Gezer | ✅
Hasan Baki Küçükçakıroğlu | ✅
Egemen Kaplan | ✅
İbrahim Furkan Özçelik | ✅
Ömer Faruk Çelik | ✅
Begüm Yivli | ✅
Enes Yıldız | ❌
Sude Konyalıoğlu | ✅
Bahri Alabey | ✅
Miraç Öztürk | ❌
Meriç Keskin | ✅
