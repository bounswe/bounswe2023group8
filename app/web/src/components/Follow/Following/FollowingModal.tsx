import React from "react";
import { Modal } from "react-bootstrap";
import "@fontsource/inter";

import CloseBtn from "./CloseBtn.svg";
import image1 from "./display1.svg";
import image2 from "./display2.svg";
import image3 from "./display3.svg";
import image4 from "./display4.svg";

type FollowingModalProps = {
    show: boolean;
    setShow: () => void;
};

const FollowingModal = ({ show, setShow }: FollowingModalProps) => {
    // Define an array of 4 dummy followers
    const dummyFollowings: any[] = [
        {
            id: 1,
            name: "Bahadır Gezer",
            username: "yelkenadam",
            profilePicture: image1,
        },
        {
            id: 2,
            name: "Sude Konyalıoğlu",
            username: "barbunya",
            profilePicture: image2,
        },
        {
            id: 3,
            name: "Begüm Yivli",
            username: "datacikiz",
            profilePicture: image3,
        },
        {
            id: 4,
            name: "Baki Küçükçakıroğlu",
            username: "hasanlikbakikalir",
            profilePicture: image4,
        },
    ];

    return (
        <Modal
            show={show}
            onHide={setShow}
            centered
            style={{
                width: "494px",
                height: "416px",
                top: "177px",
                left: "436px",
                borderRadius: "20px",
                boxShadow: "0px 4px 10px 0px #00000040",
                overflow: "hidden", // Prevent scrolling
                backgroundColor: "#F6F6F6", // Set background color
            }}
        >
            <div
                className="follower-card"
                style={{
                    marginTop: "-31px",
                    width: "494px",
                    height: "96px",
                    display: "grid",
                    gridTemplateColumns: "110px 32px",
                    //boxShadow: '4px 4px 4px 0px #00000040',
                    backgroundColor: "#F6F6F6", // Set background color
                    //alignItems: "center",
                }}
            >
                <p
                    className="followers-text"
                    style={{
                        fontFamily: "Inter",
                        fontSize: "24px",
                        fontWeight: 700,
                        lineHeight: "29px",
                        letterSpacing: "-0.017em",
                        textAlign: "left",
                        color: "black",
                        marginLeft: "192px",
                        marginTop: "34px",
                    }}
                >
                    Followings
                </p>
                <button
                    className="close-button"
                    style={{
                        width: "50px",
                        height: "32px",
                        marginLeft: "302px",
                        marginTop: "32px",
                        border: "none",
                        borderRadius: "50%",
                        backgroundColor: "transparent",
                        overflow: "hidden", // Hide any overflow content
                    }}
                    onClick={setShow}
                >
                    <img
                        src={CloseBtn}
                        alt="Close"
                        style={{ width: "100%", height: "100%", objectFit: "fill" }}
                    />
                </button>
            </div>

            <div
                className="follower-list"
                style={{ marginTop: "0px", backgroundColor: "#F6F6F6" }}
            >
                <div
                    style={{
                        width: "1494px", // Make it span the entire width
                        height: "16px", // Adjust the height as needed
                        background: `linear-gradient(to bottom, #F1F1F1, #dadada, #F1F1F1)`, // Gradient style
                    }}
                ></div>

                {dummyFollowings.map((follower) => (
                    <div
                        key={follower.id}
                        className="follower-card"
                        style={{
                            marginTop: "16px",
                            width: "430px",
                            height: "60px",
                            margin: "0 auto",
                            marginBottom: "16px",
                            display: "flex",
                            alignItems: "center",
                            backgroundColor: "#F6F6F6",
                        }}
                    >
                        <div
                            className="profile-card"
                            style={{
                                width: "60px",
                                height: "60px",
                                display: "flex",
                                alignItems: "center",
                            }}
                        >
                            <div
                                className="circular"
                                style={{
                                    width: "60px",
                                    height: "60px",
                                    overflow: "hidden",
                                    borderRadius: "50%",
                                }}
                            >
                                <img
                                    src={follower.profilePicture}
                                    alt={`${follower.name}'s profile`}
                                    style={{ width: "100%", height: "100%" }}
                                />
                            </div>
                        </div>
                        <div
                            className="follower-info"
                            style={{
                                marginLeft: "8px",
                                display: "flex",
                                flexDirection: "column",
                            }}
                        >
                            <p
                                className="name"
                                style={{
                                    marginTop: "22px",
                                    marginBottom: "0px",
                                    fontFamily: "Inter",
                                    fontSize: "20px",
                                    fontWeight: 500,
                                    lineHeight: "24px",
                                    letterSpacing: "-0.017em",
                                    textAlign: "left",
                                }}
                            >
                                {follower.name}
                            </p>
                            <p
                                className="username"
                                style={{
                                    marginTop: "0px",
                                    fontFamily: "Inter",
                                    fontSize: "16px",
                                    fontWeight: 300,
                                    lineHeight: "19px",
                                    letterSpacing: "-0.017em",
                                    textAlign: "left",
                                }}
                            >
                                @{follower.username}
                            </p>
                        </div>
                        <button
                            className="remove-button"
                            style={{
                                border: "none",
                                width: "90px",
                                height: "32px",
                                borderRadius: "20px",
                                background: "#F1F1F1",
                                marginLeft: "auto",
                                // marginRight: "12px",
                            }}
                        >
              <span
                  style={{
                      fontFamily: "Inter",
                      fontSize: "16px",
                      fontWeight: 400,
                      lineHeight: "19px",
                      letterSpacing: "-0.017em",
                      textAlign: "center",
                      color: "#F13030",
                  }}
              >
                Unfollow
              </span>
                        </button>
                    </div>
                ))}
            </div>
        </Modal>
    );
};

export default FollowingModal;
