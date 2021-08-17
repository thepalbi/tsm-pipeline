
import path from 'path';
import React from 'react';
import Head from 'next/head'
import { App, AppProps, PredictionInfo } from '../components/App';

export default function Home(props: { predictions: PredictionInfo[] }) {
  return (
    <div className="container">
      <Head>
        <title>TSM Prediction Triager</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <React.StrictMode>
        <App {...AppProps.fromPredictions(props.predictions)} />
      </React.StrictMode>
    </div>
  )
}

export async function getStaticProps() {
  let predictions = path.join(process.cwd(), 'data', 'predictions.json.updated');
  return {
    props: {
      predictions: JSON.parse(require('fs').readFileSync(predictions, 'utf8'))
    }
  }
}