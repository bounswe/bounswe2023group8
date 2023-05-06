import React from 'react';
import { BrowserRouter as Router, Route, Routes,  Navigate  } from 'react-router-dom';
import Layout from './Layout';
import Baki from './views/Baki';
import Egemen from './views/Egemen';
import Begum from './views/Begum';
import Sude from './views/Sude';
import Furkan from './views/Furkan';
import Meric from './views/Meric';
import Mirac from './views/Mirac';
import Orkun from './views/Orkun';
import Bahri from './views/Bahri';
import Enes from './views/Enes';
import Bahadir from './views/Bahadir';
import Omer from './views/Omer';


function App() {

  return (
    <Router>
      <Routes>
        <Route path="/" element={<Layout></Layout>} />
        <Route path="/baki" element={<Layout><Baki/></Layout>} />
        <Route path="/egemen" element={<Layout><Egemen/></Layout>} />
        <Route path="/begum" element={<Layout><Begum/></Layout>} />
        <Route path="/sude" element={<Layout><Sude/></Layout>} />
        <Route path="/furkan" element={<Layout><Furkan/></Layout>} />
        <Route path="/meric" element={<Layout><Meric/></Layout>} />
        <Route path="/mirac" element={<Layout><Mirac/></Layout>} />
        <Route path="/orkun" element={<Layout><Orkun/></Layout>} />
        <Route path="/bahri" element={<Layout><Bahri/></Layout>} />
        <Route path="/enes" element={<Layout><Enes/></Layout>} />
        <Route path="/bahadir" element={<Layout><Bahadir/></Layout>} />
        <Route path="/omer" element={<Layout><Omer/></Layout>} />
        <Route path="*" element={<Navigate to="/" />}/>
      </Routes>
    </Router>
  );
}

export default App;