import React from 'react';
import { useState } from 'react';
import Highlight from 'react-highlight';
import styles from './App.module.css';
import { v4 as uuid } from 'uuid';

declare var process: {
  env: {
    NEXT_PUBLIC_SIMILARITY_SERVER: string
  }
};

type LocationProps = {
  projectName: string;
  path: string;
  startLine: number;
  startColumn: number;
  endLine: number;
  endColumn: number;
}

function locString(loc: LocationProps) {
  return `${loc.projectName}||file:///opt/src/${loc.path}:${loc.startLine}:${loc.startColumn}:${loc.endLine}:${loc.endColumn}`
}

function Location(props: LocationProps) {
  if (props.projectName.startsWith("g/")) {
    return (
      <a href={`https://github.com/${props.projectName.slice(2)}/blob/master/${props.path}#L${props.startLine}`} target="_blank" rel="noopener noreferrer">
        {props.projectName}/{props.path}#L{props.startLine}
      </a>
    );
  } else {
    return <span>{props.projectName}/{props.path}#L{props.startLine}</span>
  }
}

type RepresentationProps = {
  repr: string;
};

function Representation(props: RepresentationProps) {
  return (
    <span>representation <code>{props.repr}</code></span>
  );
}

type ScoreProps = {
  score: number;
}

function Score(props: ScoreProps) {
  return (
    <span>score {props.score}</span>
  );
}

function abbrev(s: string) {
  if (s.length > 100)
    return s.substr(0, 100) + '...';
  return s;
}

type ContextLineProps = {
  text: string;
}

function ContextLine(props: ContextLineProps) {
  return (
    <span >{abbrev(props.text) + '\n'}</span>
  );
}

type HighlightedLineProps = {
  before: string;
  highlight: string;
  after: string;
}

function HighlightedLine(props: HighlightedLineProps) {
  return (
    <span>
      {abbrev(props.before)}
      <span className={styles['sink-prediction']}>{abbrev(props.highlight)}</span>
      {abbrev(props.after)}
      {'\n'}
    </span>
  );
}

type SnippetProps = {
  beforeLines: string[];
  before: string;
  highlight: string;
  after: string;
  afterLines: string[];
  banned: boolean;
}

function Snippet(props: SnippetProps) {
  return (
    <div style={{ textDecoration: props.banned ? "line-through" : "none" }}>
      <Highlight className="javascript">
        {props.beforeLines.map(l => <ContextLine text={l} />)}
        <HighlightedLine before={props.before} highlight={props.highlight} after={props.after} />
        {props.afterLines.map(l => <ContextLine text={l} />)}
      </Highlight>
    </div>
  );
}

type PredictionProps = {
  location: LocationProps;
  locationEnclosingStm: LocationProps;
  locationEnclosingFunc: LocationProps;
  repr: string;
  score: number;
  snippet: SnippetProps;
  banned: boolean;
  toggleThisPrediction: () => void;
  toggleSimilarPredictions: () => void;
}

function Prediction(props: PredictionProps) {
  return (
    <li>
      <ToggleThisPredictionButton banned={props.banned} toggleBanned={props.toggleThisPrediction} />
      {
        process.env.NEXT_PUBLIC_SIMILARITY_SERVER ?
          <ToggleSimilarPredictionsButton banned={props.banned} toggleBanned={props.toggleSimilarPredictions} />
          :
          <span />
      }
      <Location {...props.location} />: <Representation repr={props.repr} />, <Score score={props.score} />
      <Snippet {...props.snippet} banned={props.banned} />
    </li>
  );
}

function ToggleThisPredictionButton(props: {
  banned: boolean,
  toggleBanned: () => void
}) {
  return (
    <button onClick={props.toggleBanned}>{
      props.banned ? "unban" : "ban"
    }</button>
  );
}

function ToggleSimilarPredictionsButton(props: {
  banned: boolean,
  toggleBanned: () => void
}) {
  return (
    <button onClick={props.toggleBanned}>{
      props.banned ? "unban similar" : "ban similar"
    }</button>
  );
}

function PredictionList(props: {
  predictions: PredictionProps[];
}) {
  return (
    <ul>
      {props.predictions.map(p => {
        let { projectName, path, startLine, startColumn } = p.location;
        let key = projectName + ':' + path + ':' + startLine + ':' + startColumn;
        return <Prediction {...p} key={key} />;
      })}
    </ul>
  );
}

type RepresentationSelectionProp = {
  repr: string;
  id: string;
  count: number;
  selected: boolean;
  onClick: () => void;
}

function RepresentationSelection(props: RepresentationSelectionProp) {
  return (
    <li>
      <input
        type="checkbox"
        id={props.id}
        checked={props.selected}
        onChange={() => props.onClick()} />
      <label htmlFor={props.id}><code>{props.repr}</code> ({props.count} predictions)</label>
    </li>
  );
}

