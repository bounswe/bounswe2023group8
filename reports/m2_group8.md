### 1. Project Status
In this milestone we mainly focused on user-related functionalities. Users can register, log in, and manage privacy settings. Creating and following of bunches functionalities have been implemented. Our system allows for the creation of spots within bunches, incorporating relevant metadata. Additionally, users can view profiles, follow each other, and interact on the platform. The search and filtering capabilities are implemented and users can find of spots, users, and bunches based on semantic labels and metadata. The platform is accessible on both web and Android platforms. Also, features concerning user privacy and confidentiality, such as private bunches with controlled access levels is implemented. Our team is actively working on refining the system, and overall, our project is on track to meet its objectives, with ongoing testings and improvements.

### 2. Customer Feedback and Reflections

**Web Link as a Source Prerequisite for Platform Spot Addition**

Before adding a spot to our platform, it should be mandatory to provide a web link as the source. This ought to have been an essential prerequisite, but we seem to have overlooked its implementation. It's necessary to incorporate this feature to ensure that all spots have a verifiable source.

**Obscuring Portions of Source Links for Aesthetics**

Currently, source links are displayed in their entirety, including all characters and numbers, which can be visually cluttering. For example, in a link has "/1A7uMu7PWMtXejvXvy5ZW4zzCm5f-P7beCTQGhsCkM8s" part, obscuring this part would enhance the aesthetic appeal. We need to make adjustments to partially hide these elements of the URL for a cleaner display.

**Customizable Labels**

We directly use Wikidata for labeling, but users should have the option to customize these labels. This flexibility is crucial since our platform should be open to clickbait-like strategies to facilitate finding content. Users might want to use specific, memorable labels for easy retrieval of spots, which could also aid others in discovering the same content. Allowing label customization will enhance user experience and content discoverability.

**Consistency in Terminology Across the Application**

In certain sections of the application, there appears to be inconsistency in the usage of terminology. The terms "interest area," "bunch," "spot," and "post" are interchangeably employed in different contexts. Establishing a uniform and consistent terminology throughout the application would enhance clarity and user understanding.

