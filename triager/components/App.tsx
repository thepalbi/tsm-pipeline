import React from 'react';
import { useState } from 'react';
import Highlight from 'react-highlight';
import styles from './App.module.css';
import { v4 as uuid } from 'uuid';

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
  isBanned: boolean;
}

function Snippet(props: SnippetProps) {
  return (
    <div style={{ textDecoration: props.isBanned ? "line-through" : "none" }}>
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
  onClick: () => void;
  similarOnClick: () => void;
}

function Prediction(props: PredictionProps) {
  return (
    <li>
      <BanPredictionButton state={props.banned} onClick={props.onClick} />
      <button onClick={e => props.similarOnClick()}>ban similar</button>
      <Location {...props.location} />: <Representation repr={props.repr} />, <Score score={props.score} />
      <Snippet {...props.snippet} isBanned={props.banned} />
    </li>
  );
}

type BanPredictionToggleProps = {
  state: boolean,
  onClick: () => void;
}

function BanPredictionButton(props: BanPredictionToggleProps) {
  return (
    <button onClick={props.onClick}>{
      props.state ? "unban" : "ban"
    }</button>
  );
}


type PredictionListProps = {
  predictions: PredictionProps[];
}

function PredictionList(props: PredictionListProps) {
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

export type PredictionInfo = {
  id: string;
  location: LocationProps;
  locationEnclosingStm: LocationProps;
  locationEnclosingFunc: LocationProps;
  repr: string;
  score: number;
  snippet: SnippetProps;
  banned: boolean;
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
      p.id = uuid();
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
  reprs: Map<string, boolean>;
  // indicates the predictions that have been banned
  bannedPredictions: Map<string, boolean>;
  // all predictions whose representation is enabled
  enabledPredictions: PredictionInfo[];
  // first prediction to show (1-based)
  from: number;
  // last prediction to show (1-based)
  to: number;
  // minimum score for a prediction to be included
  minScore: number;
  // whether or not to display banned predictions
  hideBannedPredictions: boolean;
}

export class App extends React.Component<AppProps, AppState> {
  constructor(props: AppProps) {
    super(props);

    let minScore = 0.5;

    let numPredictions = props.predictions.length;

    const reprs = new Map();
    for (const repr of props.reprs)
      reprs.set(repr.repr, repr.count < 0.1 * numPredictions);

    const enabledPredictions: PredictionInfo[] = [];
    for (const pred of props.predictions)
      if (reprs.get(pred.repr) && pred.score >= minScore)
        enabledPredictions.push(pred);

    this.state = {
      reprs,
      bannedPredictions: new Map(),
      enabledPredictions,
      from: 1,
      to: Math.min(100, enabledPredictions.length),
      minScore,
      hideBannedPredictions: false,
    };
  }
  private banSimilarPredictions(predId: string, loc: LocationProps, locStmt: LocationProps, locFunc: LocationProps, repr: string) {
    console.log("Banning similar to: %s - %s", repr, predId);
    let reqBody = {
      locStm: locStmt,
      locFunc: locFunc,
      repr: repr
    }
    fetch("http://localhost:4444/similar", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify(reqBody),
      mode: "cors"
    })
      .then(resp => resp.json() as Promise<TriagerSimilarResponseItem[]>)
      .then(parsedResponse => {
        this.doBanSimilarPredictions(predId, parsedResponse)
      })
      .catch(err => {
        console.error("Error calling triager backend: %s", err);
      })
  }

  private doBanSimilarPredictions(predId: string, similarResponseItems: TriagerSimilarResponseItem[]) {
    console.log("Received response: %s", JSON.stringify(similarResponseItems));
    // Make a map with all similar pred.loc as string
    let similarPredLocs = new Set(similarResponseItems.map(s => locString(s.location)));
    const bannedPredictions = new Map(this.state.bannedPredictions);
    bannedPredictions.set(predId, true);

    const enabledPredictions: PredictionInfo[] = [];
    for (const pred of this.props.predictions) {
      if (similarPredLocs.has(locString(pred.location))) {
        bannedPredictions.set(pred.id, true);
        pred.banned = !!bannedPredictions.get(pred.id);
      }

      if (this.state.reprs.get(pred.repr) && pred.score >= this.state.minScore) {
        enabledPredictions.push(pred);
      }
    }

    this.setState({
      bannedPredictions,
      enabledPredictions
    })
  }

  private banPrediction(predId: string) {
    const bannedPredictions = new Map(this.state.bannedPredictions);
    bannedPredictions.set(predId, true);

    const enabledPredictions: PredictionInfo[] = [];
    for (const pred of this.props.predictions)
      if (this.state.reprs.get(pred.repr) && pred.score >= this.state.minScore) {
        pred.banned = !!bannedPredictions.get(pred.id);
        enabledPredictions.push(pred);
      }

    this.setState({
      bannedPredictions,
      enabledPredictions
    })
  }

  private toggleReprSelected(repr: string) {
    const reprs = new Map(this.state.reprs);
    reprs.set(repr, !reprs.get(repr));

    const enabledPredictions: PredictionInfo[] = [];
    for (const pred of this.props.predictions)
      if (reprs.get(pred.repr) && pred.score >= this.state.minScore)
        enabledPredictions.push(pred);

    this.setState({
      reprs,
      enabledPredictions,
      from: 1,
      to: Math.min(100, enabledPredictions.length)
    });
  }

  private setMinScore(minScore: number) {
    const reprs = new Map(this.state.reprs);

    const enabledPredictions: PredictionInfo[] = [];
    for (const pred of this.props.predictions)
      if (reprs.get(pred.repr) && pred.score >= minScore)
        enabledPredictions.push(pred);

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
        selected: !!this.state.reprs.get(repr.repr),
        onClick: () => this.toggleReprSelected(repr.repr),
      })
    );
    reprs.sort((a, b) => b.count - a.count);

    let numPredictions = this.state.enabledPredictions.length;
    let bannedPredictionsCount = this.state.bannedPredictions.size;
    let predictions = this.state.enabledPredictions.slice();
    predictions.sort((a, b) => b.score - a.score);
    predictions = predictions.slice(this.state.from - 1, this.state.to);
    if (this.state.hideBannedPredictions)
      predictions = predictions.filter(p => !p.banned);
    let propPredictions = predictions.map(p => {
      return {
        ...p,
        onClick: () => this.banPrediction(p.id),
        similarOnClick: () => this.banSimilarPredictions(p.id, p.location, p.locationEnclosingStm, p.locationEnclosingFunc, p.repr)
      };
    });

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
        <PredictionList predictions={propPredictions} />
        &nbsp;&nbsp;
        <button type="button" disabled={this.state.from === 1} onClick={() => this.prevPredictions()}>&lt; Prev</button>
        &nbsp;&nbsp;
        <button type="button" disabled={this.state.to === this.state.enabledPredictions.length} onClick={() => this.nextPredictions()}>Next &gt;</button>
      </div>
    );
  }
}