type RepresentationSelectionListProps = {
  reprs: RepresentationSelectionProp[];
}

function RepresentationSelectionList(props: RepresentationSelectionListProps) {
  return (
    <ul className={styles['representation-selection-list']}>
      {props.reprs.map(repr => <RepresentationSelection {...repr} key={repr.id} />)}
    </ul>
  );
}

type PredictionId = string;

export type PredictionInfo = {
  id: PredictionId;
  location: LocationProps;
  locationEnclosingStm: LocationProps;
  locationEnclosingFunc: LocationProps;
  repr: string;
  score: number;
  snippet: SnippetProps;
  banned: boolean;
  similarBanned: boolean;
}

type ReprInfo = {
  repr: string;
  count: number;
}

export class AppProps {
  constructor(
    public reprs: ReprInfo[],
    public predictions: PredictionInfo[],
  ) { }

  static fromPredictions(predictions: PredictionInfo[]) {
    const reprs: Map<string, ReprInfo> = new Map();

    // Populate predictions identifiers
    predictions.forEach((p) => {
      p.id = uuid() as PredictionId;
    });

    for (const pred of Array.from(predictions.values())) {
      let reprInfo = reprs.get(pred.repr);
      if (reprInfo === undefined) {
        reprInfo = { repr: pred.repr, count: 0 };
        reprs.set(pred.repr, reprInfo);
      }
      reprInfo.count++;
    }

    return new AppProps(Array.from(reprs.values()), predictions.slice());
  }
};

type TriagerSimilarResponseItem = {
  score: number,
  location: LocationProps;
}

type AppState = {
  // indicates for each representation whether it is enabled or not
  enabledReprs: Map<string, boolean>;
  // all predictions whose representation is enabled, that is, their representation is enabled
  // and their score exceeds the minimum score
  enabledPredictions: PredictionId[];
  // indicates for each prediction whether it is banned or not
  bannedPredictions: Map<PredictionId, boolean>;
  // cache associating each prediction with all other predictions it is similar to
  similarPredictionsCache: Map<PredictionId, Set<PredictionId>>;
  // first prediction to show (1-based)
  from: number;
  // last prediction to show (1-based)
  to: number;
  // minimum score for a prediction to be enabled
  minScore: number;
  // whether or not to display banned predictions
  hideBannedPredictions: boolean;
}

export class App extends React.Component<AppProps, AppState> {
  constructor(props: AppProps) {
    super(props);

    let minScore = 0.5;

    let numPredictions = props.predictions.length;

    const enabledReprs = new Map();
    for (const repr of props.reprs)
      enabledReprs.set(repr.repr, repr.count < 0.1 * numPredictions);

    const enabledPredictions: PredictionId[] = [];
    for (const pred of props.predictions)
      if (enabledReprs.get(pred.repr) && pred.score >= minScore)
        enabledPredictions.push(pred.id);

    this.state = {
      enabledReprs,
      enabledPredictions,
      bannedPredictions: new Map(),
      similarPredictionsCache: new Map(),
      from: 1,
      to: Math.min(100, enabledPredictions.length),
      minScore,
      hideBannedPredictions: false,
    };
  }

  getPredictionInfo(id: PredictionId): PredictionInfo {
    return this.props.predictions.find(p => p.id === id);
  }

  private async getSimilarPredictions(predictionId: PredictionId) : Promise<Set<PredictionId>> {
    if (this.state.similarPredictionsCache.has(predictionId))
      return this.state.similarPredictionsCache.get(predictionId);

    if (!process.env.NEXT_PUBLIC_SIMILARITY_SERVER)
      return new Set();

    const { repr, locationEnclosingStm: locStm, locationEnclosingFunc: locFunc } = this.getPredictionInfo(predictionId);
    try {
      const resp = await fetch(`${process.env.NEXT_PUBLIC_SIMILARITY_SERVER}/similar`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: JSON.stringify({ repr, locStm, locFunc }),
        mode: "cors"
      });
      const responseItems: TriagerSimilarResponseItem[] = await resp.json();
      const similarLocs = new Set(responseItems.map(s => locString(s.location)));
      const similarPredictions = new Set<PredictionId>();
      for (const prediction of this.props.predictions) {
        if (similarLocs.has(locString(prediction.location)))
          similarPredictions.add(prediction.id);
      }
      for (const similarPrediction of similarPredictions) {
        this.state.similarPredictionsCache.set(similarPrediction, similarPredictions);
      }
      return similarPredictions;
    } catch (err) {
      console.error(`Error calling triager backend: {err}.`);
    }