### 3. Changes that are Planned for Moving Forward
We made changes in [mock-ups](https://github.com/bounswe/bounswe2023group8/wiki/Mock-ups) according to feedback we got in the first milestone. We solved some issues with colors and added more images to UI. We will implement these changes in the software. Also, we will make changes to fulfill customer feedbacks which we talked about in section 2.

### 4. List and Status of Deliverables
Deliverable | Status
-- | --
Milestone Review | Delivered / Complete
Individual Contributions | Delivered / Complete
A pre-release of your software | Delivered / Complete
Weekly reports and any additional meeting notes | Delivered / Complete


### 5. Progress of Requirements


| Requirement Number | Requirement Explanation                                    | Not Started | In Progress | Completed |
| ------------------ | ---------------------------------------------------------- | ------------------------- | ---------------------------- | ----------------------------------- |
| 1           | Functional Requirements  |                          |✔️                              |                                     |
| 1.1            | User Requirements  |                          |✔️                              |        
| 1.1.1            | Registration and Login |                          |                              |✔️                                     ||
| 1.1.1.1           | Guests shall be able to :  |                          |                              |✔️                                     |
| 1.1.1.1.1            | Register giving the following information; email, password, username, birthday.  |                          |                              |✔️                                     |
| 1.1.1.2           | Users shall be able to  |                          |                              |✔️                                     |
| 1.1.1.2.1          | Login by giving the following information: email and password or username and password.      |                          |                              |✔️                                     |
| 1.1.1.2.2          | Logout.                                          |                          |                              |✔️                                     |
| 1.1.1.2.3          | Update their passwords.                           |                          |                              |✔️                                     |
| 1.1.1.2.4          | Reset passwords using 'Forgot Password?' option. |                          |                              |✔️                                     ||
1.1.2           | Account  |                          |✔️                              |                                     |
| 1.1.2.1            | Guests shall verify their account via email before they can be considered as users.                           |                          |                              |✔️                                     |
| 1.1.2.2            | Users shall be able to delete their accounts.                            |✔️                          |                              |                                     |
| 1.1.2.3           | Users shall be able to update some of the account information.  |                          |                              |✔️                                     |
| 1.1.2.3.1          | Users shall be able to change passwords and other account related settings.                  |                          |                              |✔️                                     |
| 1.1.2.3.2          | Users shall not be able to change their username, email address and birthday.      |                          |                              |✔️                                     |
| 1.1.2.5          | Users shall have control over privacy settings of IAs. (e.g. public, private and personal).                      |✔️                          |                              |                                     |
| 1.1.3           | User-to-User Interactions  |                          |✔️                              |                                     |
|            | Users shall be able to:  |                          |                              |                                     |
| 1.1.3.1            |View other users profiles' and see their publicly viewable data such as their public posts (posts they created in public IAs), names of their public and private IAs, followers, followings, and tags that they are interested in.              |                          |                              |✔️                                     |
| 1.1.3.2            | Follow other users on the platform.                               |                          |                              |✔️                                     |
| 1.1.3.3            | Vote on other users based on their profile, behaviour and activity on the platform which will affect the target's reputation scores (See "1.2.3.2 Reputation system")                               |✔️                          |                              |                                     || 1.1.4           | User-to-Platform Interactions  |                          |                              |                                     |
|            | Users shall be able to interact with the platform via:  |                          |                              |                                     |
| 1.1.4.1           | 1.1.4.1 Posts: (See "1.2.1.1 Posts")  |                          |✔️                              |                                     |
| 1.1.4.1.1          | Creating a post in an IA by providing a title, a main link that this post refers to, a description, tags that the post relates to defined by Wikidata, original source of the provided link, and optionally: publication date of the original source, geolocation of the subject in accordance with W3C Recommendation standards, fact-checking status, and purpose of the post.                            |                          |                              |✔️                                    |
| 1.1.4.1.2          | Editing fields of their own post.                             |                          |                             |✔️                                     |
| 1.1.4.1.3          | Commenting on a post.                                |✔️                          |                              |                                     |
| 1.1.4.1.4          | Down/Upvoting a post.                            |✔️                          |                              |                                     |
| 1.1.4.1.5          | Reporting inappropriate posts to IA moderators. (See "1.1.4.2.7" for more info in Moderators)       |✔️                          |                              |                                     |
| 1.1.4.1.6          | Annotating any post in order to give more detailed information about certain parts of these posts (See "1.2.1.4 Annotations")                                    |✔️                          |                              |                                     |
| 1.1.4.1.7          | Suggesting additional tags to posts created by other users.                  |                         |✔️                              |                                     |
| 1.1.4.2          | Interest Areas: (See "1.2.1.2 Interest Areas")                  |                          |✔️                              |                                     |
| 1.1.4.2.1          | Creating an interest area by providing a title, tags defined by Wikidata to describe the focus of the IA, the IA's access levels (See item "1.2.1.2.5" about access levels), and the set of IAs that the new IA will consist of in case the new IA is a collection of other IAs.                                       |                          |                              |✔️                                     |
| 1.1.4.2.2          | Editing fields of interest areas which they have owner or moderation access level except. (See item "1.2.1.2.5" about access levels)     |                          |                              |✔️                                     |
| 1.1.4.2.3          | Following other IAs.                                |                          |                              |✔️                                     |
| 1.1.4.2.4          | Joining private IAs. (See item "1.2.1.2.5" about access levels) Users shall be able to request to join a private interest area.                                  |                          |                              |✔️                                     |
| 1.1.4.2.5          | Creating posts in interest areas which they have an access level higher than viewer. (See item "1.2.1.2.5" about access levels)           |                          |                              |✔️                                     |
| 1.1.4.2.6          | Suggesting additional tags to IAs created by other users.                   |                          |✔️                              |                                     |
| 1.1.4.2.7          | Reporting inappropriate IAs to System Administrators.           |✔️                          |                              |                                     |
| 1.1.4.2.8          | 1.1.4.2.8 Managing roles of other users in their own interest areas. Every role in the role hierarchy below shall have the permissions of all the roles below itself: Owner: Only the owner of the IA shall have this role. Only an owner shall be able to manage roles of other users within that IA. Moderator: Moderators shall moderate the content and the behavior of the users within an IA. They shall have access to the moderator dashboard which grants certain abilities within that particular IA, explained more in detail under item "1.2.4.1" Creator: Creators in an IA shall be able to create new posts within that IA. Consumer: Consumers in an IA shall be able to interact with the posts or the IA in every way possible explained under items "1.1.4.1" and "1.1.4.2" except creating new posts.          |                          |✔️                              |                                     || 1.2.1.1.1          | Posts shall have an IA.                                     |                          |                              |                                     |
| 1.2          | System Requirements                                   |                          |✔️                              |                                     |
| 1.2.1          | Content                                    |                          |✔️                              |                                     |
|           | System shall have a certain structure of content and content containers as follows:                                    |                          | ✔️                             |                                     |
| 1.2.1.1          | Post                                    |                          |✔️                              |                                     |
| 1.2.1.1.1          | Shall have an IA.                                   |                          |                              |✔️                                     |
| 1.2.1.1.2          | Shall have a title.                                   |                          |                              |✔️                                     |
| 1.2.1.1.3          | Shall have a main body that consists of only a main non-empty link, that is the target of the post in question, and an optional text for the creator to comment on this target link or describe it.  |                          |                              |✔️                                     |
| 1.2.1.1.4          | Shall contain required relevant metadata: At least one semantic label (tag) that utilizes the tagging system on the platform, which uses Wikidata knowledge base (See "1.2.3.1 Tags") Source - Which source of media does this link originate from? Creator - Either a person (author, photographer etc.) or an entity in accordance with the utilized tagging system. Creation date                         |                          |                              |✔️                                     |
| 1.2.1.1.5          | Shall contain optional relevant metadata: Geolocation of the subject of the link, which follows the W3C Recommendation standards. Publication dates Fact-checking status                         |                          |                              |✔️                                     |
| 1.2.1.1.6          | Shall have comments, upvotes, and downvotes.          |✔️                          |                              |                                    |
| 1.2.1.1.7          | Shall specify its purpose by labels. (e.g. documentation, learning, research, news, discussion, sharing).                          |                          |                              |✔️                                     |
| 1.2.1.2          | Interest Areas (IA):                          |                          |✔️                              |                                     |
| 1.2.1.2.1          | Shall consist of posts created by their users or posts created within their nested IAs.  |                          |                              |✔️                                     |
| 1.2.1.2.2          |  Shall be able to consist of a collection of other IAs.(nested)      |                          |                              |✔️                                     |
| 1.2.1.2.3          | 1.2.1.2.3 Shall obtain at least one semantic label(tag) during their creation. IA tags only show the topic scope of an IA and shall utilize the main tagging system on the platform, which uses Wikidata knowledge base (See "1.2.3.1 Tags") Users shall be able to alter the tags of an IA later.         |                          |                              |✔️                                     |
| 1.2.1.2.4          | Shall have a "Recommended IAs" section where it lists other IAs that might interest the user based on their tags.                 |                          |✔️                              |                                    |
| 1.2.1.2.5          | 1.2.1.2.5 Offers various access levels: (See 1.1.4.2.8 for managing roles) Public: Owner: Creator of the IA. Moderator: Users invited by the owner to administer the IA. Creator: Users who meets the necessary requirements set by the owner and moderators for this IA. Consumer: Everyone except those who are explicitly blocked. Private: Owner: Creator of the IA. Moderator: Users invited by the owner to administer the IA. Creator: Users invited by either the owner or moderators. Consumer: Users invited by either the owner or moderators. The private IAs' access level is immutable for privacy and security reasons. Personal: Owner: Creator of the IA. Moderator: Nobody Creator: Nobody Consumer: Nobody Personal IAs are not listed for any user other than the creator.                       |                          |                              |✔️                                     |
| 1.2.1.3          | Home Page for each user: Each Home Page shall be personalized for its user and shall achieve this by:     |                          | ✔️                             |                                   |
| 1.2.1.3.1          | Displaying recent posts from followed interest areas and users.                 |                          |                              |✔️                                     |
| 1.2.1.3.2          | Suggesting new posts and interest areas that are relevant to its user based on the users interests. This system shall use the main tagging system to make the semantic connections between the users interests and the suggestions(See "1.2.3.1 Tags")                 |                          |✔️                              |                               |
| 1.2.1.4          | Annotations      |✔️                          |                           |                                     |
| 1.2.1.4.1          | Annotations shall have the W3C Web Annotation Data Model.      |✔️                          |                              |                                     |
| 1.2.1.4.2          | Annotations shall appear in form of a highlight made on the annotated text without displaying any extra content.                     |✔️                          |                            |                                     |
| 1.2.1.4.3          | Annotations shall display a pop-up over the highlighted areas upon user interaction and only then provide its contents within this pop-up.      |✔️                          |                              |                                     |
| 1.2.1.4.4          | Annotations shall only be placed on Post main bodies.        |✔️                          |                              |                                     |
| 1.2.2            | Search and Filtering    |                          |✔️                              |                                     |
| 1.2.2.1            | The system shall allow users to search for posts, users, and IAs based on semantic labels, metadata, and interest areas.    |                         |                              |✔️                                     |
| 1.2.2.2            | The system shall enable post filtering by interest areas, date, location, and other metadata.    |✔️                          |                              |                                     |
| 1.2.2.3            | The system shall enable the user to sort search results by relevance, date, and popularity              |✔️                          |                              |                                     |
| 1.2.2.4            | The system shall allow public and private IAs to be searchable. |                         |                              |✔️                                     
|1.2.3            | Labeling |                          |✔️                              |                                     |                             |                                     |
| 1.2.3.1            | Tags |                          |                              |✔️                                     |                             |                                     |
| 1.2.3.1.1          | The system shall utilize Wikidata API, in order to implement a semantic labeling mechanism on the platform and this mechanism shall appear in form of tags under each post or IA.   |                          |                              |✔️                                     |
| 1.2.3.1.2          | Upon user interaction, each tag shall be able to display more tags, to which it is semantically related.         |                          |                              |✔️                                     |
| 1.2.3.1.3          | The system shall facilitate post and IA searching based on these tags           |                          |                             |✔️                                     |
| 1.2.3.1.5          |  Tags shall allow users to find interest areas, users, and posts related to themselves.             |                          |                              |✔️                                     |
| 1.2.3.2         |  Reputation system:             |✔️                          |                              |                                     |
| 1.2.3.2.1          | The system shall allow users to vote on other users based on their qualities and it shall keep record of these votes.            |✔️                          |                              |                                     |
| 1.2.3.2.2          | Votes shall represent either positive or negative side of a quality of the user.          |✔️                          |                              |                                     |
| 1.2.3.2.3          | The system shall assign badges to users depending on how many positive and negative votes they received on a certain quality. A user might be good at fact-checking and receive many positive fact-checker votes from other users. Conversely, a user might do false fact-checks constantly and receive negative fact-checker votes from other users. When the user accumulates enough net positive or negative votes as a fact-checker, the system shall assign them with the badge that represents this good or bad quality.                 |✔️                          |                              |                                     |
| 1.2.4            | Reporting and Moderation|✔️                          |                              |                                     |
|             | The system shall have two distinct dashboards to review reported content and users.|✔️                          |                              |                                     |
| 1.2.4.1             | Moderation Dashboard available to IA moderators shall grant abilities for:|✔️                          |                              |                                     |
| 1.2.4.1.1             | Removing inappropriate posts from the IA. abilities for:|✔️                          |                              |                                     |
| 1.2.4.1.2             | To warn users that create such inappropriate posts or misbehave under comment sections.|✔️                          |                              |                                     |
| 1.2.4.1.3             | Banning users from the IA.|✔️                          |                              |                                     |
| 1.2.4.1.4             | Reporting issues to System Administrators in case these issues require actions outside the scope of the Moderation Dashboard.|✔️                          |                              |                                     |
| 1.2.4.2             | Administration Dashboard available to System Administrators shall grant abilities for:           |✔️         |                          |                              |                                     ||           
| 1.2.4.2.1             | Removing inappropriate posts or IAs from the platform.           |✔️         |                          |                              |                                     ||           
| 1.2.4.2.2             | Warning users that create such inappropriate posts or misbehave under comment sections.           |✔️         |                          |                              |                                     ||           
| 1.2.4.2.3             | Banning users from the platform.           |✔️         |                          |                              |                                     ||           
| 1.2.5            | Account Management |                          |                              |✔️                                     |
| 1.2.5.1            | When a user's account is deleted, all account information including the username, password, phone number and email address shall be deleted from the database. |                          |                              |✔️                                     |
| 1.2.5.2            | All private IAs created by deleted account shall be deleted along with the posts created in them.  |                          |                              |✔️                                     |
| 1.2.5.3            | Public posts, comments, private IAs, and public IAs created by deleted account shall remain visible on the platform.          |                          |                              |✔️                                     |
| 1.2.5.4            | The system shall not allow creating more than one account with the same email address. The attempt to do so shall prompt a warning. |                  |                              |✔️                                     |
| 1.2.5.5            | The system shall check the birthday of a user during the access to age-restricted content. This information is immutable after account creation. |                        |                              |✔️                                     |
| 2           | Non-Functional Requirements |                        |✔️                              |                                     |
| 2.1           | Platforms |                        |                              |✔️                                     |
| 2.1.1              | Application shall be available for Web and Android platforms.        |                          |                              |✔️                                     |
| 2.1.2              | The web version of the application shall be compatible with commonly used web browsers, including Google Chrome, Mozilla Firefox, and Safari.                |                          |                              |✔️                                     |
| 2.1.3              | The Android version of the application shall be compatible with Android 5.0 and higher.      |                          |                              |✔️                                     |
| 2.2           | Security |                        |                              |✔️                                     |
| 2.2.1              | User authorization information shall be encrypted.         |                          |                              |✔️                                     |
| 2.2.2              | The application shall implement strong password requirements and provide guidance to users on creating secure passwords.   |                          |                              |✔️                                     |
| 2.3           | Privacy and Ethical Considerations |                        |✔️                              |                                     |
| 2.3.1              | The platform shall protect personal information and contact information, adherence to copyrights, and licensing considerations; according to GDPR/KVKK rules. |                        |                              |✔️                                     |
| 2.3.2              | The application shall have a concrete "Community Guidelines" to bring Users and System Administrators on the same page in terms of appropriate content and behavior allowed on the platform. |               |✔️                              |                                     |
| 2.4           | Restricted Content |✔️                        |                              |                                     |
| 2.4.1              | Adult content should have age restrictions.                  |✔️                          |                              |                                     |
| 2.4.2              | Application shall not contain criminal content and gore.     |✔️                          |                              |                                     |


### 6. API endpoints (both public or private access):
You can find API documentation and example API calls in the link below.

https://documenter.getpostman.com/view/30817138/2s9YRGy9fA

### 7. Generated unit test reports (for backend, frontend, and mobile).


### 8. Testing Strategy

1. Unit Testing

Web Unit Testing: We will use [Trailblu](https://www.trailblu.com/) to test our web app. Trailblu is a test automation service which allows developers to test their application by using it just like a normal user would do. Developers install a desktop application, configure it and then start using their application. Trailblu will record their actions and create automated tests according to them. Here are some screenshots of how it tracks our tests:
![image](https://github.com/bounswe/bounswe2023group8/assets/22966868/25106e16-8044-4091-946a-05b3590720e4)
![image](https://github.com/bounswe/bounswe2023group8/assets/22966868/92bfaed2-3984-4500-8288-180a6211b192)


Backend Unit Testing: We will use JUnit and other built in spring features like MockMVC and Mockito to do unit testing. Our unit testing mechanism may have some delay since backend team is only one person.

2. Mock Data

Generated and used mock data to simulate various scenarios and test cases.
Ensured that the mock data covers a wide range of possible scenarios.

### 9. The status of the features in software making use of the annotation technology and Plans for implementing functionalities associated with annotations
We were not be able to show anything regarding annotations yet because annotations are supposed to be built on our other components. Our annotations will be using pop up or pop over mechanisms to be rendered on the screen. Instead of directly highlighting the text on regular post view, we will have a list of annotations appear on the pop up and the users will be able to select the pop up they want to see, which will lead to the post being highlighted according to that specific notation.

### 10. Individual contributions.
  - [Bahadır Gezer](https://github.com/bounswe/bounswe2023group8/wiki/Bahadır-Gezer-Milestone-%E2%80%90-2-Individual-Contribution-Report)
  - [Bahri Alabey](https://github.com/bounswe/bounswe2023group8/wiki/Bahri-Alabey-Milestone-%E2%80%90-2-Individual-Contribution-Report)
  - [Begüm Yivli](https://github.com/bounswe/bounswe2023group8/wiki/Beg%C3%BCm-Yivli-%E2%80%90-Milestone-2-Individual-Contributions-Report)
  - [Egemen Kaplan](https://github.com/bounswe/bounswe2023group8/wiki/Egemen-Kaplan-Milestone-2-Individual-Contributions-Report)
  - [Enes Yıldız]()
  - [Hasan Baki Küçükçakıroğlu]()
  - [İbrahim Furkan Özçelik](https://github.com/bounswe/bounswe2023group8/wiki/%C4%B0brahim-Furkan-%C3%96z%C3%A7elik-%E2%80%90-Milestone-2-Individual-Contributions-Report)
  - [Meriç Keskin](https://github.com/bounswe/bounswe2023group8/wiki/Meri%C3%A7-Keskin-Individual-Contribution-Report-for-Milestone-2)
  - [Miraç Öztürk](https://github.com/bounswe/bounswe2023group8/wiki/Mira%C3%A7-%C3%96zt%C3%BCrk-%E2%80%90-Milestone-2-Individual-Contribution-Report-(Fall-23))
  - [Sude Konyalıoğlu](https://github.com/bounswe/bounswe2023group8/wiki/Sude-Konyalıoğlu-Milestone-2-Individual-Contributions-Report)
  - [Ömer Faruk Çelik]()
