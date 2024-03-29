import React, { useEffect, useState } from 'react';
import { Box, Button, Divider, Skeleton, Table, Typography } from '@mui/material';

function Orkun() {
  // Call ipapi.co
  const [data, setData] = useState();
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);

  // Save IP
  const [ipToSave, setIpToSave] = useState();
  const [ipToSaveLoading, setIpToSaveLoading] = useState(false);
  const [ipToSaveError, setIpToSaveError] = useState(false);
  const [ipToSaveData, setIpToSaveData] = useState();

  // Get saved IPs for the table
  const [savedIPs, setSavedIPs] = useState([]);
  const [savedIPsLoading, setSavedIPsLoading] = useState(true);
  const [savedIPsError, setSavedIPsError] = useState(false);

  // Search IP
  const [ipToSearch, setIpToSearch] = useState('');
  const [ipToSearchLoading, setIpToSearchLoading] = useState(false);
  const [ipToSearchError, setIpToSearchError] = useState(false);
  const [ipToSearchData, setIpToSearchData] = useState();

  const saveLocation = async () => {
    setIpToSaveLoading(true);
    setIpToSaveError(false);

    try {
      const res = await fetch(`/api/ip`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
      });
      const response = await res.json();
      if (response.status === 200) {
        setIpToSaveData(response);
        setIpToSaveError(null);
      } else {
        setIpToSaveError(response.error);
        setIpToSaveData(null);
      }
    } catch (err) {
      setIpToSaveError(true);
    }

    setIpToSaveLoading(false);
  }

  const handleSearch = async () => {
    setIpToSearchLoading(true);
    setIpToSearchError(false);

    if (!ipToSearch) {
      setIpToSearchError("Please enter an IP address");
      setIpToSearchData(null);
      setIpToSearchLoading(false);
      return;
    }

    try {
      const res = await fetch(`/api/ip/details/${ipToSearch}`);
      const data = await res.json();
      setIpToSearchData(data);
      setIpToSearchError(null);
    } catch (err) {
      setIpToSearchError("IP address not found");
      setIpToSearchData(null);
    }

    setIpToSearchLoading(false);
  }

  useEffect(() => {
    const callAPI = async () => {
      const res = await fetch(`/api/ip/all`);
      const data = await res.json();
      return data;
    }
    callAPI()
    .then(res => {
      setSavedIPs(res);
      setSavedIPsLoading(false);
      setSavedIPsError(null);
    })
    .catch(err => {
      setSavedIPsError(true);
      setSavedIPsLoading(false);
      setSavedIPs([]);
    });
  }, [ipToSaveData]);

    
  useEffect(() => {
    const callAPI = async () => {
      const res = await fetch('https://ipapi.co/json/');
      const data = await res.json();
      return data;
    }
    callAPI()
    .then(res => {
      setData({
        ip: res.ip,
        city: res.city,
        country: res.country_name,
      });
      setLoading(false);
    })
    .catch(err => {
      setError(true);
      setLoading(false);
    });
  }, []);


  return (
    <div>
      <Typography variant="h1">Location from IP address</Typography>
      <Divider sx={{ my: 4 }} />
      {loading && (
        <>
          <Skeleton variant="text" sx={{ fontSize: 32, width: '300px' }} animation="wave" />
          <Skeleton variant="text" sx={{ fontSize: 32, width: '300px' }} animation="wave" />
          <Skeleton variant="text" sx={{ fontSize: 32, width: '300px' }} animation="wave" />
          <Skeleton variant="rectangular" sx={{ width: 150, height: 40, mt: 6 }} animation="wave" />
        </>
      )}
      {error && (
        <>
          <Typography variant="h4">Error</Typography>
          <Typography variant="p">Please try again later</Typography>
        </>
      )}
      {data && (
        <>
          <Typography variant="h4"><span style={{ fontWeight:'bold' }}>IP:</span> {data.ip}</Typography>
          <Typography variant="h4"><span style={{ fontWeight:'bold' }}>City:</span> {data.city}</Typography>
          <Typography variant="h4"><span style={{ fontWeight:'bold' }}>Country:</span> {data.country}</Typography>

          <Button variant="contained" color="primary" sx={{ mt: 4 }} onClick={saveLocation} disabled={ipToSaveLoading}> Save Location </Button>
          {ipToSaveLoading && (
            <Skeleton variant="rectangular" sx={{ width: 150, height: 40, mt: 6 }} animation="wave" />
          )}
          {ipToSaveError && (
            <>
              <Typography display={'block'} mt={2} variant="p">Error</Typography>
              <Typography display={'block'} variant="p">Please try again later</Typography>
              <Typography display={'block'} variant="body1">Error: {JSON.stringify(ipToSaveError)}</Typography>
            </>
          )}
          {ipToSaveData && (
            <>
              <Typography display={'block'} mt={2} variant="p">Saved!</Typography>
            </>
          )}
        </>
      )}
      <Divider sx={{ my: 4 }} />
      <Box sx={{ width: '100%', display: 'flex', flexDirection: 'row', justifyContent: 'around', alignItems: 'start' }}>
        <Table sx={{ width: '50%' }}>
          <thead>
            <tr>
              <th>IP</th>
              <th>City</th>
              <th>Country</th>
            </tr>
          </thead>
          <tbody>
            {savedIPsLoading && (
              <tr>
                <td colSpan="3">
                  <Skeleton variant="rectangular" sx={{ width: '100%', height: 40 }} animation="wave" />
                </td>
              </tr>
            )}
            {savedIPsError && (
              <tr>
                <td colSpan="3">
                  <Typography variant="h4">Error</Typography>
                </td>
              </tr>
            )}
            {savedIPs.map((ip, index) => (
              <tr key={index}>
                <td style={{textAlign: 'center'}}>{ip.ip}</td>
                <td style={{textAlign: 'center'}}>{ip.city}</td>
                <td style={{textAlign: 'center'}}>{ip.country}</td>
              </tr>
            ))}
          </tbody>
        </Table>

        <Box sx={{width: '100%', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>
          <Typography variant="h4">Search IP</Typography>
          <Box sx={{ width: '100%', display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: 'center' }}>
            <input type="text" placeholder="IP address" value={ipToSearch} onChange={(e) => setIpToSearch(e.target.value)} style={{ width: '25%', height: '40px', border: '1px solid #ccc', borderRadius: '5px', padding: '0 10px', marginTop: '10px', marginBottom: '10px' }} />
            <Button variant="contained" color="primary" onClick={handleSearch} sx={{ mt: 1, mb: 4 }}>Search</Button>

            {ipToSearchLoading && (
              <Skeleton variant="rectangular" sx={{ width: 150, height: 40, mt: 6 }} animation="wave" />
            )}
            {ipToSearchError && (
              <Typography variant="body1">Error: {JSON.stringify(ipToSearchError)}</Typography>
            )}
            {ipToSearchData && (
              <>
                <Typography variant="p"><span style={{ fontWeight:'bold' }}>IP:</span> {ipToSearchData.ip}</Typography>
                <Typography variant="p"><span style={{ fontWeight:'bold' }}>City:</span> {ipToSearchData.city}</Typography>
                <Typography variant="p"><span style={{ fontWeight:'bold' }}>Country:</span> {ipToSearchData.country}</Typography>
              </>
            )}
          </Box>
        </Box>
      </Box>
    </div>
  );
}

export default Orkun;
