import React, { useState, useEffect } from 'react';
import AWS from 'aws-sdk';
import  DoubleArrow  from '@mui/icons-material/DoubleArrow';
import { recordData, getData } from '../queries/furkan.query';
const keyId = process.env.REACT_APP_AWS_KEY_ID;
const secret = process.env.REACT_APP_AWS_SECRET;
const region = process.env.REACT_APP_AWS_REGION;
AWS.config.update({
  accessKeyId: keyId,
  secretAccessKey: secret,
  region: region, // Replace with the desired AWS region
});
const translate = new AWS.Translate();

const TranslateApp = () => {
  const [sourceText, setSourceText] = useState('');
  const [translatedText, setTranslatedText] = useState('');
  const [translatedFileText, setTranslatedFileText] = useState('');
  const [file, setFile] = useState(null);
  const [languages, setLanguages] = useState([]);
  const [selectedLanguage, setSelectedLanguage] = useState('tr');
  const [selectedLanguageTarget, setSelectedLanguageTarget] = useState('en');
  const [selectedLanguageFile, setSelectedLanguageFile] = useState('tr');
  const [selectedLanguageTargetFile, setSelectedLanguageTargetFile] = useState('en');
  const [sampleTranslations, setSampleTranslations] = useState([])

  useEffect(() => {
    const fetchLanguages = async () => {
      try {
        const response = await translate.listLanguages().promise()
        const supportedLanguages = response.Languages || [];
        setLanguages(supportedLanguages);
      } catch (error) {
        console.error('Error fetching languages:', error);
      }
    };

    fetchLanguages();
  }, []);

  const sendData = async () => {
    recordData(sourceText)
  }

  const fetchData = async () => {
    const data = await getData()
    handleData(data)
  }

  const handleData = (data) => {
    const allSamples = []
    data.map(sample => {

      allSamples.push(sample.text.replace(/^\"+|\"+$/g, '').replace(/\\n/g, ""))
    })
    // Sort the old sentences based on similarity to the new sentence
    const sortedSamples = allSamples.sort((a, b) => {
      const similarityA = calculateLevenshteinDistance(a, sourceText);
      const similarityB = calculateLevenshteinDistance(b, sourceText);
      return similarityA - similarityB; // Sort in descending order
    });
    const uniqueSamples = [...new Set(sortedSamples)];

    setSampleTranslations(uniqueSamples)
  }

  const calculateLevenshteinDistance = (sentence1, sentence2) => {
    const m = sentence1.length;
    const n = sentence2.length;
    // Create a 2D matrix to store the distances
    const dp = [];
    for (let i = 0; i <= m; i++) {
      dp[i] = [];
      dp[i][0] = i;
    }
    for (let j = 0; j <= n; j++) {
      dp[0][j] = j;
    }
    // Calculate the minimum edit distance
    for (let i = 1; i <= m; i++) {
      for (let j = 1; j <= n; j++) {
        if (sentence1[i - 1] === sentence2[j - 1]) {
          dp[i][j] = dp[i - 1][j - 1];
        } else {
          dp[i][j] =
            1 +
            Math.min(dp[i - 1][j - 1], dp[i][j - 1], dp[i - 1][j]);
        }
      }
    }
    return dp[m][n];
  }

  const handleInputChange = (event) => {
    setSourceText(event.target.value);
  };

  const handleDrop = async (event) => {
    event.preventDefault();
    const droppedFile = event.dataTransfer.files[0];
    setFile(droppedFile);

    const reader = new FileReader();
    reader.onload = async () => {
      const content = reader.result;
      const translatedContent = await translateText(content);
      setTranslatedFileText(translatedContent);
    };
    reader.readAsText(droppedFile);
  };

  const handleDragOver = (event) => {
    event.preventDefault();
  };

  
  const handleDownload = () => {
    const element = document.createElement('a');
    const fileBlob = new Blob([translatedFileText], { type: 'text/plain' });
    element.href = URL.createObjectURL(fileBlob);
    element.download = 'translated.txt';
    element.click();
  };

  const translateText = async (text) => {
    const params = {
      SourceLanguageCode: selectedLanguageFile,
      TargetLanguageCode: selectedLanguageTargetFile,
      Text: text,
    };

    try {
      const translation = await translate.translateText(params).promise();
      return translation.TranslatedText;
    } catch (error) {
      console.error('Translation error:', error);
      return '';
    }
  };

  const handleTranslate = async () => {

    const params = {
      Text: sourceText,
      SourceLanguageCode: selectedLanguage,
      TargetLanguageCode: selectedLanguageTarget,
    };

    try {
      const translation = await translate.translateText(params).promise();
      setTranslatedText(translation.TranslatedText);
      sendData();
      fetchData();
    } catch (error) {
      console.error('Translation error:', error);
    }
  };

  const handleLanguageChange = (event) => {
    setSelectedLanguage(event.target.value);
  };

  const handleTargetLanguageChange = (event) => {
    setSelectedLanguageTarget(event.target.value);
  };

  const handleLanguageChangeFile = (event) => {
    setSelectedLanguageFile(event.target.value);
  };

  const handleTargetLanguageChangeFile = (event) => {
    setSelectedLanguageTargetFile(event.target.value);
  };

  return (
    <div style={{display: 'flex'}}>
      <div style={{marginRight: 200}}>
        <h1>Doodle Translate</h1>
        <div style={{display: 'flex', marginBottom: 25}}>
          <div>
            <h3>Source Language</h3>
            <select value={selectedLanguage} onChange={handleLanguageChange}>
              {languages.map((language) => (
                <option key={language.LanguageCode} value={language.LanguageCode}>
                  {language.LanguageName}
                </option>
              ))}
            </select>
          </div>
          <svg width={0} height={0}>
            <linearGradient id="linearColors" x1={0} y1={1} x2={1} y2={1}>
              <stop offset={0} stopColor="#9BA4B5" />
              <stop offset={1} stopColor="#212A3E" />
            </linearGradient>
          </svg>
          <DoubleArrow style={{margin: 'auto', fill: "url(#linearColors)", marginRight: 10, marginLeft: 10, fontSize: 50}}/>
          <div>
            <h3>Target Language</h3>
            <select value={selectedLanguageTarget} onChange={handleTargetLanguageChange}>
              {languages.map((language) => (
                <option key={language.LanguageCode} value={language.LanguageCode}>
                  {language.LanguageName}
                </option>
              ))}
            </select>
          </div>
          
        </div>
        <textarea
          placeholder="Enter text to translate"
          value={sourceText}
          onChange={handleInputChange}
        />
        <button style={{backgroundColor: '#3a568a', color: 'white', marginLeft: 15, padding: 10, borderRadius: 10}} onClick={handleTranslate}>Translate</button>
        <div>
          <h3>Translation:</h3>
          <p>{translatedText}</p>
        </div>
        <div>
          <h3>Similar Translations:</h3>
          {sampleTranslations.slice(0,100).map((sample, index) => 
            <div style={{display: 'flex'}}>
              <p key={index}>{sample}</p>
            </div>
          )}
        </div>
      </div>
      <div>
        <h1>Translate File</h1>
        <div style={{display: 'flex', marginBottom: 25}}>
          <div>
            <h3>Source Language</h3>
            <select value={selectedLanguageFile} onChange={handleLanguageChangeFile}>
              {languages.map((language) => (
                <option key={language.LanguageCode} value={language.LanguageCode}>
                  {language.LanguageName}
                </option>
              ))}
            </select>
          </div>
          <svg width={0} height={0}>
            <linearGradient id="linearColors" x1={0} y1={1} x2={1} y2={1}>
              <stop offset={0} stopColor="#9BA4B5" />
              <stop offset={1} stopColor="#212A3E" />
            </linearGradient>
          </svg>
          <DoubleArrow style={{margin: 'auto', fill: "url(#linearColors)", marginRight: 10, marginLeft: 10, fontSize: 50}}/>
          <div>
            <h3>Target Language</h3>
            <select value={selectedLanguageTargetFile} onChange={handleTargetLanguageChangeFile}>
              {languages.map((language) => (
                <option key={language.LanguageCode} value={language.LanguageCode}>
                  {language.LanguageName}
                </option>
              ))}
            </select>
          </div>
          
        </div>
        <svg width={0} height={0}>
          <linearGradient id="linearColors" x1={0} y1={1} x2={1} y2={1}>
            <stop offset={0} stopColor="#9BA4B5" />
            <stop offset={1} stopColor="#212A3E" />
          </linearGradient>
        </svg>
        <div style={{display: 'flex', justifyContent: 'space-between'}}>
        <DoubleArrow style={{transform: 'rotate(90deg)',margin: 'auto' ,marginBottom: 10, fill: "url(#linearColors)", fontSize: 50}}/>
        <DoubleArrow style={{transform: 'rotate(90deg)',margin: 'auto' ,marginBottom: 10, fill: "url(#linearColors)", fontSize: 50}}/>

        </div>
        <div
          className="drop-area"
          onDrop={handleDrop}
          onDragOver={handleDragOver}
          style={{backgroundColor: '#3a568a', width: 400, padding: 15, borderRadius: 10, 
          display: 'flex', alignItems: 'center', justifyContent: 'center', marginBottom: 20}}
        >
          <p style={{color: 'white', textAlign: 'center'}}>Drag and drop your file here.</p>
        </div>
        {translatedFileText && (
          <div>
            <button onClick={handleDownload}>Download Translated File</button>
          </div>
        )}
      </div>
    </div>
  );
};

export default TranslateApp;