    return new Set();
  }

  private async toggleSimilarPredictions(predId: PredictionId) {
    const bannedPredictions = new Map(this.state.bannedPredictions);
    const newState = !bannedPredictions.get(predId);
    bannedPredictions.set(predId, newState);
    for (const similarPredId of await this.getSimilarPredictions(predId)) {
      bannedPredictions.set(similarPredId, newState);
    }

    this.setState({
      bannedPredictions
    })
  }

  private togglePrediction(predId: PredictionId) {
    const bannedPredictions = new Map(this.state.bannedPredictions);
    bannedPredictions.set(predId, !bannedPredictions.get(predId));

    this.setState({
      bannedPredictions
    })
  }

  private toggleReprSelected(repr: string) {
    const enabledReprs = new Map(this.state.enabledReprs);
    enabledReprs.set(repr, !enabledReprs.get(repr));

    const enabledPredictions: PredictionId[] = [];
    for (const pred of this.props.predictions)
      if (enabledReprs.get(pred.repr) && pred.score >= this.state.minScore)
        enabledPredictions.push(pred.id);

    this.setState({
      enabledReprs,
      enabledPredictions,
      from: 1,
      to: Math.min(100, enabledPredictions.length)
    });
  }

  private setMinScore(minScore: number) {
    const enabledPredictions: PredictionId[] = [];
    for (const pred of this.props.predictions)
      if (this.state.enabledReprs.get(pred.repr) && pred.score >= minScore)
        enabledPredictions.push(pred.id);

    this.setState({
      enabledPredictions,
      from: 1,
      to: Math.min(100, enabledPredictions.length),
      minScore
    });
  }

  private nextPredictions() {
    let { enabledPredictions, to } = this.state;
    if (to < enabledPredictions.length)
      this.setState({
        from: to + 1,
        to: Math.min(to + 100, enabledPredictions.length)
      });
  }

  private prevPredictions() {
    let { from } = this.state;
    if (from > 1)
      this.setState({
        from: Math.max(from - 100, 1),
        to: from - 1
      });
  }

  render() {
    let reprs: RepresentationSelectionProp[] = [];
    this.props.reprs.forEach((repr, i) =>
      reprs.push({
        repr: repr.repr,
        id: "repr-" + i,
        count: repr.count,
        selected: !!this.state.enabledReprs.get(repr.repr),
        onClick: () => this.toggleReprSelected(repr.repr),
      })
    );
    reprs.sort((a, b) => b.count - a.count);

    let numPredictions = this.state.enabledPredictions.length;
    let bannedPredictionsCount = this.state.bannedPredictions.size;
    let predictions = this.state.enabledPredictions.slice();
    let self = this;
    let predictionProps = predictions.map(p => {
      return {
        ...self.getPredictionInfo(p),
        banned: !!this.state.bannedPredictions.get(p),
        toggleThisPrediction: () => this.togglePrediction(p),
        toggleSimilarPredictions: () => this.toggleSimilarPredictions(p)
      };
    });
    predictionProps.sort((a, b) => b.score - a.score);
    if (this.state.hideBannedPredictions)
      predictionProps = predictionProps.filter(p => !p.banned);
    predictionProps = predictionProps.slice(this.state.from - 1, this.state.to);

    return (
      <div>
        <h2>Filter</h2>
        <h3>By Representation</h3>
        <RepresentationSelectionList reprs={reprs} />
        <h3>By Score</h3>
        <div>
          <input type="range" id="score-threshold" min="0" max="100" step="10" value={this.state.minScore * 100} onChange={(e) => this.setMinScore(e.target.valueAsNumber / 100)} />
          <label htmlFor="threshold">{this.state.minScore}</label><br />
          Minimum score for a prediction to be included
        </div>
        <h2>Settings</h2>
        Hide banned predictions &nbsp;&nbsp;
        <input type="checkbox" checked={this.state.hideBannedPredictions}
          onChange={(e) => this.setState({ hideBannedPredictions: e.target.checked })}></input>
        <h2>
          Predictions {this.state.from}-{this.state.to} of {numPredictions}
          {numPredictions < this.props.predictions.length ? " (" + (this.props.predictions.length - numPredictions) + " hidden)" : ""}
          {` (${bannedPredictionsCount} banned)`}
          &nbsp;&nbsp;
          <button type="button" disabled={this.state.from === 1} onClick={() => this.prevPredictions()}>&lt; Prev</button>
          &nbsp;&nbsp;
          <button type="button" disabled={this.state.to === this.state.enabledPredictions.length} onClick={() => this.nextPredictions()}>Next &gt;</button>
        </h2>
        <PredictionList predictions={predictionProps} />
        &nbsp;&nbsp;
        <button type="button" disabled={this.state.from === 1} onClick={() => this.prevPredictions()}>&lt; Prev</button>
        &nbsp;&nbsp;
        <button type="button" disabled={this.state.to === this.state.enabledPredictions.length} onClick={() => this.nextPredictions()}>Next &gt;</button>
      </div>
    );
  }
}