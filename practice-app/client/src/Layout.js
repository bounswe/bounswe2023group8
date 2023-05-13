import * as React from 'react';
import { styled, useTheme } from '@mui/material/styles';
import Box from '@mui/material/Box';
import Drawer from '@mui/material/Drawer';
import CssBaseline from '@mui/material/CssBaseline';
import MuiAppBar from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import List from '@mui/material/List';
import Typography from '@mui/material/Typography';
import Divider from '@mui/material/Divider';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import ChevronRightIcon from '@mui/icons-material/ChevronRight';
import ListItem from '@mui/material/ListItem';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import InboxIcon from '@mui/icons-material/MoveToInbox';
import MailIcon from '@mui/icons-material/Mail';
import FaceIcon from '@mui/icons-material/Face';
import Face4Icon from '@mui/icons-material/Face4';
import GitHubIcon from '@mui/icons-material/GitHub';
import HelpIcon from '@mui/icons-material/Help';

const drawerWidth = 240;

const Main = styled('main', { shouldForwardProp: (prop) => prop !== 'open' })(
  ({ theme, open }) => ({
    flexGrow: 1,
    padding: theme.spacing(3),
    transition: theme.transitions.create('margin', {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.leavingScreen,
    }),
    marginLeft: `-${drawerWidth}px`,
    ...(open && {
      transition: theme.transitions.create('margin', {
        easing: theme.transitions.easing.easeOut,
        duration: theme.transitions.duration.enteringScreen,
      }),
      marginLeft: 0,
    }),
  }),
);

const AppBar = styled(MuiAppBar, {
  shouldForwardProp: (prop) => prop !== 'open',
})(({ theme, open }) => ({
  transition: theme.transitions.create(['margin', 'width'], {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  ...(open && {
    width: `calc(100% - ${drawerWidth}px)`,
    marginLeft: `${drawerWidth}px`,
    transition: theme.transitions.create(['margin', 'width'], {
      easing: theme.transitions.easing.easeOut,
      duration: theme.transitions.duration.enteringScreen,
    }),
  }),
}));

const groupMembers = [

  {
    name: 'Hasan Baki Kucukcakiroglu',
    short: "Hasan Baki",
    gender: "male",
    to: "baki"
  },
  {
    name: 'Begüm Yivli',
    short: "Begüm",
    gender: "female",
    to: "begum"
  },
  {
    name: 'Egemen Kaplan',
    short: "Egemen",
    gender: "male",
    to: "egemen"

  },
  {
    name: 'Bahadir Gezer',
    short: "Bahadir",
    gender: "male",
    to: "bahadir"

  },
  {
    name: 'Orkun Kilic',
    short: "Orkun",
    gender: "male",
    to: "orkun"
  },
  {
    name: 'Bahri Alabey',
    short: "Bahri",
    gender: "male",
    to: "bahri"
  },
  {
    name: 'Enes Yildiz',
    short: "Enes",
    gender: "male",
    to: "enes"
  },
  {
    name: 'Ibrahim Furkan Ozcelik',
    short: "Furkan",
    gender: "male",
    to: "furkan"
  },
  {
    name: 'Meric Keskin',
    short: "Meric",
    gender: "male",
    to: "meric"

    
  },
  {
    name: 'Mirac Ozturk',
    short: "Mirac",
    gender: "female",
    to: "mirac"
  },
  {
    name: 'Sude Konyalioglu',
    short: "Sude",
    gender: "female",
    to: "sude"
  },
  {
    name: 'Omer Faruk Celik',
    short: "Omer",
    gender: "male",
    to: "omer"

  },
];  

const DrawerHeader = styled('div')(({ theme }) => ({
  display: 'flex',
  alignItems: 'center',
  padding: theme.spacing(0, 1),
  // necessary for content to be below app bar
  ...theme.mixins.toolbar,
  justifyContent: 'flex-end',
}));

export default function Layout(props) {
  const theme = useTheme();
  const [open, setOpen] = React.useState(true);

  const handleDrawerOpen = () => {
    setOpen(true);
  };

  const handleDrawerClose = () => {
    setOpen(false);
  };

  return (
    <Box sx={{ display: 'flex' }}>
      <CssBaseline />
      <AppBar position="fixed" open={open}>
        <Toolbar>
          <IconButton
            color="inherit"
            aria-label="open drawer"
            onClick={handleDrawerOpen}
            edge="start"
            sx={{ mr: 2, ...(open && { display: 'none' }) }}
          >
            <MenuIcon />
          </IconButton>
          <Typography variant="h6" noWrap component="div">
            APIs
          </Typography>
        </Toolbar>
      </AppBar>
      <Drawer
        sx={{
          width: drawerWidth,
          flexShrink: 0,
          '& .MuiDrawer-paper': {
            width: drawerWidth,
            boxSizing: 'border-box',
          },
        }}
        variant="persistent"
        anchor="left"
        open={open}
      >
        <DrawerHeader>
          <IconButton onClick={handleDrawerClose}>
            {theme.direction === 'ltr' ? <ChevronLeftIcon /> : <ChevronRightIcon />}
          </IconButton>
        </DrawerHeader>
        <Divider />
        <List>
          { groupMembers.sort((a, b) => a.short.localeCompare(b.short)).map((member) => (
            <ListItem key={member.name} disablePadding onClick={() => window.location.href='/'+ member.to}>
              <ListItemButton>
                <ListItemIcon>
                  {member.gender == "male" ? <FaceIcon/> : <Face4Icon/>}
                </ListItemIcon>
                <ListItemText primary={member.short} />
              </ListItemButton>
            </ListItem>
          ))}
        </List>
        <Divider />
        <List>
          
          <ListItem key={"github"} disablePadding onClick={() => window.location.href='https://github.com/bounswe/bounswe2023group8'}>
            <ListItemButton>
              <ListItemIcon>
                <GitHubIcon/>
              </ListItemIcon>
              <ListItemText primary={"GitHub"} />
            </ListItemButton>
          </ListItem>
          <ListItem key={"help"} disablePadding>
            <ListItemButton>
              <ListItemIcon>
                <HelpIcon/>
              </ListItemIcon>
              <ListItemText primary={"Help"} />
            </ListItemButton>
          </ListItem>
          
        </List>
      </Drawer>
      <Main  open={open} style={{marginTop:"68px"}}>
        
            {props.children}
      </Main>
    </Box>
  );
}