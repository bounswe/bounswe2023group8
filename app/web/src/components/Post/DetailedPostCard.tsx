import React, {useEffect, useState} from "react";
import {format} from "date-fns";
import Tag from "../Tag/Tag";
import {Post} from "../../pages/InterestAreaViewPage";
import LocationViewer from "../Geolocation/LocationViewer";
import {useAuth} from "../../contexts/AuthContext";
import {Link, useNavigate, useParams} from "react-router-dom";
import Label from "../Label/Label";
import {useDownvoteSpot, useGetSpotVotes, useUnvoteSpot, useUpvoteSpot} from "../../hooks/useSpotVotes";
import {useDeletePost} from "../../hooks/usePost";
import {useReportAnIssue} from "../../hooks/useModeration";
import CommentCreateCard from "../Comment/CommentCreateCard";
import CommentCard, {Comment} from "../Comment/CommentCard";
import {DeleteCommentProps} from "../../hooks/useComment";
import {UseMutateFunction} from "react-query";
import axios, { AxiosResponse } from "axios";
import SuggestTagModal from "../SuggestTags/SuggestTagModal";
import ViewSuggestionsModal from "../SuggestTags/ViewSuggestionsModal";

export type DetailedPostCardProps = {
    post: Post;
    handleCreateCommentCardDisplay: () => void;
    showCreateCommentCard: boolean;
    commentContent: string;
    handleCreateCommentInputChange:
        (e: React.ChangeEvent<HTMLInputElement>
            | React.ChangeEvent<HTMLSelectElement>
            | React.ChangeEvent<HTMLTextAreaElement>) => void
    handleCommentSubmit: (event: React.FormEvent) => void;
    deleteComment: UseMutateFunction<any, unknown, DeleteCommentProps, unknown>;
    comments: any;
}

interface AnnotationModel {
  id: string;
  start: number;
  end: number;
  note: string;
  userId: number;
  name: string;
  profilePhoto?: string | null;
  username: string;
}

class AnnotationModel {
  constructor({
    id,
    start,
    end,
    note,
    userId,
    name,
    profilePhoto,
    username,
  }: {
    id: string;
    start: number;
    end: number;
    note: string;
    userId: number;
    name: string;
    profilePhoto?: string | null;
    username: string;
  }) {
    this.id = id;
    this.start = start;
    this.end = end;
    this.note = note;
    this.userId = userId;
    this.name = name;
    this.profilePhoto = profilePhoto;
    this.username = username;
  }

  static fromJson(json: any): AnnotationModel {
    const target: string = json['target'];
    const uri = new URL(target);

    return new AnnotationModel({
      id: json['id'],
      note: uri.searchParams.get('comment') || '',
      start: parseInt(json['body']['value'].split('-').shift() || '0', 10),
      end: parseInt(json['body']['value'].split('-').pop() || '0', 10),
      userId: uri.searchParams.has('userId') ? parseInt(uri.searchParams.get('userId') || '0', 10) : 0,
      name: uri.searchParams.get('name') || '',
      profilePhoto: uri.searchParams.get('profilePhoto') === '' ? null : uri.searchParams.get('profilePhoto') || undefined,
      username: uri.searchParams.get('username') || '',
    });
  }
}
  
  // Example usage:
  const jsonExample = {
    id: 'http://18.192.100.93/wia/post-4/aggregating-1',
    body: { value: 'Example Note' },
    target: 'http://bunchup.com.tr/post/4?userId=123&name=John&profilePhoto=&username=johndoe',
  };
  
  const annotationExample = AnnotationModel.fromJson(jsonExample);

interface EnigmaUser {
    id: string;
    name: string;
    pictureUrl?: string;
    username: string;
}

async function createAnnotation({
    postId,
    comment,
    text,
    user,
  }: {
    postId: number;
    comment: string;
    text: string;
    user: EnigmaUser;
  }): Promise<boolean> {
    try {
      const baseUrl = 'http://18.192.100.93:80/wia';
      const response: AxiosResponse = await axios.post(
        `/post-${postId}`,
        {
          type: 'Annotation',
          body: { type: 'TextualBody', value: text, name: 'annotation' },
          target: `http://18.192.100.93:80/wia/post-${postId}?userId=${user.id}&name=${user.name}&profilePhoto=${user.pictureUrl || ''}&username=${user.username}&comment=${comment}`,
        },
        {
          headers: {
            Accept: 'application/ld+json',
            'Content-Type': 'application/ld+json',
          },
          baseURL: baseUrl,
        }
      );
  
    //   // Resetting the base URL to the original value
    //   // Make sure to replace Config.baseUrl with the actual base URL
    //   const originalBaseUrl = Config.baseUrl;
    //   axios.defaults.baseURL = originalBaseUrl;
  
      if (!response.status) {
        throw { message: 'Error', details: response.statusText || 'The connection has timed out.' };
      }
  
      if (response.status >= 200 && response.status < 300) {
        return true;
      } else {
        if (response.data && response.data.message) {
          throw { message: response.data.message, details: response.data.details };
        }
      }
  
      return false;
    } catch (error) {
      // Handle other errors here
      console.error(error);
      return false;
    }
}


