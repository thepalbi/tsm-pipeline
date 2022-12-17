from .app import database, Experiment, TrainDatabase
import datetime

class ExperimentTracker:
    def __init__(self, db, exp: Experiment):
        self._db = db
        self._exp = exp

    def new_step(self, train_db_name: str):
        with self._db.atomic():
            db = TrainDatabase.create(
                name=train_db_name,
                experiment=self._exp
            )
        # return a handler to end db execution
        def end_db():
            db.finished_at = datetime.datetime.now()
            db.save()

        return end_db

    def end(self):
        self._exp.finished_at = datetime.datetime.now()
        self._exp.save()

def start_experiment(name: str, train_size: int) -> ExperimentTracker:
    with database.atomic():
        exp = Experiment.create(
            name=name,
            total_train_size=train_size
            )
    return ExperimentTracker(database, exp)
    