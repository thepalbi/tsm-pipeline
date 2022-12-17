import os
from peewee import *
import datetime

from flask import (Flask, render_template, Response)
from playhouse.flask_utils import FlaskDB, get_object_or_404


########
# APP
########
APP_DIR = os.path.dirname(os.path.realpath(__file__))
DATABASE = 'sqliteext:////tesis/repos/tsm-pipeline/code/tsm.db'
DEBUG = False

app = Flask(__name__)
app.config.from_object(__name__)

# FlaskDB is a wrapper for a peewee database that sets up pre/post-request
# hooks for managing database connections.
flask_db = FlaskDB(app)

# The `database` is the actual peewee database, as opposed to flask_db which is
# the wrapper.
database = flask_db.database

########
# MODELS
########

class Experiment(flask_db.Model):
    experiment_id = AutoField()
    name = CharField()
    started_at = DateTimeField(default=datetime.datetime.now)
    finished_at = DateTimeField(default=None, null=True)
    total_train_size = IntegerField()

class TrainDatabase(flask_db.Model):
    db_id = AutoField()
    name = CharField()
    started_at = DateTimeField(default=datetime.datetime.now)
    finished_at = DateTimeField(default=None, null=True)
    experiment = ForeignKeyField(model=Experiment, backref='train_dbs')

@app.route('/')
def index():
    all_experiments = Experiment.select()
    return render_template('index.html', experiments=all_experiments)

@app.route('/experiment/<int:id>')
def experiment(id):
    experiment = Experiment.get(Experiment.experiment_id == id)
    return render_template('experiment.html', experiment=experiment)

@app.errorhandler(404)
def not_found(exc):
    return Response('<h3>No encontrado</h3>'), 404

if __name__ == "__main__":
    database.create_tables([Experiment, TrainDatabase])
    app.run(debug=True, host="0.0.0.0")