async function getAnnotations({ token, postId }: { token: string; postId: number }): Promise<AnnotationModel[] | null> {
    try {
      const baseUrl = 'http://18.192.100.93:80/wia';
      const response = await axios.get(`/post-${postId}`, {
        headers: {
          Accept: 'application/ld+json',
          "Content-Type": 'application/ld+json',
        },
        baseURL: baseUrl,
      });
  
      // Resetting the base URL to the original value
      // Make sure to replace Config.baseUrl with the actual base URL
    //   const originalBaseUrl = Config.baseUrl;
    //   axios.defaults.baseURL = originalBaseUrl;
  
      if (!response.status) {
        throw { message: 'Error', details: response.statusText || 'The connection has timed out.' };
      }
  
      if (response.status >= 200 && response.status < 300) {
        if (response.data && response.data.first && response.data.first.items && response.data.first.items.length > 0) {
          return response.data.first.items.map((e: any) => {
            let x = AnnotationModel.fromJson(e)
            if (x.start > x.end) {
                const temp = x.start;
                x.start = x.end;
                x.end = temp;
            }
            return {
                id: x.id,
                start: x.start,
                end: x.end,
                note: x.note,
                userId: x.userId,
                name: x.name,
                profilePhoto: x.profilePhoto,
                username: x.username,
            }
        })
        }
      } else {
        if (response.data && response.data.message) {
          throw { message: response.data.message, details: response.data.details };
        }
      }
  
      return null;
    } catch (error) {
      // Handle other errors here
      console.error(error);
      return null;
    }
  }
  

