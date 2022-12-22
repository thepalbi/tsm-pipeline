from .app import models_for_base
from peewee import SqliteDatabase, Model
import datetime
from utils.logging import get_stdout_logger

log = get_stdout_logger("o11y")

def new_tracker_factory(db_path: str):
    log.info("starting new tracker factory at path %s", db_path)
    db = SqliteDatabase(db_path)
    class BaseModel(Model):
        class Meta:
            database = db

    Experiment, TrainDatabase = models_for_base(BaseModel)

    class ExperimentTracker:
        def __init__(self, db, exp: Experiment):
            self._db = db
            self._exp = exp

        def new_step(self, train_db_name: str):
            with self._db.atomic():
                db = TrainDatabase.create(
                    name=train_db_name,
                    experiment=self._exp,
                    status="running",
                )
            # return a handler to end db execution

            def end_db(error=False):
                if db.finished_at is not None:
                    raise Exception("end step callback already called")

                db.finished_at = datetime.datetime.now()
                db.status = "finished" if not error else "error"
                db.save()

            return end_db

        def end(self):
            self._exp.finished_at = datetime.datetime.now()
            self._exp.save()


    def start_experiment(name: str, train_size: int) -> ExperimentTracker:
        with db.atomic():
            exp = Experiment.create(
                name=name,
                total_train_size=train_size
            )
        return ExperimentTracker(db, exp)

    return start_experiment

def none_tracker_factory():
    class NoopExperimentTracker:
        def new_step(self, train_db_name: str):
            def end_db(error=False):
                pass

            return end_db

        def end(self):
            pass
            
    def start_experiment(name: str, train_size: int):
        return NoopExperimentTracker()

    return start_experiment