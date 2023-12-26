import React, { useEffect, useState } from "react";
import { Col, Row, Button } from "react-bootstrap";
import { useAuth } from "../../contexts/AuthContext";
import { useGetUser } from "../../hooks/useUser";

const SettingsPage: React.FC = () => {
  /* eslint-disable no-irregular-whitespace */
  const privacyPolicyText = `PRIVACY POLICY

  Last updated December 24, 2023
  
  
  
  
  This privacy notice for Web Info Aggregator ("we," "us," or "our"), describes how and why we might collect, store, use, and/or share ("process") your information when you use our services ("Services"), such as when you:
  
  Visit our website, or any website of ours that links to this privacy notice
  
  
  Download and use our mobile application (Web-Info-Aggregator), or any other application of ours that links to this privacy notice
  
  
  Engage with us in other related ways, including any sales, marketing, or events
  
  Questions or concerns? Reading this privacy notice will help you understand your privacy rights and choices. If you do not agree with our policies and practices, please do not use our Services.
  
  
  
  SUMMARY OF KEY POINTS
  
  
  This summary provides key points from our privacy notice, but you can find out more details about any of these topics by clicking the link following each key point or by using our table of contents below to find the section you are looking for.
  
  
  What personal information do we process? When you visit, use, or navigate our Services, we may process personal information depending on how you interact with us and the Services, the choices you make, and the products and features you use. Learn more about personal information you disclose to us.
  
  
  Do we process any sensitive personal information? We do not process sensitive personal information.
  
  
  Do we receive any information from third parties? We do not receive any information from third parties.
  
  
  How do we process your information? We process your information to provide, improve, and administer our Services, communicate with you, for security and fraud prevention, and to comply with law. We may also process your information for other purposes with your consent. We process your information only when we have a valid legal reason to do so. Learn more about how we process your information.
  
  
  In what situations and with which parties do we share personal information? We may share information in specific situations and with specific third parties. Learn more about when and with whom we share your personal information.
  
  
  How do we keep your information safe? We have organizational and technical processes and procedures in place to protect your personal information. However, no electronic transmission over the internet or information storage technology can be guaranteed to be 100% secure, so we cannot promise or guarantee that hackers, cybercriminals, or other unauthorized third parties will not be able to defeat our security and improperly collect, access, steal, or modify your information. Learn more about how we keep your information safe.
  
  
  What are your rights? Depending on where you are located geographically, the applicable privacy law may mean you have certain rights regarding your personal information. Learn more about your privacy rights.
  
  
  How do you exercise your rights? The easiest way to exercise your rights is by submitting a data subject access request, or by contacting us. We will consider and act upon any request in accordance with applicable data protection laws.
  
  
  Want to learn more about what we do with any information we collect? Review the privacy notice in full.
  
  
  
  TABLE OF CONTENTS
  
  
  1. WHAT INFORMATION DO WE COLLECT?
  2. HOW DO WE PROCESS YOUR INFORMATION?
  3. WHEN AND WITH WHOM DO WE SHARE YOUR PERSONAL INFORMATION?
  4. DO WE USE COOKIES AND OTHER TRACKING TECHNOLOGIES?
  5. HOW LONG DO WE KEEP YOUR INFORMATION?
  6. HOW DO WE KEEP YOUR INFORMATION SAFE?
  7. WHAT ARE YOUR PRIVACY RIGHTS?
  8. CONTROLS FOR DO-NOT-TRACK FEATURES
  9. DO WE MAKE UPDATES TO THIS NOTICE?
  10. HOW CAN YOU CONTACT US ABOUT THIS NOTICE?
  11. HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU?
  
  
  
  1. WHAT INFORMATION DO WE COLLECT?
  
  
  Personal information you disclose to us
  
  
  In Short: We collect personal information that you provide to us.
  
  
  We collect personal information that you voluntarily provide to us when you register on the Services, express an interest in obtaining information about us or our products and Services, when you participate in activities on the Services, or otherwise when you contact us.
  
  
  
  Personal Information Provided by You. The personal information that we collect depends on the context of your interactions with us and the Services, the choices you make, and the products and features you use. The personal information we collect may include the following:
  
  names
  
  
  email addresses
  
  
  usernames
  
  
  passwords
  
  
  Sensitive Information. We do not process sensitive information.
  
  
  
  All personal information that you provide to us must be true, complete, and accurate, and you must notify us of any changes to such personal information.
  
  
  
  2. HOW DO WE PROCESS YOUR INFORMATION?
  
  
  In Short: We process your information to provide, improve, and administer our Services, communicate with you, for security and fraud prevention, and to comply with law. We may also process your information for other purposes with your consent.
  
  
  We process your personal information for a variety of reasons, depending on how you interact with our Services, including:
  
  To facilitate account creation and authentication and otherwise manage user accounts. We may process your information so you can create and log in to your account, as well as keep your account in working order.
  
  
  3. WHEN AND WITH WHOM DO WE SHARE YOUR PERSONAL INFORMATION?
  
  
  In Short: We may share information in specific situations described in this section and/or with the following third parties.
  
  We may need to share your personal information in the following situations:
  
  Business Transfers. We may share or transfer your information in connection with, or during negotiations of, any merger, sale of company assets, financing, or acquisition of all or a portion of our business to another company.
  
  
  When we use Google Maps Platform APIs. We may share your information with certain Google Maps Platform APIs (e.g., Google Maps API, Places API).
  
  4. DO WE USE COOKIES AND OTHER TRACKING TECHNOLOGIES?
  
  
  In Short: We may use cookies and other tracking technologies to collect and store your information.
  
  
  We may use cookies and similar tracking technologies (like web beacons and pixels) to access or store information. Specific information about how we use such technologies and how you can refuse certain cookies is set out in our Cookie Notice.
  
  
  5. HOW LONG DO WE KEEP YOUR INFORMATION?
  
  
  In Short: We keep your information for as long as necessary to fulfill the purposes outlined in this privacy notice unless otherwise required by law.
  
  
  We will only keep your personal information for as long as it is necessary for the purposes set out in this privacy notice, unless a longer retention period is required or permitted by law (such as tax, accounting, or other legal requirements). No purpose in this notice will require us keeping your personal information for longer than   the period of time in which users have an account with us.
  
  
  When we have no ongoing legitimate business need to process your personal information, we will either delete or anonymize such information, or, if this is not possible (for example, because your personal information has been stored in backup archives), then we will securely store your personal information and isolate it from any further processing until deletion is possible.
  
  
  6. HOW DO WE KEEP YOUR INFORMATION SAFE?
  
  
  In Short: We aim to protect your personal information through a system of organizational and technical security measures.
  
  
  We have implemented appropriate and reasonable technical and organizational security measures designed to protect the security of any personal information we process. However, despite our safeguards and efforts to secure your information, no electronic transmission over the Internet or information storage technology can be guaranteed to be 100% secure, so we cannot promise or guarantee that hackers, cybercriminals, or other unauthorized third parties will not be able to defeat our security and improperly collect, access, steal, or modify your information. Although we will do our best to protect your personal information, transmission of personal information to and from our Services is at your own risk. You should only access the Services within a secure environment.
  
  
  7. WHAT ARE YOUR PRIVACY RIGHTS?
  
  
  In Short:  You may review, change, or terminate your account at any time.
  
  
  Withdrawing your consent: If we are relying on your consent to process your personal information, which may be express and/or implied consent depending on the applicable law, you have the right to withdraw your consent at any time. You can withdraw your consent at any time by contacting us by using the contact details provided in the section "HOW CAN YOU CONTACT US ABOUT THIS NOTICE?" below.
  
  
  However, please note that this will not affect the lawfulness of the processing before its withdrawal nor, when applicable law allows, will it affect the processing of your personal information conducted in reliance on lawful processing grounds other than consent.
  
  
  Account Information
  
  
  If you would at any time like to review or change the information in your account or terminate your account, you can:
  
  Log in to your account settings and update your user account.
  
  
  Upon your request to terminate your account, we will deactivate or delete your account and information from our active databases. However, we may retain some information in our files to prevent fraud, troubleshoot problems, assist with any investigations, enforce our legal terms and/or comply with applicable legal requirements.
  
  
  8. CONTROLS FOR DO-NOT-TRACK FEATURES
  
  
  Most web browsers and some mobile operating systems and mobile applications include a Do-Not-Track ("DNT") feature or setting you can activate to signal your privacy preference not to have data about your online browsing activities monitored and collected. At this stage no uniform technology standard for recognizing and implementing DNT signals has been finalized. As such, we do not currently respond to DNT browser signals or any other mechanism that automatically communicates your choice not to be tracked online. If a standard for online tracking is adopted that we must follow in the future, we will inform you about that practice in a revised version of this privacy notice.
  
  
  9. DO WE MAKE UPDATES TO THIS NOTICE?
  
  
  In Short: Yes, we will update this notice as necessary to stay compliant with relevant laws.
  
  
  We may update this privacy notice from time to time. The updated version will be indicated by an updated "Revised" date and the updated version will be effective as soon as it is accessible. If we make material changes to this privacy notice, we may notify you either by prominently posting a notice of such changes or by directly sending you a notification. We encourage you to review this privacy notice frequently to be informed of how we are protecting your information.
  
  
  10. HOW CAN YOU CONTACT US ABOUT THIS NOTICE?
  
  
  If you have questions or comments about this notice, you may contact us by post at:
  
  
  Web Info Aggregator
  __________
  __________
  
  
  11. HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU?
  
  
  Based on the applicable laws of your country, you may have the right to request access to the personal information we collect from you, change that information, or delete it. To request to review, update, or delete your personal information, please fill out and submit a data subject access request.

        `;
  /* eslint-disable no-irregular-whitespace */

  const [userData1, setUserData] = useState<any>(null); // State to store user data
  const { axiosInstance, userData } = useAuth();

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axiosInstance.get(
          `${
            process.env.REACT_APP_BACKEND_API_URL
          }/v1/user?id=${encodeURIComponent(userData.id)}`
        );

        if (response.status >= 200 && response.status < 300) {
          setUserData(response.data);
        }
      } catch (error) {
        console.error("API Error:", error);
      }
    };

    fetchData(); // Call the fetchData function when the component mounts
  }, []);
  console.log(userData1);
  return (
    <div className="mt-4">
      <h1 className="text-center">Settings</h1>
      <Row className="mt-4">
        <Col md={12}>
          {" "}
          {/* Use a single Col component for both sections */}
          <div className="card">
            <div className="card-header">
              <h5>Account Settings</h5>
            </div>
            <div className="card-body">
              <form>
                <div className="mb-3">
                  <label htmlFor="username" className="form-label">
                    Username
                  </label>
                  <input
                    type="text"
                    className="form-control"
                    id="username"
                    placeholder={userData1?.username || ""}
                    readOnly
                  />
                </div>
                <div className="mb-3">
                  <label htmlFor="email" className="form-label">
                    Email
                  </label>
                  <input
                    type="email"
                    className="form-control"
                    id="email"
                    placeholder={userData1?.email || ""}
                    readOnly
                  />
                </div>
                <div className="mb-3">
                  <label htmlFor="password" className="form-label">
                    Password
                  </label>
                  <div className="mb-3" style={{ display: "flex" }}>
                    <input
                      type="password"
                      className="form-control"
                      id="password"
                      placeholder="***"
                    />
                    <Button type="submit" className="btn btn-primary">
                      Change Password
                    </Button>
                  </div>
                </div>
                <div className="mb-3">
                  <label htmlFor="birthday" className="form-label">
                    Birthday
                  </label>
                  <input
                    type="text"
                    className="form-control"
                    id="birthday"
                    placeholder={userData1?.birthday || ""}
                    readOnly
                  />

                  <div></div>
                </div>
              </form>
            </div>
          </div>
          <div className="card mt-4">
            {" "}
            {/* Add some margin-top for separation */}
            <div className="card-header">
              <h5>Privacy Policy</h5>
            </div>
            <div className="card-body">
              <pre
                style={{
                  maxHeight: "70%", // Set the maximum height
                  overflowY: "auto", // Add a scrollbar when content overflows
                  whiteSpace: "pre-wrap",
                }}
              >
                {privacyPolicyText}
              </pre>
            </div>
          </div>
        </Col>
      </Row>
    </div>
  );
};

export default SettingsPage;
722;
