import React from 'react';
import Highlight from 'react-highlight';
import styles from './App.module.css';

type LocationProps = {
  projectName: string;
  path: string;
  startLine: number;
  startColumn: number;
  endLine: number;
  endColumn: number;
}

function Location(props: LocationProps) {
  return (
    <a href={`https://github.com/${props.projectName}/blob/master/${props.path}#L${props.startLine}`} target="_blank" rel="noopener noreferrer">
      {props.projectName}/{props.path}#L{props.startLine}
    </a>
  );
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
    <span>{abbrev(props.text) + '\n'}</span>
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
}

function Snippet(props: SnippetProps) {
  return (
    <Highlight className="javascript">
      {props.beforeLines.map(l => <ContextLine text={l} />)}
      <HighlightedLine before={props.before} highlight={props.highlight} after={props.after} />
      {props.afterLines.map(l => <ContextLine text={l} />)}
    </Highlight>
  );
}

type PredictionProps = {
  location: LocationProps;
  repr: string;
  score: number;
  snippet: SnippetProps;
}

function Prediction(props: PredictionProps) {
  return (
    <li>
      <Location {...props.location} />: <Representation repr={props.repr} />, <Score score={props.score} />
      <Snippet {...props.snippet} />
    </li>
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
  location: LocationProps;
  repr: string;
  score: number;
  snippet: SnippetProps;
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

type AppState = {
  // indicates for each representation whether it is enabled or not
  reprs: Map<string, boolean>;
  // all predictions whose representation is enabled
  enabledPredictions: PredictionInfo[];
  // first prediction to show (1-based)
  from: number;
  // last prediction to show (1-based)
  to: number;
}

export class App extends React.Component<AppProps, AppState> {
  constructor(props: AppProps) {
    super(props);

    let numPredictions = props.predictions.length;

    const reprs = new Map();
    for (const repr of props.reprs)
      reprs.set(repr.repr, repr.count < 0.1 * numPredictions);

    const enabledPredictions: PredictionInfo[] = [];
    for (const pred of props.predictions)
      if (reprs.get(pred.repr))
        enabledPredictions.push(pred);

    this.state = {
      reprs,
      enabledPredictions,
      from: 1,
      to: Math.min(100, enabledPredictions.length)
    };
  }

  private toggleReprSelected(repr: string) {
    const reprs = new Map(this.state.reprs);
    reprs.set(repr, !reprs.get(repr));

    const enabledPredictions: PredictionInfo[] = [];
    for (const pred of this.props.predictions)
      if (reprs.get(pred.repr))
        enabledPredictions.push(pred);

    this.setState({
      reprs,
      enabledPredictions,
      from: 1,
      to: Math.min(100, enabledPredictions.length)
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
    let predictions = this.state.enabledPredictions.slice(this.state.from - 1, this.state.to);
    predictions.sort((a, b) => b.score - a.score);

    return (
      <div>
        <h2>Filter</h2>
        <RepresentationSelectionList reprs={reprs} />
        <h2>
          Predictions {this.state.from}-{this.state.to} of {numPredictions}
          {numPredictions < this.props.predictions.length ? " (" + (this.props.predictions.length - numPredictions) + " hidden)" : ""}
          &nbsp;&nbsp;
          <button type="button" disabled={this.state.from === 1} onClick={() => this.prevPredictions()}>&lt; Prev</button>
          &nbsp;&nbsp;
          <button type="button" disabled={this.state.to === this.state.enabledPredictions.length} onClick={() => this.nextPredictions()}>Next &gt;</button>
        </h2>
        <PredictionList predictions={predictions} />
      </div>
    );
  }
}
