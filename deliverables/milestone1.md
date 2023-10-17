
##  Deliverables

<details><summary><h3>Software Requirement Specification</h3></summary>

You can see our requirement specifications below.

***

## Glossary
   * IA: Interest Area
   * API: Application Programming Interface
   * GDPR: General Data Protection Regulation
   * KVKK: Turkish Personal Data Protection Law
   * W3C: World Wide Web Consortium

### Visitor Types
   * **Guest**: Visitors without a verified account. They can only explore public IAs on the platform.
   * **Registered User**: Visitors with verified accounts. They will be referred to as "Users" throughout this document.
   * **System Administrator**: Site administrative users which have access to administrative dashboard. 

### Content Types
   * **Post**: Main entities that users create when they want to save links. 
   * **Interest Area(IA)**: Main container of posts on the platform. Users create IAs in order to categorize their posts and share them with other users on the platform should they desire.

You can find more details about these under item "1.2.1 Content"


## 1. Functional Requirements
   <details open ><summary><h3>1.1 User Requirements</h3></summary>

   * <h4>1.1.1 Registration and Login </h4>

      * 1.1.1.1 Guests : 
         * 1.1.1.1.1 Shall be able to register using an email and password.
         * 1.1.1.1.2 Should be able to register using a social media account.
      * 1.1.1.2 Users shall be able to:
         * 1.1.1.2.1 Login. 
         * 1.1.1.2.2 Logout.
         * 1.1.1.2.3 Reset their passwords.

   * <h4>1.1.2 Account</h4>

      * 1.1.2.1 Guests shall verify their account via email before they can be considered as users.
      * 1.1.2.2 Users shall be able to delete their accounts.
      * 1.1.2.3 Users shall be able to update some of the account information.
         * 1.1.2.3.1 Users shall be able to change passwords, phone numbers and email addresses.
         * 1.1.2.3.2 Users shall not be able to change their username and birthday.
      * 1.1.2.4 Users should be able to link their accounts to social media profiles.
      * 1.1.2.5 Users shall have control over their own privacy settings such that profiles, posts and IAs may have public, private and invite-only options.
    
   * <h4>1.1.3 User-to-User Interactions</h4>

      Users shall be able to:
      * 1.1.3.1 View other users profiles' and see their publicly viewable data such as their public posts(posts they created in public IAs), names of their public and invite-only IAs, users that they follow and tags that they are interested in.
      * 1.1.3.2 Follow other users on the platform.
      * 1.1.3.3 Vote on other users based on their merits. (See "1.2.3.2 Reputation system")

   * <h4>1.1.4 User-to-Platform Interactions</h4>

      Users shall be able to interact with the platform via:

      * 1.1.4.1 Posts: (See "1.2.1.1 Posts")
         * 1.1.4.1.1 Creating a post by providing a title, a main link that this post refers to, a description, tags defined by [Wikidata](https://www.wikidata.org/), original source of the provided link, publication date, geolocation of the subject in accordance with [W3C Recommendation standards](https://www.w3.org/TR/geolocation/), fact-checking status, and purpose of the post.
         * 1.1.4.1.2 Editing fields of a post.
         * 1.1.4.1.3 Commenting on a post.
         * 1.1.4.1.4 Down/Upvoting a post.
         * 1.1.4.1.5 Reporting inappropriate posts to IA moderators. (See "1.1.4.2.8" for more info in Moderators)
         * 1.1.4.1.6 Annotating their own posts in order to give more detailed information about certain parts of these posts (See "1.2.1.4 Annotations")
         * 1.1.4.1.7 Suggesting additional tags to posts created by other users.

      * 1.1.4.2 Interest Areas: (See "1.2.1.2 Interest Areas")
         * 1.1.4.2.1 Creating an interest area by providing a title, tags defined by [Wikidata](https://www.wikidata.org/) to describe the focus of the IA, the IA's access levels (See item "1.2.1.2.5" about access levels), and the set of IAs that the new IA will consist of in case the new IA is a collection of other IAs.
         * 1.1.4.2.2 Editing fields of interest area.
         * 1.1.4.2.3 Following interest areas.
         * 1.1.4.2.4 Joining invite-only interest areas. (See item "1.2.1.2.5" about access levels)
            * Users shall be able to request to join an invite-only interest area.
         * 1.1.4.2.5 Creating posts in interest areas. 
         * 1.1.4.2.6 Suggesting additional tags to IAs created by other users.
         * 1.1.4.2.7 Following interest areas.
         * 1.1.4.2.8 Reporting inappropriate IAs to System Administrators.
         * 1.1.4.2.9 Managing roles of other users in their own interest areas. Every role in the role hierarchy below shall have the permissions of all the roles below itself:
            * Owner: Only the owner of the IA shall have this role. Only an owner shall be able to manage roles of other users within that IA.
            * Moderator: Moderators shall moderate the content and the behavior of the users within an IA. They shall have access to the moderator dashboard which grants certain abilities within that particular IA, explained more in detail under item "1.2.4.1"
            * Creator: Creators in an IA shall be able to create new posts within that IA.
            * Consumer: Consumers in an IA shall be able to interact with the posts or the IA in every way possible explained under items "1.1.4.1" and "1.1.4.2" except creating new posts.

      
   </details>
   <details open ><summary><h3>1.2 System Requirements</h3></summary>

   * <h4>1.2.1 Content</h4>

     System shall have a certain structure of content and content containers as follows:
     * 1.2.1.1 Post
        * 1.2.1.1.1 Shall have a title
        * 1.2.1.1.2 Shall have a main body that consists of only a main non-empty link, that is the target of the post in question, and an optional text for the creator to comment on this target link or describe it.      
        * 1.2.1.1.3 Shall contain required relevant metadata: 
           * At least one semantic label(tag) that utilizes the man tagging system on the platform, which uses [Wikidata](https://www.wikidata.org/) knowledge base (See "1.2.3.1 Tags")  
           * Source - Which source of media does this link originate from?
           * Creator - Either a person(author, photographer etc.) or an entity in accordance with the utilized tagging system.
        * 1.2.1.1.4 Shall contain optional relevant metadata:
           * Geolocation of the subject of the link, which follows the [W3C Recommendation standards](https://www.w3.org/TR/geolocation/).
           * Creation and publication dates
           * Fact-checking status 
        * 1.2.1.1.5 Shall have comments, upvotes, and downvotes.
        * 1.2.1.1.6 Shall specify actions (e.g., documentation, learning, research, news) tied to its purpose.

     * 1.2.1.2 Interest Areas (IA):
        * 1.2.1.2.1 Shall consist of posts created by their users or posts created within their nested IAs.
        * 1.2.1.2.2 Shall be able to consist of a collection of other IAs.(nested)
        * 1.2.1.2.3 Shall obtain at least one semantic label(tag) during their creation. IA tags only show the topic scope of an IA and shall utilize the main tagging system on the platform, which uses [Wikidata](https://www.wikidata.org/) knowledge base (See "1.2.3.1 Tags")
            * Users shall be able to alter the tags of an IA later.
        * 1.2.1.2.4 Shall have a "Recommended IAs" section where it lists other IAs that might interest the user based on their tags.
        * 1.2.1.2.5 Offers various access levels:
            * Public: IAs that are open to anyone that visits the platform, guests and users alike.
            * Private: IAs that are only accessible by their owners.
            * Invite-only: IAs that are fully accessible only to the users who have been invited by the IA's owners. 
               * Content of these IAs shall be invisible to the outsiders. 
               * These IAs shall still be discoverable by outsider users either through a search on the platform(based on tags or title search) or through recommendations made by the system under other IAs. 
               * Outsider users shall be able to send request to have full access to these IAs.  

     * 1.2.1.3 Home Page for each user: 
        Each Home Page shall be personalized for its user and shall achieve this by:
        * 1.2.1.3.1 Displaying recent posts from followed interest areas and users.
        * 1.2.1.3.2 Suggesting new posts and interest areas that are relevant to its user based on the users interests. This system shall use the main tagging system to make the semantic connections between the users interests and the suggestions(See "1.2.3.1 Tags") 

     * 1.2.1.4 Annotations</h4>

        * 1.2.1.4.1 Annotations shall have the [W3C Web Annotation Data Model](https://www.w3.org/TR/annotation-model/).
        * 1.2.1.4.2 Annotations shall appear in form of a highlight made on the annotated text without displaying any extra content.
        * 1.2.1.4.3 Annotations shall display a pop-up over the highlighted areas upon user interaction and only then provide its contents within this pop-up.
   
  * <h4>1.2.2 Search and Filtering</h4>

     * 1.2.2.1 The system shall allow users to search for posts, users, and IAs based on semantic labels, metadata, and interest areas.
     * 1.2.2.2 The system shall enable post filtering by interest areas, date, location, and other metadata.
     * 1.2.2.3 The system shall be able to sort search results by relevance, date, and popularity.

   * <h4>1.2.3 Labeling</h4>

     * 1.2.3.1 Tags 
        * 1.2.3.1.1 The system shall utilize [Wikidata](https://www.wikidata.org/) API, in order to implement a semantic labeling mechanism on the platform and this mechanism shall appear in form of tags under each post or IA.
        * 1.2.3.1.2 Upon user interaction, each tag shall be able to display more tags, to which it is semantically related.
        * 1.2.3.1.3 The system shall facilitate post and IA searching based on these tags
        * 1.2.3.1.5 Tags shall allow users to find interest areas, users, and posts related to themselves.

     * 1.2.3.2 Reputation system:
        * 1.2.3.2.1 The system shall allow users to vote on other users based on their qualities and it shall keep record of these votes.
        * 1.2.3.2.2 Votes shall represent either positive or negative side of a quality of the user.
        * 1.2.3.2.3 The system shall assign badges to users depending on how many positive and negative votes they received on a certain quality.
          * A user might be good at fact-checking and receive many positive fact-checker votes from other users. Conversely, a user might do false fact-checks constantly and receive negative fact-checker votes from other users. When the user accumulates enough net positive or negative votes as a fact-checker, the system shall assign them with the badge that represents this good or bad quality.


   * <h4>1.2.4 Reporting and Moderation</h4>
       
     The system shall have two distinct dashboards to review reported content and users.
     * 1.2.4.1 Moderative Dashboard available to IA moderators shall grant abilities for:
        * 1.2.4.1.1 Removing inappropriate posts from the IA temporarily or permanently.
        * 1.2.4.1.2 Warning users that create such inappropriate posts or misbehave under comment sections.
        * 1.2.4.1.3 Banning users from the IA temporarily or permanently.
        * 1.2.4.1.4 Reporting issues to System Administrators in case these issues require actions outside the scope of the Moderative Dashboard.

     * 1.2.4.2 Administrative Dashboard available to System Administrators shall grant abilities for: 
        * 1.2.4.2.1 Removing inappropriate posts or IAs from the platform temporarily or permanently.
        * 1.2.4.2.2 Warning users that create such inappropriate posts or misbehave under comment sections.
        * 1.2.4.2.3 Banning users from the platform temporarily or permanently.
         
   * <h4>1.2.5 Account Management</h4>

      * 1.2.5.1 When a user's account is deleted, all account information including the username, password, phone number and email address shall be deleted from the database.
      * 1.2.5.2 All private IAs created by deleted account shall be deleted along with the posts created in them.
      * 1.2.5.3 Public posts, comments, invite-only IAs, and public IAs created by deleted account shall remain visible on the platform.
      * 1.2.5.4 The system shall not allow creating more than one account with the same email address. The attempt to do so shall prompt a warning.
      * 1.2.5.5 The system shall check the birth day of a user during the access to age-restricted content. This information is immutable after account creation.
      * 1.2.5.6 The system shall log all user authentication attempts and notify users of suspicious login attempts or activity.

   </details>

## 2. Non-Functional Requirements

   * <h4>2.1 Platforms</h4>

      * 2.1.1 Application shall be available for Web and Android platforms.
      * 2.1.2 The web version of the application shall be compatible with commonly used web browsers, including Google Chrome, Mozilla Firefox, and Safari.
      * 2.1.3 The Android version of the application shall be compatible with Android 5.0 and higher.

   * <h4>2.2 Supported Languages</h4>

      * 2.2.1 Application shall support English and Turkish languages.
      * 2.2.2 The application shall provide a language switch option in the user interface, allowing users to switch between supported languages.

   * <h4>2.3 Security</h4>

      * 2.3.1 User authorization information shall be encrypted.
      * 2.3.2 The application shall implement strong password requirements and provide guidance to users on creating secure passwords.

   * <h4>2.4 Privacy and Ethical Considerations</h4>

      * 2.4.1 The platform shall protect personal information and contact information, adherence to copyrights, and licensing considerations; according to [GDPR](https://gdpr-info.eu/)/[KVKK](https://www.mevzuat.gov.tr/mevzuat?MevzuatNo=6698&MevzuatTur=1&MevzuatTertip=5) rules.
      * 2.4.2 The application shall have a concrete "Community Guidelines" to bring Users and System Administrators on the same page in terms of appropriate content and behavior allowed on the platform.

   * <h4>2.5 Restricted Content</h4>

      * 2.5.1 Adult content should have age restrictions.
      * 2.5.2 Application shall not contain criminal content and gore.

***

</details>

<details><summary><h3>Mock-ups</h3></summary>

You can see our mock-ups below.

***

<details><summary><h4>Web</h3></summary>

* ### Opening Page
  ![Opening Page](https://user-images.githubusercontent.com/61244299/230888231-1a36a747-f5a8-4375-a028-9b99a9785b36.png)

* ### Opening Page - Log In
  ![Opening Page - Log In](https://user-images.githubusercontent.com/61244299/230888227-599979fc-2322-4267-914e-50cabc49db52.png)

* ### Opening Page - Sign Up
  ![Opening Page - Sign Up](https://user-images.githubusercontent.com/61244299/230889402-97eafc17-f16d-471b-bb04-8500b7860683.png)

* ### Home Page
  ![Home Page](https://user-images.githubusercontent.com/61244299/230888223-2daa09e1-3e30-4291-8d41-3aa3de5d2d8d.png)

* ### Explore Page
  ![Explore Page](https://user-images.githubusercontent.com/61244299/230888221-8e74f0d7-2781-4ade-9753-3022cbe6c8b1.png)

* ### Profile Page 
  ![Profile Page](https://user-images.githubusercontent.com/61244299/230888239-8e101468-e5ef-498c-ba72-839aeaccf879.png)

* ### Profile Page - Followers
  ![Profile Page - Followers](https://user-images.githubusercontent.com/61244299/230888236-83002099-b91a-45e4-8061-b1369ae401a5.png)

* ### Profile Page - Following
  ![Profile Page - Following](https://user-images.githubusercontent.com/61244299/230888238-8e075d18-acb8-4a55-ba4a-b7896b58b6f9.png)

* ### Post - Member
  ![Post - Member](https://user-images.githubusercontent.com/61244299/230888232-25ff8219-1a00-4619-8304-e40a6d195741.png)

* ### Post - Visitor
  ![Post - Visitor](https://user-images.githubusercontent.com/61244299/230888233-aeeefbdd-47b5-4c45-8995-be8a0f312217.png)

* ### Create Post
  ![Create Post](https://user-images.githubusercontent.com/61244299/230888215-73db0ba6-78f6-4aa9-a636-3bba07b9f87d.png)

* ### Edit Post 
  ![Edit Post](https://user-images.githubusercontent.com/61244299/230888846-9be0ebad-98ec-48af-aa84-290339db56a9.png)

* ### Interest Area - Member
  ![Interest Area - Member](https://user-images.githubusercontent.com/61244299/230888225-71653850-8c6b-43f9-bf0b-1b62b18a1d42.png)

* ### Interest Area - Visitor
  ![Interest Area - Visitor](https://user-images.githubusercontent.com/61244299/230888226-408cbecd-9bc4-4a3f-a67a-66860d7251aa.png)

* ### Create Interest Area
  ![Create Interest Area](https://user-images.githubusercontent.com/61244299/230888211-37d7ba2a-a3fa-414b-a0b8-b59f14edb126.png)

* ### Edit Interest Area
  ![Edit Interest Area](https://user-images.githubusercontent.com/61244299/230888217-bb3f15ab-99ac-4e6e-9a11-39f4e4cd5dfd.png)

* ### Search Page - Member
  ![Search Page - Member](https://user-images.githubusercontent.com/61244299/230888241-c4c351ae-bfd9-40db-9493-564861adb900.png)

* ### Search Page - Visitor
  ![Search Page - Visitor](https://user-images.githubusercontent.com/61244299/230888242-f229abe4-29ff-40b4-a682-ea066d1f1e18.png)

* ### Settings Page - Member
  ![Settings Page - Member](https://user-images.githubusercontent.com/61244299/230888243-0d4f7173-a77b-4b56-bcd7-c891f77388a4.png)

* ### Settings Page - Visitor
  ![Settings Page - Visitor](https://user-images.githubusercontent.com/61244299/230888245-9a9b4fec-3198-4c3a-bc7c-ffc9bfd03ce4.png)

</details>

<details><summary><h4>Mobile</h3></summary>

* ### Opening Page
  ![Opening Page](https://user-images.githubusercontent.com/22966868/230892768-cd5e398b-c9b4-48e5-96e3-8a6c8d4271a9.png)

* ### Log In Page
  ![Log In Page](https://user-images.githubusercontent.com/22966868/230892765-3b5e6523-3a30-4036-bc42-11bd0435a988.png)

* ### Sign Up Page
  ![Sign Up Page](https://user-images.githubusercontent.com/22966868/230892795-fbedf18d-9a69-4565-9ccf-c6d982f74aff.png)

* ### Home Page
  ![Home Page](https://user-images.githubusercontent.com/22966868/230892756-9f425931-12fd-45cb-bd7b-e179dfb6fc1b.png)

* ### Explore Page
  ![Explore Page](https://user-images.githubusercontent.com/22966868/230892750-b2facefd-25ae-472d-943d-51532c593762.png)

* ### Profile Page
  ![Profile Page](https://user-images.githubusercontent.com/22966868/230892781-7a2ae882-9412-4f1c-a784-52726e95101f.png)

* ### Profile Page - Followers
  ![Profile Page - Followers](https://user-images.githubusercontent.com/22966868/230892775-d3428f3f-44b2-4079-947b-a8c933743cb4.png)

* ### Profile Page - Following
  ![Profile Page - Following](https://user-images.githubusercontent.com/22966868/230892779-bf06fd79-c3a2-441f-80c7-83ddbf3369c0.png)

* ### Post - Member
  ![Post - Member](https://user-images.githubusercontent.com/22966868/230892770-f77f63b5-eb69-4179-9486-d69ab57eed08.png)

* ### Post - Visitor
  ![Post - Visitor](https://user-images.githubusercontent.com/22966868/230892772-4c2f244c-092a-4b53-a62e-5deb962b0092.png)

* ### Create Post
  ![Create Post](https://user-images.githubusercontent.com/22966868/230892742-781144fb-f9d6-4435-bda6-54e2a0f6f958.png)

* ### Edit Post
  ![Edit Post](https://user-images.githubusercontent.com/22966868/230892748-eee3e0c4-fc11-4e62-8a9d-5bad337cfe5b.png)

* ### Interest Area - Member
  ![Interest Area - Member](https://user-images.githubusercontent.com/22966868/230892760-e7245d53-46ae-4fc7-86b8-4fd9ab08d567.png)

* ### Interest Area - Visitor
  ![Interest Area - Visitor](https://user-images.githubusercontent.com/22966868/230892763-d1b8058f-8b6d-4967-9430-9212fae6a16e.png)

* ### Create Interest Area
  ![Create Interest Area](https://user-images.githubusercontent.com/22966868/230892739-081baa51-6e96-405b-a054-615788b3f17d.png)

* ### Edit Interest Area
  ![Edit Interest Area](https://user-images.githubusercontent.com/22966868/230892744-2de83e3c-93de-4395-8fb4-a562e2cf725a.png)

* ### Search Page - Member
  ![Search Page - Member](https://user-images.githubusercontent.com/22966868/230892784-19fdea78-e2c5-40c2-8662-bce48ee868e7.png)

* ### Search Page - Visitor
  ![Search Page - Visitor](https://user-images.githubusercontent.com/22966868/230892789-a779aee5-b4b3-46cb-8bee-e7bc1054f4d1.png)

* ### Settings - Member
  ![Settings - Member](https://user-images.githubusercontent.com/22966868/230892791-9d6a6004-b7a2-48ca-9e2a-6653a9cd28a9.png)

* ### Settings - Visitor
  ![Settings - Visitor](https://user-images.githubusercontent.com/22966868/230892793-5d907b54-e61f-446a-a87c-37e0de247ce6.png)

</details>

***

</details>

<details><summary><h3>Software Design: Use Case Diagram</h3></summary>

You can see our use case diagram below.

***

<img width="3933" alt="Use Cases" src="https://user-images.githubusercontent.com/110811440/230789028-4996b000-f469-45b6-858e-9067c992d223.png">

***

</details>

<details><summary><h3>Software Design: Class Diagram</h3></summary>

You can see our class diagrams below.

***

<img width="1000" alt="Class Diagrams" src="https://user-images.githubusercontent.com/29154729/230791355-d2d0d366-47e4-4db5-87ee-4bd229f8ac1f.png">

***

</details>

<details><summary><h3>Software Design: Sequence Diagram</h3></summary>

You can see our sequence diagrams below.

***

[Click here to see sequence diagrams on Figma](https://www.figma.com/file/W9AyOlGrUhcS1MW4OR9U0n/Sequence-Diagrams?node-id=0-1&t=MTcPK5QkK6FpALd5-0)

![Screenshot (28)](https://user-images.githubusercontent.com/123721259/230771402-61620341-5376-4b98-bffc-b679c17fbcc0.png)
![Screenshot (29)](https://user-images.githubusercontent.com/123721259/230771409-5efc6ce0-93b9-4648-bec4-33cded81720a.png)
![Screenshot (30)](https://user-images.githubusercontent.com/123721259/230771410-d102e182-ea35-428b-ab17-2d6820040695.png)
![Screenshot (31)](https://user-images.githubusercontent.com/123721259/230771413-39bc2226-f838-4ffe-8004-2f35258d2816.png)
![Screenshot (32)](https://user-images.githubusercontent.com/123721259/230771416-d0e7c2c5-d782-41f4-859a-58d070e67c35.png)
![Screenshot (33)](https://user-images.githubusercontent.com/123721259/230771421-f3b05a7b-26f6-465e-b950-eec9a346ba4a.png)
![Screenshot (34)](https://user-images.githubusercontent.com/123721259/230771424-cbbdb7a5-cefe-467b-b532-6735b4fbf776.png)

***

</details>

<details><summary><h3>Project Plan</h3></summary>
For Project Plan we have created a Gantt Chart by using LibreProject.
You can see our project plan below.

***

![x_page-0001](https://user-images.githubusercontent.com/45850661/230995725-27e8ec88-dec0-4db4-936c-046a5a251689.jpg)
![x_page-0002](https://user-images.githubusercontent.com/45850661/230995730-0ccec7cd-a998-49d7-ac3a-9db3f1492d69.jpg)



***

</details>


<details><summary><h3>RAM (Responsibility Assignment Matrix)</h3></summary>

You can see our RAM below.

***
<div>
<img width="811" alt="Screen Shot 2023-04-10 at 23 37 09" src="https://user-images.githubusercontent.com/61244299/230993639-c70f5d90-89f5-47fa-a129-747b6e471933.png">
</div>
<img width="372" alt="Screen Shot 2023-04-10 at 23 34 46" src="https://user-images.githubusercontent.com/61244299/230993447-35cc56fb-06e6-49e4-9582-9c070df1ceda.png">


***

</details>

<details><summary><h3>Communication Plan</h3></summary>

You can see our communication plan below.

***

| Subject  | Participators | Channel | Time |
| ------------- | ------------- |------------- |------------- |
| Discussing about weekly tasks under related channel  | All | Slack | Anytime |
| For questions and feedbacks from TA/Lecturer  | All | Discord | Anytime |
| Weekly Meeting  | All | Zoom | 19:00 - 23:00 Tuesday |
| Improving project  | All | Github | Anytime |
| For questions that need instant response  | All | Whatsapp | Anytime |
| Unscheduled Meetings  | All | F2F/Zoom | Anytime |

***

</details>
 
***

<h2 align="center">Milestone Report</h2>

<h3 align="center">CMPE352 - Introduction to Software Engineering<h3> 
<h4 align="center">Group 8 - Web Info Aggregator<h4>

<p align="center"><a href="https://github.com/bounswe/bounswe2023group8/wiki/Bahad%C4%B1r-Gezer-About">Bahadır Gezer</a></p>
<p align="center"><a href="https://github.com/bounswe/bounswe2023group8/wiki/Bahri-Alabey-About">Bahri Alabey</a></p>
<p align="center"><a href="https://github.com/bounswe/bounswe2023group8/wiki/Beg%C3%BCm-Yivli-About">Begüm Yivli</a></p>
<p align="center"><a href="https://github.com/bounswe/bounswe2023group8/wiki/Sude-Konyal%C4%B1o%C4%9Flu-About">Sude Konyalıoğlu</a></p>
<p align="center"><a href="https://github.com/bounswe/bounswe2023group8/wiki/Egemen-Kaplan-About">Egemen Kaplan</a></p>
<p align="center"><a href="https://github.com/bounswe/bounswe2023group8/wiki/Enes-Y%C4%B1ld%C4%B1z-About">Enes Yıldız</a></p>
<p align="center"><a href="https://github.com/bounswe/bounswe2023group8/wiki/Ibrahim-Furkan-Ozcelik-About">Furkan Özçelik</a> (Communicator)</p>
<p align="center"><a href="https://github.com/bounswe/bounswe2023group8/wiki/Hasan-Baki-K%C3%BC%C3%A7%C3%BCk%C3%A7ak%C4%B1ro%C4%9Flu-About">Hasan Baki Küçükçakıroğlu</a></p>
<p align="center"><a href="https://github.com/bounswe/bounswe2023group8/wiki/Meri%C3%A7-Keskin-About">Meriç Keskin</a></p>
<p align="center"><a href="https://github.com/bounswe/bounswe2023group8/wiki/Mira%C3%A7-%C3%96zt%C3%BCrk-About">Miraç Öztürk</a></p>
<p align="center"><a href="https://github.com/bounswe/bounswe2023group8/wiki/%C3%96mer-Faruk-%C3%87elik-About">Ömer Faruk Çelik</a></p>
<p align="center"><a href="https://github.com/bounswe/bounswe2023group8/wiki/Orkun-Mahir-K%C4%B1l%C4%B1%C3%A7-About">Orkun Kılıç</a></p>

<details open><summary>Contents</summary>
Milestone Report

1. [Executive Summary](https://github.com/bounswe/bounswe2023group8/wiki/Milestone-1-Report#1-executive-summary)
   * 1. Introduction
   * 2. Status  
2. [List and Status of Deliverables](https://github.com/bounswe/bounswe2023group8/wiki/Milestone-1-Report#2-list-and-status-of-deliverables)
3. [Evaluation of Deliverables](https://github.com/bounswe/bounswe2023group8/wiki/Milestone-1-Report#3-evaluation-of-deliverables)  
   * 1. Project Repository  
   * 2. Software Requirement Specification  
   * 3. Mockups 
   * 4. Software design documents in UML: Use Case  
   * 5. Software design documents in UML: Class Diagram 
   * 6. Software design documents in UML: Sequence  
   * 7. Project plan  
   * 8. RAM (responsibility assignment matrix)  
   * 9. Communication plan  
   * 10. Milestone Report 
4. [Evaluation of Tools and Processes](https://github.com/bounswe/bounswe2023group8/wiki/Milestone-1-Report#4-evaluation-of-tools-and-processes)  
   * 1. GitHub  
   * 2. Figma 
   * 3. Slack 
   * 4. Zoom  
   * 5. Whatsapp  
   * 6. Google Docs 
5. [Individual Contribution Reports](https://github.com/bounswe/bounswe2023group8/wiki/Milestone-1-Report#5-individual-contribution-reports)  

</details>

<details open><summary><h3>1. Executive Summary</h3></summary>

<details open><summary><h4>1.1 Introduction</h4></summary>

The Web Info Aggregator project is an innovative solution designed to streamline the process of gathering and utilizing information from various online resources. As the internet continues to expand, valuable data is often scattered across multiple websites and presented in disparate forms. This project aims to tackle this challenge by providing a comprehensive, user-friendly platform that enables seamless collaboration among users in their quest for relevant information.

The primary objective of Web Info Aggregator is to empower users to contribute meta-information (e.g., fact, out of date) about the data they collect from various online sources. This collaborative effort will allow users to search, group, and process information in novel and efficient ways, fostering the development of new insights and ideas. By bringing people together to contribute and build upon existing information, the platform aims to harness the collective wisdom of its users, thereby unlocking the true potential of the vast information resources available online.

To facilitate this collaborative process, Web Info Aggregator incorporates a range of features designed to enhance user experience and streamline information discovery. From advanced search capabilities to intuitive data grouping and processing tools, the platform is meticulously crafted to cater to the diverse needs of its users.

In summary, the Web Info Aggregator project is a groundbreaking initiative that seeks to revolutionize the way users interact with and process online information. By fostering collaboration and harnessing the power of collective intelligence, this platform is poised to become an indispensable tool for individuals and organizations alike, as they strive to navigate the complex and ever-expanding digital landscape.

</details>

<details open><summary><h4>1.2 Status</h4></summary>

From the inception of the project, we established a GitHub repository for continuous enhancement and communication throughout its development. Each team member created and updated the wiki page weekly. We then developed a homepage to consolidate all project-related information and links.

Our team agreed upon a communication strategy, appointed a spokesperson(Furkan), and scheduled regular meetings. We investigated other related projects. Based on this analysis, we identified the project's core features and defined its functional and non-functional requirements using our previous notes.

To verify these requirements, we prepared questions for our client and scheduled a meeting. We developed mockup scenarios to better illustrate our project and demonstrate its potential in specific situations. We also developed Class, Use-Case, and Sequence Diagrams to facilitate future improvements and outline our project's trajectory.

We initiated our diagram creation process with a Use-Case diagram based on the requirements, followed by the Class and Sequence diagrams. During this process, we held numerous meetings to review and plan tasks. We also created a Responsibility Assignment Matrix (RAM) and a project plan as part of our Milestone-1 report. Each team member filled out the RAM table according to their completed work and documented their individual contributions for the Milestone-1 report.

</details>

</details>

<details open><summary><h3>2. List and Status of Deliverables</h3></summary>

<meta charset="utf-8"><b style="font-weight:normal;" id="docs-internal-guid-658ef430-7fff-8f58-df0b-bbbcc8821bc8"><div dir="ltr" style="margin-left:0pt;" align="left">

Deliverable | Status
-- | --
Project Repository | Delivered / Complete
Software Requirement Specification | Delivered / Complete
Mockups | Delivered / Complete
Software design documents in UML: Use Case | Delivered / Complete
Software design documents in UML: Class | Delivered / Complete
Software design documents in UML: Sequence | Delivered / Complete
Project plan | Delivered / Complete
RAM (responsibility assignment matrix) | Delivered / Complete
Communication plan | Delivered / Complete
Milestone Report | Delivered / Complete

</div></b>

</details>

<details open><summary><h3>3. Evaluation of Deliverables</h3></summary>

<details open><summary><h4>3.1 Project Repository</h4></summary>

As we collaborate on the Web Info Aggregator project, our team of 12 uses the bounswe2023group8 GitHub repository as our primary workspace. This repository greets users with a README.md file, which includes an introduction, a list of team members, and a summary of our action plan. Additionally, the repository contains directories for issue templates and deliverables.

We primarily employ a wiki structure within the repository to compile all information and work conducted since the project's inception. Our wiki homepage, team member lists, meeting reports, research reports, requirements, mockups, and UML diagrams, each with their respective links. The sidebar also allows easy access to each of the wiki pages, which detail our work throughout the semester.

As a team, we manage and track our work using the repository's issue structure. We regularly create issues for tasks, review them, provide suggestions when needed, and close them upon task completion. This approach ensures that our repository offers a comprehensive and detailed account of our work.

In our bounswe2023group8 GitHub repository, we also maintain a wiki page that serves as a central hub for organizing our work. The wiki is divided into sections such as Project, Meetings, Templates, Researches, Individual Contribution Reports, and Team Members.

The Project section contains Requirements, Milestone 1 report, Use Case Diagrams, Sequence Diagrams, and Class Diagrams. The Templates section includes templates for recurring wiki pages, ensuring a consistent structure throughout the group's documentation. In the Researches section, we compile research on open-source repositories to gain a solid understanding of best practices for managing a repo. The Team Members section contains About Me pages of every group member. It allows visitors to know us briefly. 

Furthermore, the Individual Contribution Reports section features a dedicated report page for each group member. Here, every member documents their accomplishments, maintaining transparency and accountability within the team.

</details>

<details open><summary><h4>3.2 Software Requirement Specification</h4></summary>

Eliciting the Software Requirements Specifications(SRS) is the first step to any good project planning that revolves around the product itself. Thus, our SRS had to specify all the necessary and desirable(but optional) features of our product and define the key terms used within itself in order to describe the product better. 

We had a meeting with our customers as soon as possible after it was certain that we would be creating this product for them. During this meeting, we tried to ask our customers as many questions as possible in order to understand what they truly expect from this product. After this meeting with the customers, we gathered as a team and prepared the first draft of our SRS. We divided them under 3 main categories: User Requirements, Functional System Requirements and Non-Functional System Requirements. User requirements define all the possible actions a user shall or shall be able to take while using our product while Functional System Requirements define actions that the product’s systems shall or shall be able to take. Non-Functional System Requirements define the criterias the system should fulfill during its activities.

After our first draft, we had another meeting with our customers to clear out any confusions about the requirements and get a clearer picture of the entire product. We refined our SRS after this meeting and sent them to our customer -as a file this time-  for one final review and applied the necessary changes after this review.

In the end, we refined our SRS to the point where it might need changes only when we decide to put a new feature in it or take an existing feature out of it. Naturally, a software program is an evolving entity and it will continuously change both before and after its publication. SRS shall always keep track of all these changes and we will continue to apply them during the lifetime of our product.

</details>

<details open><summary><h4>3.3 Mockups</h4></summary>

Mock-ups of the project are the static representation of the product. They show users and stakeholders how it will look and how it will be used. There are design patterns for every essential page such as logos, icons, fonts, colors and other components that will be used generically throughout the product.

In our project, we used Figma to design the visual impression of the application. There are three main pages in the file that separates assets of the whole product, web designs and mobile designs.

In the Assets page, there are components that are used and may be used again over the whole product. Those components are generic, meaning they may be used by copying to pages and changes on the main component affects all copies, but changes on instances stay discrete. 

In the Web and Mobile pages, we grouped the scenes as OAuth as authorization, Timeline, Search, Profile, Post, Interest Area and Settings. For both web and mobile there are different page designs for member and visitor users. Furthermore, the pop-up views are designed as scenes too, if needed. 

</details>

<details open><summary><h4>3.4 Software design documents in UML: Use Case</h4></summary>

The use-case diagram provides a visual representation of the ways in which different types of users interact with our system to complete specific tasks. The diagram highlights four user categories: registered users, guests, moderators and admins, and shows the different paths each group can take to perform particular actions. To illustrate the organization of our system's functionalities, we use three arrows. The "includes" arrow connects the base use case to the common portion use case, indicating that the behavior of the included use case is part of the base use case. The "extends" arrow, as the name implies, extends the base use case and adds more features to the system which are actions that are not always used. Lastly, solid arrow connects users with base use cases they can perform. Overall, our use-case diagram serves as a valuable resource for any user to understand the actions required to utilize our application's services.

</details>

<details open><summary><h4>3.5 Software design documents in UML: Class Diagram</h4></summary>

The class diagram highlights the system's architecture by enumerating all pertinent classes, their attributes, and methods, as well as illustrating the links and interactions among them. This representation provides a more comprehensive perspective on the system's functionalities in comparison to use-case and sequence diagrams. Our class diagram incorporates four distinct relationship types: Bidirectional Association, Unidirectional Association, Composition Association, and Association Class.
Bidirectional Association arrows represent a two-way relationship between classes, indicating that both classes are aware of each other and can interact with one another. Unidirectional Association arrows, on the other hand, denote a one-way relationship, meaning one class is aware of and can interact with the other, while the other class is not aware of the first class. Composition Association arrows depict a strong connection where the contained object only exists concurrently with the container class. Lastly, the Association Class is a unique relationship that illustrates an association between two classes, while also being a class itself, possessing its own attributes and methods.
By utilizing these relationship types, the class diagram effectively captures the relationships and organization of classes within the system.

</details>

<details open><summary><h4>3.6 Software design documents in UML: Sequence</h4></summary>

Our team approached the creation of sequence diagrams with a great deal of care and attention to detail. We recognized the importance of creating diagrams that would capture every relevant aspect of the system, and to achieve this, we ensured that our approach was meticulous. We worked collaboratively, sharing tasks and responsibilities among team members to ensure that the workload was evenly distributed. Our aim was to create a cohesive and comprehensive set of diagrams that would accurately represent the functionalities and interactions of our system.

To accomplish this, we used sequence diagrams to explain how objects interact for a given use case, highlighting the classes and their relationships through functions. We utilized three case specific message arrows to represent the essential steps to initiate use cases and how other components or related actors would respond throughout the same use case in a sequential manner. We employed a synchronous message arrow which was a solid arrow that went from left to right. This indicated that the sender would wait for the recipient to process and return the message before sending another. A dashed return message arrow from right to left indicated that the message receiver had completed processing the message and was handing control back to the message sender. We also employed a reflexive message that occurs when an item sends a message to itself, with the message arrow starting and ending at the same lifeline.

Our team recognized that although sequence diagrams could not cover all conceivable use cases, the 7 groups and 24 in total sequence diagrams we created covered the most important ones. To maintain consistency, we designed these sequence diagrams in line with the class diagram and the use case diagram.

In addition to our careful approach to creating sequence diagrams, we recognized the importance of effective communication among team members. To facilitate better communication, we made it a point to have regular in person meetings in addition to virtual discussions. By doing so, we were able to discuss any questions or concerns that arose, ensuring that everyone was on the same page and that the project was progressing smoothly. Overall, our team’s approach to the creation of sequence diagrams was thorough and collaborative, leading to the development of a comprehensive set of diagrams that accurately represented our system’s functionalities and interactions.

</details>

<details open><summary><h4>3.7 Project Plan</h4></summary>

While working on this report, we simultaneously developed the project plan and RAM sections. We began by compiling a list of all the tasks that had been completed by the group, and then proceeded to create an excel sheet for RAM. Each member filled in their column based on their previous responsibilities. To create the project plan, we used also excel. We expanded upon the RAM by adding more detailed information about each task’s author and its timeline (start and end dates). In the end it included all completed tasks until the end of milestone deadline. Then we transferred the data we collected to the projectLibre. The final version of the project plan is available in the wiki.

</details>

<details open><summary><h4>3.8 RAM (responsibility assignment matrix)</h4></summary>

The Responsibility Assignment Matrix is a table where all team members add their responsibilities with specific contribution levels. After determining the tasks and creating the table, it was shared with all group members. All members evaluated their tasks by discussing them among themselves, and as a result of this evaluation, everyone's work was revealed. Thanks to this table, all group members had the opportunity to assess the responsibilities they would take on for future tasks by seeing how they contributed to different parts of the project.

</details>

<details open><summary><h4>3.9 Communication plan</h4></summary>

Our team utilized different communication channels throughout the project.
We used Discord since there is a discord channel for this class. Initially our group Communicator (Ibrahim Furkan Ozcelik) contacted our TA Alper Ahmetoglu through email or discord but after a while our communication sometimes happened through group8 on discord since other than scheduling meetings we had questions and need for feedback.
Our main communication channel for group chat was Slack. We have created 9 channels as project progressed for our discussions.Channel ‘general’ for general topics, ‘meetings’ for arranging weekly meetings, ‘ps’ for meetings with TA/lecturer, ‘random’ for boosting group creativity/spirit, ‘requirements-analysis’ for people working on requirements, ‘mock-up’ for people working on mockups, ‘use-case’ for people working on use case diagrams, ‘class-diagrams’  for people working on class diagrams, ‘sequence-diagrams’ for people working on sequence diagrams.
Github is our main tool to see our progression. We used issues to let people see what we are working on and sometimes share our thoughts under issues.
We had weekly meetings on Zoom every Tuesday between 19-23. We decided starting hour of meeting weekly. Other than that we had unscheduled meetings whenever we thought we needed an extra meeting for weekly tasks, sometimes as a team, sometimes as a group that works on a specific part of the project.
We also used Whatsapp to communicate but we used it only to handle questions/needs that needed immediate response.

</details>

<details open><summary><h4>3.10 Milestone Report</h4></summary></details>

The Milestone report can be considered as the end product of a collective major effort. By the time we reached the Milestone report, the Software Requirements Analysis, Use Case diagram, Sequence Diagram, and Class diagram had already been prepared by the group. The only thing that needed to be done was to combine these pieces and complete the remaining parts.

First, everything that had been prepared beforehand was made seamless. Then, other components like RAM, Project Plan, and Communication Plan were completed by dividing the work among the group members. After everyone had individually completed their required tasks, the pieces began to be assembled.

Thanks to the joint effort of all group members, the pieces fit together perfectly, and this report emerged. As with every product in the world, the final days leading up to the creation of this product were indeed intense; the desire to achieve a refined result was one of the main reasons for this pressure.

</details>

<details open><summary><h3>4. Evaluation of Tools and Processes</h3></summary>

<details open><summary><h4>4.1 GitHub</h4></summary>

We use GitHub for version control and collaboration. It serves as a collection displaying all the work done, including information about our team,our research and most importantly what we are working on. Also all project progress and deliverables are located in our repository. For documentation we mostly used the Wiki page which we collected and organized every minor of our project improvements. Other than that we often used Issues to organize our work by sharing tasks, see if any task has not been assigned to anyone or see if we are struggling on a specific task. We mostly discussed group meetings or sometimes individual meetings but sometimes we also used Issues since it also provides commenting, contributing to another person’s issue. Up until now Github is extremely useful for documentation and issue tracking.

</details>

<details open><summary><h4>4.2 Figma</h4></summary>

We used Figma for our designs. First, we used it for Mock-ups, after that we really liked Figma’s features and decided to use it for our diagrams as well. Initially it was hard to get used to the grouping and framing features of Figma, but after we got used to it, it made us faster. Figma allows users to edit designs simultaneously which accelerates the process of creating mockups and diagrams.

</details>

<details open><summary><h4>4.3 Slack</h4></summary>

We used Slack as our main communication tool. We created channels to keep our project related chats organized. We used the polling feature for decision-making and Zoom extension to organize meetings. We prefer using Slack because it is more organized and formal in comparison to other communication applications such as WhatsApp.

</details>

<details open><summary><h4>4.4 Zoom</h4></summary>

We used Zoom for our online meeting platform. As a group it is not very easy to gather around for a face to face meeting. Thus, each week and every time we needed a meeting, we created a Zoom meeting to talk about issues, task sharing and project related updates. We implement Zoom to Slack in order to ease opening meetings and inviting people.

</details>

<details open><summary><h4>4.5 WhatsApp</h4></summary>

We used WhatsApp for our back-up communication tool. Since Slack is a new tool for many of us as students, we used WhatsApp if people did not see an emergency information that had been announced on Slack. To be more formal on our project progress, we tried to use WhatsApp only if needed.

</details>

<details open><summary><h4>4.6 Google Docs</h4></summary></details>

We used Google Docs as a shared document creation tool and a storage for the project documents in general. It is quite easy to use and creates a viable space for collaborative works.
We opened a group drive on Google and stored our deliverable drafts, meeting notes and other collaborative files in it. 

</details>

<details open><summary><h3>5. Individual Contribution Reports</h3></summary>

[Bahri Alabey](https://github.com/bounswe/bounswe2023group8/wiki/Bahri-Alabey-Individual-Contribution-Report)<br>
[Ömer Faruk Çelik](https://github.com/bounswe/bounswe2023group8/wiki/%C3%96mer-Faruk-%C3%87elik-Individual-Contribution-Report)<br>
[Bahadır Gezer](https://github.com/bounswe/bounswe2023group8/wiki/Bahadır-Gezer-Individual-Contribution-Report---Milestone-1)<br>
[Egemen Kaplan](https://github.com/bounswe/bounswe2023group8/wiki/Egemen-Kaplan-Individual-Contribution-Report)<br>
[Meriç Keskin](https://github.com/bounswe/bounswe2023group8/wiki/Meri%C3%A7-Keskin-Individual-Contribution-Report)<br>
[Orkun Kılıç](https://github.com/bounswe/bounswe2023group8/wiki/Orkun-Mahir-Kilic-Individual-Report)<br>
[Sude Konyalıoğlu](https://github.com/bounswe/bounswe2023group8/wiki/Sude-Konyal%C4%B1o%C4%9Flu-Individual-Contribution-Report)<br>
[Hasan Baki Küçükçakıroğlu](https://github.com/bounswe/bounswe2023group8/wiki/Hasan-Baki-K%C3%BC%C3%A7%C3%BCk%C3%A7ak%C4%B1ro%C4%9Flu-Individual-Contribution-Report)<br>
[Furkan Özçelik](https://github.com/bounswe/bounswe2023group8/wiki/%C4%B0brahim-Furkan-%C3%96z%C3%A7elik-Individual-Contribution-Report)<br>
[Miraç Öztürk](https://github.com/bounswe/bounswe2023group8/wiki/Mira%C3%A7-%C3%96zt%C3%BCrk-Individual-Contribution-Report)<br>
[Enes Yıldız](https://github.com/bounswe/bounswe2023group8/wiki/Enes-Y%C4%B1ld%C4%B1z-Individual-Contribution-Report)<br>
[Begüm Yivli](https://github.com/bounswe/bounswe2023group8/wiki/Beg%C3%BCm-Yivli-Individual-Contribution-Report)<br>

</details>


