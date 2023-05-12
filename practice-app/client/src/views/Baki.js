import React, {useState, useEffect, useRef} from 'react';
import Autocomplete from '@mui/material/Autocomplete';
import TextField from '@mui/material/TextField';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import LinearProgress from '@mui/material/LinearProgress';
import {  useWikiSearchOptions, useWikiEntity, useWikiProperties, useBookmarks , useCreateEntityMutation, useDeleteAllBookmarksMutation, useDeleteBookmarkMutation} from '../queries/baki.query';
import dayjs from 'dayjs';
import IconButton from '@mui/material/IconButton';
import ListItem from '@mui/material/ListItem';
import { ListItemButton } from '@mui/material';
import List from '@mui/material/List';
import Link from '@mui/material/Link';
import ListItemText from '@mui/material/ListItemText';
import { useMutation } from 'react-query';


import BookmarkIcon from '@mui/icons-material/Bookmark';
import BookmarkBorderIcon from '@mui/icons-material/BookmarkBorder';

const allowedDataTypes = [

    "wikibase-item",
    "wikibase-property",
    "string",
    "url",
    "commonsMedia",
    "time",
    // "quantity",
    "monolingualtext",
    "globe-coordinate",

];

function Baki() { 

    const [searchOptionsQuery, searchInput, setSearchInput] = useWikiSearchOptions();
    const [entityQuery, id, setId] = useWikiEntity();
    const [propertiesQuery, ids, setIds] = useWikiProperties();
    const bookmarksQuery = useBookmarks();
    const deleteAllBookmarks = useDeleteAllBookmarksMutation();
    const deleteBookmarkByCode = useDeleteBookmarkMutation();
    const createBookmark= useCreateEntityMutation();


    const [bookmarked, setBookmarked] = useState(true);


    useEffect(() => {

        if(entityQuery?.data){

            setIds( Object.keys(entityQuery?.data[id]?.claims).slice(0, Math.min(50,Object.keys(entityQuery?.data[id]?.claims).length )).filter((id) => id!=null && id!=undefined && id.length>0).join("|"));
        }   
    }, [entityQuery.data])


    // useEffect(() => {

    //     if(isSuccess){

    //         bookmarksQuery.refetch();
    //     }

    // }, [isLoading])


  

    const handleClick = () => {


    if(bookmarksQuery.data?.find((bookmark) => bookmark.code === id)){

        deleteBookmarkByCode(bookmarksQuery.data?.find((bookmark) => bookmark.code === id)?.code);

    }else{

        const entityData = {
        
            label: entityQuery?.data[id]?.labels?.en?.value,
            code: id,
        };

        createBookmark(entityData);
    }

  };

    console.log("bookemarks", bookmarksQuery?.data);

    return (
        <Box style={{display:"flex", flexDirection:"row", minHeight:"calc(100vh - 150px"}}>
            {/* <div>{`value: ${id !== null ? `'${id}'` : 'null'}`}</div>
            <div>{`inputValue: '${searchInput}'`}</div> */}

            <div style={{flex:"1"}}>
            <Autocomplete
                options={searchOptionsQuery.data ? searchOptionsQuery.data : []  }
                renderInput={(params) =>  <TextField {...params} label="Search" variant="outlined" >AAA</TextField>}
                onInputChange={(event, newInputValue) => {
                    setSearchInput(newInputValue);
                }}
                onChange={(event, newValue) => {
                    setId(newValue?.id);
                    setIds("");
                }}

                // getOptionLabel={(option) => option.label}

                // getOptionLabel={(option) => {
                //     return<div>
                //     <Typography variant="body1"><b>{option.label}</b></Typography>
                //      <Typography variant="body2">{option.description}</Typography>
                //     </div>
                // }
                // }

                  renderOption={(props,option) => (
                    <li {...props} ><div><div><b>{option.label}</b></div><div>{option.description}</div></div></li>
                )}
                //  renderOption={(option) => (
                //     <div>
                //     <Typography variant="body1">A</Typography>
                //     <Typography variant="body2">B</Typography>
                //     </div>
                // )} 
                inputValue={searchInput}
                clearOnBlur={false}              
                filterOptions={(options, state) => { return options; }}
                />  
            <Box style={{marginTop:"20px"}}> 
                {( id?.length  && (entityQuery.isLoading || !ids?.length || propertiesQuery.isLoading) ) ? <LinearProgress/>:
                <div>
                <div style={{border:"1px solid lightgray", borderRadius:"10px", padding:"15px", marginBottom:"20px", position: 'relative' }}>
                {id && <IconButton onClick={handleClick} style={{position:"absolute", right:10, top:10}}>{ bookmarksQuery?.data?.find((bookmark) => bookmark.code == id) ? <BookmarkIcon></BookmarkIcon>  : <BookmarkBorderIcon></BookmarkBorderIcon> }</IconButton>}
                <Typography key={0 }> <span style={{display:"inline-block", width:"300px", paddingTop:"5px", paddingBottom:"5px"}}><b>ID:</b></span> {entityQuery?.data && entityQuery?.data[id]?.title}</Typography>
                <Typography key={1 }> <span style={{display:"inline-block", width:"300px", paddingTop:"5px", paddingBottom:"5px"}}><b>Label:</b></span><b>{entityQuery?.data&& entityQuery?.data[id]?.labels?.en?.value}</b></Typography>
                <Typography key={2 }> <span style={{display:"inline-block", width:"300px", paddingTop:"5px", paddingBottom:"5px"}}><b>Description:</b></span>{entityQuery?.data && entityQuery?.data[id]?.descriptions?.en?.value}</Typography>
                <Typography key={3 }> <span style={{display:"inline-block", width:"300px", paddingTop:"5px", paddingBottom:"5px"}}><b>Last Modified:</b></span>{id && dayjs(entityQuery?.data && entityQuery?.data[id]?.modified).format("DD MMM YYYY HH:mmZ")}</Typography>
                </div>
                    <div style={{border:"1px solid lightgray", borderRadius:"10px", padding:"15px"}}>
                    {
                        entityQuery?.data ? Object.keys(entityQuery?.data[id]?.claims).slice(0, Math.min(50,Object.keys(entityQuery?.data[id]?.claims).length )).map((propId )=>
                        {   
                            return  <Typography key={propId}> <span style={{display:"inline-block", width:"300px", paddingTop:"5px", paddingBottom:"5px"}}><b>{propertiesQuery?.data ? propertiesQuery?.data[propId]?.labels?.en?.value : propId }:</b></span>
                            <i>{entityQuery?.data[id]?.claims[propId][0].mainsnak.datatype}</i>
                            (
                                { 
                                    entityQuery?.data[id]?.claims[propId][0].mainsnak.datatype=="wikibase-item" ? <Link style={{cursor:"pointer"}} onClick={()=> {   
                                        
                                        if(entityQuery?.data[id]?.claims[propId][0]?.mainsnak?.datavalue?.value?.id != id){

                                             setIds(""); setId(entityQuery?.data[id]?.claims[propId][0]?.mainsnak?.datavalue?.value?.id)}} 
                                        }
                                         >{entityQuery?.data[id]?.claims[propId][0]?.mainsnak?.datavalue?.value?.id} 
                                        
                                       </Link> : 

                                        (entityQuery?.data[id]?.claims[propId][0].mainsnak.datatype=="wikibase-property" ? <Link  style={{cursor:"pointer"}}  onClick={()=> {  setIds(""); setId(entityQuery?.data[id]?.claims[propId][0]?.mainsnak?.datavalue?.value?.id)}} >{entityQuery?.data[id]?.claims[propId][0]?.mainsnak?.datavalue?.value?.id} </Link> :

                                            ( entityQuery?.data[id]?.claims[propId][0].mainsnak.datatype=="time" ? entityQuery?.data[id]?.claims[propId][0]?.mainsnak?.datavalue?.value?.time : 
                                            
                                                (entityQuery?.data[id]?.claims[propId][0].mainsnak.datatype== "string" ? entityQuery?.data[id]?.claims[propId][0]?.mainsnak?.datavalue?.value : 
                                                
                                                    (entityQuery?.data[id]?.claims[propId][0].mainsnak.datatype== "quantity" ? entityQuery?.data[id]?.claims[propId][0]?.mainsnak?.datavalue?.value?.amount :
                                                    
                                                        (entityQuery?.data[id]?.claims[propId][0].mainsnak.datatype== "monolingualtext" ? entityQuery?.data[id]?.claims[propId][0]?.mainsnak?.datavalue?.value?.text :

                                                            (entityQuery?.data[id]?.claims[propId][0].mainsnak.datatype== "globe-coordinate" ?  ( "lat: "+ entityQuery?.data[id]?.claims[propId][0]?.mainsnak?.datavalue?.value?.latitude + " long: " + entityQuery?.data[id]?.claims[propId][0]?.mainsnak?.datavalue?.value?.longitude) :
                                                                
                                                                entityQuery?.data[id]?.claims[propId][0]?.mainsnak?.datavalue?.value 
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                }
                            )
                            </Typography>
                            
                        }) : null
                    
                    }
                    </div>
                </div>
                }
            </Box>
            </div>

            <div style={{flexShrink:0, flexGrow:0, width:"300px", border:"1px solid lightgray", borderRadius:"10px", padding:"15px", marginLeft:"20px"}}>
                Bookmarks

                <List>
                {
                    bookmarksQuery?.data?.map((bookmark) => {

                        return <ListItemButton
                                // selected={selectedIndex === 0}
                                     onClick={() => { 
                                        if(bookmark?.code != id){
                                            
                                            setIds(""); setId(bookmark?.code);
                                            
                                        }
                                        
                                      }}
                                >
                                    <ListItemText
                                        primary={bookmark?.label}
                                        secondary={bookmark?.code}
                                    />
                                </ListItemButton>
                

                    })
                }
                </List>
            </div>
        </Box>
    );
}

export default Baki;