const DetailedPostCard = (props: DetailedPostCardProps) => {
    const [locationModalShow, setLocationModalShow] = useState(false);
    const handleLocationModalShow = () => {
        setLocationModalShow(!locationModalShow);
    }

    const [suggestTagModalShow, setSuggestTagModalShow] = useState(false);
    const handleSuggestTagModalShow = () => {
        setSuggestTagModalShow(!suggestTagModalShow);
    }

    const [viewSuggestionsModalShow, setViewSuggestionsModalShow] = useState(false);
    const handleViewSuggestionsModalShow = () =>{
        setViewSuggestionsModalShow(!viewSuggestionsModalShow);
    }

    const {
        post: {
            content,
            createTime,
            enigmaUser,
            geolocation,
            id,
            interestArea,
            label,
            sourceLink,
            title,
            wikiTags,
            upvoteCount,
            downvoteCount,
        },
        handleCreateCommentCardDisplay,
        showCreateCommentCard,
        commentContent,
        handleCreateCommentInputChange,
        handleCommentSubmit,
        deleteComment,
        comments,
    } = props;

    const {userData, axiosInstance} = useAuth();
    const {postId} = useParams();
    const [upvotes, setUpvotes] = useState(upvoteCount);
    const [downvotes, setDownvotes] = useState(downvoteCount);
    const [isDeleting, setIsDeleting] = useState(false);
    const [annotationsVisible, setAnnotationsVisible] = useState(true);


    
    async function createAnnotationContainer(token: string, postId: number): Promise<boolean> {
        try {
        const baseUrl = 'http://18.192.100.93:80/wia';
        const response: AxiosResponse = await axios.post(`${baseUrl}`, {
            name: `post-${postId}`,
            label: `post-${postId}`,
            type: ["BasicContainer", "AnnotationCollection"],
        }, {
            headers: {
            'Accept': 'application/ld+json',
            'Content-Type': 'application/ld+json',
            },
        });
    
        // Resetting the base URL to the original value
        // const originalBaseUrl = Config.baseUrl;
        // axios.defaults.baseURL = originalBaseUrl;
    
        if (!response.status) {
            throw new CustomException('Error', response.statusText || 'The connection has timed out.');
        }
    
        if (response.status >= 200 && response.status < 300) {
            return true;
        } else {
            if (response.data && response.data.length > 0) {
            throw new CustomException(response.data);
            }
        }
    
        return false;
        } catch (error) {
        // Handle other errors here
        console.error(error);
        return false;
        }
    }
    
    class CustomException {
        constructor(public message: string, public details?: any) {}
    
        static fromJson(json: any): CustomException {
        // Implement the conversion from JSON to CustomException if needed
        return new CustomException('Error');
        }
    }

    const onAnnotate = async () => {
        try {
          try {
            const createContainerRes = await createAnnotationContainer(userData.id.toString(), Number(postId));
    
            if (createContainerRes) {
                const createAnnotationRes = await createAnnotation({
                    user: {
                        id: userData.id.toString(),
                        name: userData.name,
                        pictureUrl: userData.pictureUrl,
                        username: userData.username,
                    },
                    text: selectedTextRanges.start.toString() + "-" + selectedTextRanges.end.toString(),
                    comment: selectedTextAnnotation,
                    postId: Number(postId),
                });

                console.log(1)
              if (createAnnotationRes) {
                console.log(11)
                setSelectedTextAnnotation('');
                const anns = getAnnotations({ token: userData.id.toString(), postId: Number(postId) });
                anns.then((resolvedAnnotations) => {
                    setAnnotations(resolvedAnnotations || []);
                });
                anns.then((resolvedAnnotations) => {
                    setDisplayAnnotations(resolvedAnnotations || []);
                });
                anns.then((resolvedAnnotations) => {
                    setHighlightAnnotations(resolvedAnnotations || []);
                });        
                // Show success notification using your preferred notification library
              }
            }else{
                // Handle error appropriately
                const createAnnotationRes = await createAnnotation({
                    user: {
                        id: userData.id.toString(),
                        name: userData.name,
                        pictureUrl: userData.pictureUrl,
                        username: userData.username,
                    },
                    text: selectedTextRanges.start.toString() + "-" + selectedTextRanges.end.toString(),
                    comment: selectedTextAnnotation,
                    postId: Number(postId),
                });
      
                console.log(2)
                if (createAnnotationRes) {
                    console.log(21)
                  setSelectedTextAnnotation('');
                  const anns = getAnnotations({ token: userData.id.toString(), postId: Number(postId) });
                  anns.then((resolvedAnnotations) => {
                      setAnnotations(resolvedAnnotations || []);
                  });
                  anns.then((resolvedAnnotations) => {
                      setDisplayAnnotations(resolvedAnnotations || []);
                  });
                  anns.then((resolvedAnnotations) => {
                      setHighlightAnnotations(resolvedAnnotations || []);
                  });        
                  // Show success notification using your preferred notification library
                }
            }
          } catch (e) {
            // Handle error appropriately
            const createAnnotationRes = await createAnnotation({
              user: {
                id: userData.id.toString(),
                name: userData.name,
                pictureUrl: userData.pictureUrl,
                username: userData.username,
              },
              text: selectedTextRanges.start.toString() + "-" + selectedTextRanges.end.toString(),
              comment: selectedTextAnnotation,
              postId: Number(postId),
            });

            console.log(5)

            if (createAnnotationRes) {
                console.log(51)
              setSelectedTextAnnotation('');
              const anns = getAnnotations({ token: userData.id.toString(), postId: Number(postId) });
              anns.then((resolvedAnnotations) => {
                  setAnnotations(resolvedAnnotations || []);
              });
              anns.then((resolvedAnnotations) => {
                  setDisplayAnnotations(resolvedAnnotations || []);
              });
              anns.then((resolvedAnnotations) => {
                  setHighlightAnnotations(resolvedAnnotations || []);
              });        
                
              // Show success notification using your preferred notification library
            }
          }
        } catch (e) {
          // Handle error appropriately
            console.log(e)
        }
      };

    const navigate = useNavigate();
    const {mutate: deleteSpot} = useDeletePost({
        config: {
            onSuccess: (data: any) => {
                navigate(`/interest-area/${interestArea.id}`);
            }
        }
    })

    const handleDeleteSpot = (event: React.FormEvent) => {
        event.preventDefault()
        deleteSpot({
            id: id.toString(),
            axiosInstance: axiosInstance
        })
    }
    const {mutate: getSpotVotes, data: votesOnSpot} = useGetSpotVotes({});
    const {mutate: upvoteSpot} = useUpvoteSpot({
        config: {
            onSuccess: (data: any) => {
                const vote = votesOnSpot.filter((datum: { enigmaUser: { id: number; }; }) => {
                    return datum.enigmaUser.id == userData.id;
                })[0];
                if (vote && !vote.isUpvote) {
                    setDownvotes(downvotes - 1);
                    setUpvotes(upvotes + 1);
                } else {
                    setUpvotes(upvotes + 1);
                }

                getSpotVotes({
                    axiosInstance: axiosInstance,
                    id: postId || "1",
                })
            }
        }
    });
    const {mutate: downvoteSpot} = useDownvoteSpot({
        config: {
            onSuccess: (data: any) => {
                const vote = votesOnSpot.filter((datum: { enigmaUser: { id: number; }; }) => {
                    return datum.enigmaUser.id == userData.id;
                })[0];

                if (vote && vote.isUpvote) {
                    setUpvotes(upvotes - 1);
                    setDownvotes(downvotes + 1);
                } else {
                    setDownvotes(downvotes + 1);
                }

                getSpotVotes({
                    axiosInstance: axiosInstance,
                    id: postId || "1",
                })
            }
        }
    });
    const {mutate: unvoteSpot} = useUnvoteSpot({
        config: {
            onSuccess: (data: any) => {
                const vote = votesOnSpot.filter((datum: { enigmaUser: { id: number; }; }) => {
                    return datum.enigmaUser.id == userData.id;
                })[0];

                if (vote.isUpvote) {
                    setUpvotes(upvotes - 1);
                } else {
                    setDownvotes(downvotes - 1);
                }

                getSpotVotes({
                    axiosInstance: axiosInstance,
                    id: postId || "1",
                })
            }
        },
    });

    useEffect(() => {
        getSpotVotes({
            axiosInstance: axiosInstance,
            id: postId || "1",
        });
    }, []);

    const handleUpvote = () => {
        const vote = votesOnSpot.filter((datum: { enigmaUser: { id: number } }) => {
            return datum.enigmaUser.id == userData.id;
        })[0];
        if (vote && vote.isUpvote) {
            unvoteSpot({
                axiosInstance: axiosInstance,
                id: postId || "1",
            });
        } else if (vote && !vote.isUpvote) {
            upvoteSpot({
                axiosInstance: axiosInstance,
                id: postId || "1",
            });
        } else {
            upvoteSpot({
                axiosInstance: axiosInstance,
                id: postId || "1",
            });
        }
    };

    const handleDownvote = () => {
        const vote = votesOnSpot.filter((datum: { enigmaUser: { id: number } }) => {
            return datum.enigmaUser.id == userData.id;
        })[0];
        if (vote && !vote.isUpvote) {
            unvoteSpot({
                axiosInstance: axiosInstance,
                id: postId || "1",
            });
        } else if (vote && vote.isUpvote) {
            downvoteSpot({
                axiosInstance: axiosInstance,
                id: postId || "1",
            });
        } else {
            downvoteSpot({
                axiosInstance: axiosInstance,
                id: postId || "1",
            });
        }
    };

    const createdAtString = format(new Date(createTime), "PPpp");

    const [annotations, setAnnotations] = useState<AnnotationModel[]>([]);
    const [displayAnnotations, setDisplayAnnotations] = useState<AnnotationModel[]>([]);
    const [highlightAnnotations, setHighlightAnnotations] = useState<AnnotationModel[]>([]);
    const [mergedRanges, setMergedRanges] = useState<{start: number, end: number}[]>([]);

    const [selectedText, setSelectedText] = useState("");
    const [selectedTextAnnotation, setSelectedTextAnnotation] = useState("");
    const [selectedTextRanges, setSelectedTextRanges] = useState({
        start: 0,
        end: 0,
    });

    const [annotators, setAnnotators] = useState<string[]>([]);

    const handleSelection = () => {
        const selection = window.getSelection();
        if (selection && selection.toString().length > 0) {
            const parentText = selection.anchorNode?.textContent || "";

            let currentPosition = 0;
            let basePosition = 0;
            mergedRanges.forEach((range, index) => {
                const {start, end} = range;

                // Get the text between the current position and the start index
                const beforeHighlight = post.content.slice(currentPosition, start);

                // Get the highlighted text
                const highlightedText = post.content.slice(start, end);
                if (highlightedText == parentText) {
                    basePosition = start;
                } else if (beforeHighlight == parentText) {
                    basePosition = currentPosition;
                }
                currentPosition = end;
            });
            if (currentPosition < post.content.length) {
                if (post.content.slice(currentPosition) == parentText) {
                    basePosition = currentPosition;
                }
            }
            setSelectedTextRanges({
                start: basePosition + selection.anchorOffset,
                end: basePosition + selection.focusOffset,
            });
            setSelectedText(selection.toString());
        }
    };
    useEffect(() => {
        const anns = getAnnotations({ token: userData.id.toString(), postId: Number(postId) });
        anns.then((resolvedAnnotations) => {
            setAnnotations(resolvedAnnotations || []);
        });
        anns.then((resolvedAnnotations) => {
            setDisplayAnnotations(resolvedAnnotations || []);
        });
        anns.then((resolvedAnnotations) => {
            setHighlightAnnotations(resolvedAnnotations || []);
        });        
    //   setAnnotations([ann1, ann2, ann4, ann5, ann6, ann7, ann8, ann9, ann10]);
    //   setDisplayAnnotations([ann1, ann2, ann4, ann5, ann6, ann7, ann8, ann9, ann10]);
    }, []);

    const [selectedOption, setSelectedOption] = useState<string>("");
    const [uniqueSources, setUniqueSources] = useState<string[]>([]);
    const [showReport, setShowReport] = useState(false);
    const [reportReason, setReportReason] = useState("");

    // Function to handle dropdown option change
    const handleDropdownChange = (
        event: React.ChangeEvent<HTMLSelectElement>
    ) => {
        const filterAnnotationsBySource = (sourceToFilter: string) => {
            const filteredAnnotations = annotations.filter(annotation => (annotation.username === sourceToFilter || sourceToFilter === 'All'));
            setDisplayAnnotations(filteredAnnotations);
            setHighlightAnnotations(filteredAnnotations);
        };

        filterAnnotationsBySource(event.target.value);
        setSelectedOption(event.target.value);
    };

    useEffect(() => {
        if (highlightAnnotations.length == 0) return;
        setMergedRanges(mergeOverlappingRanges(highlightAnnotations))
    }, [highlightAnnotations])

    useEffect(() => {
        const uniqueSources = Array.from(new Set(highlightAnnotations.map(annotation => annotation.username)));
        setUniqueSources(['All', ...uniqueSources])
    }, [annotations])

    useEffect(() => {
        document.addEventListener("mouseup", handleSelection);

        return () => {
            document.removeEventListener("mouseup", handleSelection);
        };
    }, [mergedRanges]);

    function mergeOverlappingRanges(annotations: AnnotationModel[]) {
        annotations.sort((a, b) => a.start - b.start);

        const replicateRanges = [];

        let currentStartIndex = annotations[0].start;
        let currentEndIndex = annotations[0].end;

        for (let i = 1; i < annotations.length; i++) {
            const nextStartIndex = annotations[i].start;
            const nextEndIndex = annotations[i].end;

            if (currentEndIndex >= nextStartIndex) {
                // Merge overlapping ranges
                currentEndIndex = Math.max(currentEndIndex, nextEndIndex);
            } else {
                // Add the merged range
                replicateRanges.push({
                    start: currentStartIndex,
                    end: currentEndIndex,
                });

                // Update currentStartIndex and currentEndIndex
                currentStartIndex = nextStartIndex;
                currentEndIndex = nextEndIndex;
            }
        }

        // Add the last merged range
        replicateRanges.push({start: currentStartIndex, end: currentEndIndex});
        return replicateRanges;
    }

    const renderHighlightedText = () => {
        let currentPosition = 0;
        const result = [];
        mergedRanges.forEach((range, index) => {
            const {start, end} = range;

            // Get the text between the current position and the start index
            const beforeHighlight = post.content.slice(currentPosition, start);

            // Get the highlighted text
            const highlightedText = post.content.slice(start, end);

            // Update the current position to the end index for the next iteration
            currentPosition = end;

            // Add the non-highlighted part to the result
            if (beforeHighlight) {
                result.push(
                    <span key={`non-highlighted-${index}`}>{beforeHighlight}</span>
                );
            }

            // Add the highlighted part to the result
            result.push(
                <span
                    onMouseLeave={() => hoverAnnotationOver()}
                    onMouseEnter={() => {
                        hoverAnnotation(start, end);
                    }}
                    key={`highlighted-${index}`}
                    className="highlighted-text"
                    style={{backgroundColor: "powderblue"}}
                >
          {highlightedText}
        </span>
            );
        });

        // Add any remaining non-highlighted text after the last annotation
        if (currentPosition < post.content.length) {
            result.push(
                <span key={`non-highlighted-last`}>
          {post.content.slice(currentPosition)}
        </span>
            );
        }

        return result;
    };

    const hoverAnnotation = (startIndex: number, endIndex: number) => {
        const annotationsInRange: AnnotationModel[] = [];
        annotations.forEach((annotation) => {
            if (
                annotation.start >= startIndex &&
                annotation.end <= endIndex
            ) {
                annotationsInRange.push(annotation);
            }
        });
        setDisplayAnnotations(annotationsInRange);
    };

    const hoverAnnotationOver = () => {
        setDisplayAnnotations(annotations);
    };

    const handleInputChange = (event: {
        target: { value: React.SetStateAction<string> };
    }) => {
        setSelectedTextAnnotation(event.target.value);
    };

    const [searchTerm, setSearchTerm] = useState('');

    const handleSearchChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        const inputValue: string = event.target.value;
        setSearchTerm(inputValue);
        const filterAnnotationsBySource = (sourceToFilter: string) => {
            const filteredAnnotations = annotations.filter(annotation => (annotation.note.toLowerCase().includes(sourceToFilter.toLowerCase()) || content.slice(annotation.start, annotation.end).toLowerCase().includes(sourceToFilter.toLowerCase())));
            setDisplayAnnotations(filteredAnnotations);
            setHighlightAnnotations(filteredAnnotations);
        };

        filterAnnotationsBySource(inputValue);
    };

    const {post} = props;

    const {mutate: reportAnIssue} = useReportAnIssue({
        axiosInstance,
        issue: {
            entityId: parseInt(postId as string),
            entityType: "post",
            reason: reportReason,
        },
    });

    const reportSpot = () => {
        reportAnIssue({
            axiosInstance,
            issue: {
                entityId: parseInt(postId as string),
                entityType: "post",
                reason: reportReason,
            },
        });
    };

    return (
        <div className="row">
            <div className="col-8">
                <div className="card WA-theme-bg-regular rounded-4 mb-3 mt-4">
                    <div className="d-flex justify-content-between align-items-center">
                        <span className="d-flex">
                            <span style={{position: "relative", top: "-0.5em"}}>
                                <img alt="Bunch Icon" src="/assets/theme/images/Bunch.png"></img>
                            </span>
                            <span className="flex-column">
                                <div>
                                    <Link
                                        to={`/interest-area/${interestArea.id}`}
                                        style={{textDecoration: "none"}}
                                        className="fs-4 fw-bold WA-theme-dark"
                                    >
                                        {interestArea.title}
                                    </Link>
                                </div>
                                <div className="d-inline-flex">
                                     {enigmaUser.pictureUrl
                                         ? <img alt="profile picture" src={enigmaUser.pictureUrl} width="64" height="64"
                                                className="rounded-circle img-fluid object-fit-cover m-2"
                                         />
                                         :
                                         <img alt="Profile picture" src="/assets/PlaceholderProfile.png" width="64"
                                              height="64"/>
                                     }
                                    <div className="my-3 mx-2">
                                        <div className="fw-bold fs-6 WA-theme-dark">
                                            {enigmaUser.name}
                                        </div>
                                        <div className="d-flex justify-content-between">
                                            <div className="d-flex">
                                                <Link
                                                    to={`/profile/${enigmaUser.id}`}
                                                    style={{textDecoration: "none"}}
                                                    className="WA-theme-main"
                                                >
                                                    {` @${enigmaUser.username}`}
                                                </Link>
                                            </div>
                                            {/*<div className="d-flex">*/}
                                            {/*    <button className="btn btn-outline-primary">Follow</button>*/}
                                            {/*</div>*/}
                                        </div>
                                    </div>
                                </div>
                            </span>

                        </span>
                        <span className="mx-3">
                                {enigmaUser.id == userData.id
                                    ? <span className="d-flex">
                                        {!isDeleting
                                            ?
                                            <div>
                                                <Link to={`/update_post/${postId}`}
                                                      state={{
                                                          post: {
                                                              content: content,
                                                              createTime: createTime,
                                                              enigmaUser: enigmaUser,
                                                              geolocation: geolocation,
                                                              id: id,
                                                              interestArea: interestArea,
                                                              label: label,
                                                              sourceLink: sourceLink,
                                                              title: title,
                                                              wikiTags: wikiTags,
                                                              upvoteCount: upvoteCount,
                                                              downvoteCount: downvotes,
                                                          }
                                                      }}
                                                      style={{textDecoration: 'none'}}
                                                      className="btn WA-theme-bg-main WA-theme-light mx-1">Edit
                                                    Spot
                                                </Link>
                                                <button className="btn WA-theme-bg-negative WA-theme-light mx-1"
                                                        onClick={() => {
                                                            setIsDeleting(!isDeleting)
                                                        }}>
                                                    Delete Spot
                                                </button>
                                                <button className="btn btn-primary WA-theme-bg-main mx-1" onClick={() => setAnnotationsVisible(!annotationsVisible)}>
                                                    {annotationsVisible ? "Hide" : "Show"} Highlightings
                                                </button>
                                            </div>
                                            :
                                            <div>
                                                Are you sure?
                                                <button className="btn WA-theme-bg-main WA-theme-light mx-1"
                                                        onClick={handleDeleteSpot}>
                                                    Delete Spot
                                                </button>
                                                <button className="btn WA-theme-bg-dark WA-theme-light mx-1"
                                                        onClick={() => {
                                                            setIsDeleting(!isDeleting)
                                                        }}>
                                                    Cancel
                                                </button>
                                                <button className="btn btn-primary WA-theme-bg-main mx-1" onClick={() => setAnnotationsVisible(!annotationsVisible)}>
                                                    {annotationsVisible ? "Hide" : "Show"} Highlightings
                                                </button>
                                            </div>
                                        }
                                    </span>
                                    : <span className="d-flex align-items-center">
                                            {showReport ? (
                                                <div
                                                    className="mx-1 my-3 py-1 WA-theme-bg-light d-flex justify-content-center align-items-center rounded-5">
                                                    <input
                                                        type="text"
                                                        className="form-control ms-4"
                                                        placeholder="Please write a reason"
                                                        onChange={(e) => setReportReason(e.target.value)}
                                                    ></input>
                                                    <div className="d-flex mx-1">
                                                        <button onClick={() => reportSpot()} className="btn">
                                                            Submit
                                                        </button>
                                                        <button
                                                            onClick={() => setShowReport(!showReport)}
                                                            className="btn"
                                                        >
                                                            Close
                                                        </button>
                                                    </div>
                                                </div>
                                            ) : (
                                                <div
                                                    className="mx-2 my-3 WA-theme-bg-light d-flex justify-content-center align-items-center rounded-5">
                                                    <button
                                                        onClick={() => setShowReport(!showReport)}
                                                        className="btn mx-3 rounded-5"
                                                    >
                                                        Report Post
                                                    </button>
                                                </div>
                                            )}
                                        <button className="btn btn-primary WA-theme-bg-main" onClick={() => setAnnotationsVisible(!annotationsVisible)}>
                                                        {annotationsVisible ? "Hide" : "Show"} Highlights
                                        </button>
                                    </span>}
                                </span>
                    </div>
                    <div className="card WA-theme-bg-light rounded-4 ms-4 m-2 ">
                        <img
                            alt="Bookmark Icon"
                            src="/assets/theme/images/FactCheck=False.png"
                            width="64"
                            height="64"
                            style={{position: "absolute", top: "-0.66em", left: "-0.60em"}}
                        />
                        <div className="row g-0 ms-4">
                            <div className="col-9">
                                <div className="card-body">
                                    <div className="d-flex justify-content-between">
                                        <Link
                                            to={`/posts/${id}`}
                                            style={{textDecoration: "none"}}
                                            className="card-title truncate-text-2 WA-theme-dark fs-5 fw-bold"
                                        >
                                            {title}
                                        </Link>
                                        <img
                                            alt="Geolocation Button"
                                            src="/assets/theme/icons/GeolocationIcon.png"
                                            width="32"
                                            height="32"
                                            onClick={handleLocationModalShow}
                                        />
                                    </div>
                                    <Label className="" label={label}/>
                                    <Link
                                        to={sourceLink}
                                        className="truncate-text-2 WA-theme-main fw-bold mt-1"
                                    >
                                        {sourceLink}
                                    </Link>
                                    {annotationsVisible ? (
                                        <div className="card-title truncate-text-4 WA-theme-dark">
                                            {renderHighlightedText()}
                                        </div>
                                    ) : (
                                        <p className="card-text">{content}</p>
                                    )}

                                    {/* <p className="card-text">{renderHighlightedText()}</p> */}
                                    <div className="mb-2">{`Date: ${createdAtString}`}</div>
                                    <span className="m-3 d-flex justify-content-between">
                                    <span className="d-flex">
                                        <img
                                            alt="upvote icon"
                                            src="/assets/theme/icons/Upvote.png"
                                            width="32"
                                            height="32"
                                            style={{cursor: "pointer"}}
                                            onClick={handleUpvote}
                                        />
                                        <span className="WA-theme-positive fw-bold fs-6 me-5">
                                            {" "}{upvotes}{" "}
                                        </span>
                                        <img
                                            alt="downvote icon"
                                            src="/assets/theme/icons/Downvote.png"
                                            width="32"
                                            height="32"
                                            style={{cursor: "pointer"}}
                                            onClick={handleDownvote}
                                        />
                                        <span className="WA-theme-negative fw-bold fs-6"> {downvotes} </span>
                                        <span onClick={handleCreateCommentCardDisplay} style={{cursor: 'pointer'}}>
                                            <i className="bi bi-chat-left-text-fill WA-theme-main fs-4 ms-5"></i>
                                        </span>
                                    </span>
                                        {userData.id != enigmaUser.id
                                        ? <button className="btn btn-sm WA-theme-bg-main WA-theme-light" onClick={handleSuggestTagModalShow}>
                                                Suggest Tags
                                            </button>
                                        : <button className="btn btn-sm WA-theme-bg-main WA-theme-light" onClick={handleViewSuggestionsModalShow}>
                                                View Suggested Tags
                                        </button>
                                        }

                                </span>
                                </div>
                            </div>
                            <div className="col-3 container d-flex justify-content-start p-1 m-0 ">
                                <div className="vr my-3 col-1"></div>
                                <div
                                    className="mx-auto flex-fill align-self-center overflow-y-auto px-3 my-1"
                                    style={{maxHeight: "200px"}}
                                >
                                    {wikiTags.map((tag: any) => (
                                        <Tag className="" key={`${id}-${tag.id}`} label={tag.label}/>
                                    ))}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div className="">
                    {showCreateCommentCard &&
                        <CommentCreateCard content={commentContent} handleSubmit={handleCommentSubmit}
                                           handleInputChange={handleCreateCommentInputChange}/>
                    }
                    {comments
                        ? <div className="">
                            {[...comments].reverse().map((comment: Comment) => {
                                return <CommentCard key={comment.id} comment={comment} deleteComment={deleteComment}/>
                            })}
                        </div>
                        : <></>
                    }
                </div>
            </div>
            <div className="card WA-theme-bg-regular rounded-4 mb-3 mt-4 col-4 h-100">
                <div className="mb-3">
                    <label htmlFor="dropdown" className="form-label">
                        Select an option:
                    </label>
                    <select
                        id="dropdown"
                        className="form-select"
                        value={selectedOption}
                        onChange={handleDropdownChange}
                    >
                        <option value="" disabled>
                            Select an option
                        </option>
                        {uniqueSources.map((option) => (
                            <option key={option} value={option}>
                                {option}
                            </option>
                        ))}
                    </select>
                </div>
                <div className="mb-3">
                <label htmlFor="search" className="form-label">Search for an option:</label>
                    <input
                        type="text"
                        id="search"
                        className="form-control"
                        placeholder="Type to search..."
                        value={searchTerm}
                        onChange={handleSearchChange}
                    />
                </div>
                <div className="d-flex flex-column" style={{ height: '250px', maxHeight: '250px', minHeight: '250px', overflowY: 'auto' }}>
                    <table className="table">
                        <thead>
                        <tr>
                            <th style={{backgroundColor: "transparent"}}>Target</th>
                            <th style={{backgroundColor: "transparent"}}>Annotation</th>
                            <th style={{backgroundColor: "transparent"}}>Author</th>
                        </tr>
                        </thead>
                        <tbody>
                        {displayAnnotations.map((annotation, index) => (
                            <tr key={index}>
                                <td style={{backgroundColor: "transparent"}}>
                                    {content.slice(annotation.start, annotation.end)}
                                </td>
                                <td style={{backgroundColor: "transparent"}}>
                                    {annotation.note}
                                </td>
                                <td style={{backgroundColor: "transparent"}}>
                                    {annotation.username}
                                </td>
                            </tr>
                        ))}
                        </tbody>
                    </table>
                </div>
                <div
                    className="card rounded-4 mb-3 mt-4 sticky-bottom p-3"
                    style={{backgroundColor: "whitesmoke"}}
                >
                    <h4>Add Your Annotation</h4>
                    {
                        annotationsVisible
                            ? <h5>To add an annotation please &quot;Hide Highlighings&quot; first!</h5>
                            :
                            <>
                                <div className="mb-3">
                                    <label htmlFor="annotationInput" className="form-label">Annotate: {selectedText == "" ? "Please make a selection for annotation" : selectedText}</label>
                                    <input type="text" className="form-control" id="annotationInput" placeholder="Type your annotation here" onChange={handleInputChange} />
                                </div>
                                <button onClick={() => onAnnotate()} className={`btn btn-primary ${(selectedText == "" || selectedTextAnnotation == "") && "disabled"}`}>Add Annotation</button>
                            </>
                    }
                </div>
            </div>
            <LocationViewer
                showLocationViewerModal={locationModalShow}
                setShowLocationViewerModal={handleLocationModalShow}
                locationData={geolocation}
            ></LocationViewer>
            <SuggestTagModal handleSuggestTagModalShow={handleSuggestTagModalShow} suggestTagModalShow={suggestTagModalShow}
            entityId={id} entityType={1}/>
            {userData.id == enigmaUser.id
                ? <ViewSuggestionsModal viewSuggestionsModalShow={viewSuggestionsModalShow}
                                  handleViewSuggestionsModalShow={handleViewSuggestionsModalShow}
                                  entityType={"POST"}   entityId={id}/>
                : <></>
            }
        </div>
    );
};

export default DetailedPostCard;
