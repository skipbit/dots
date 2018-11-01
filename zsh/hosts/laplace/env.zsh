
# caffe
export CAFFE_ROOT=$HOME/Workspace/Repository/GitHub/ideeinc/caffe
path=($path ${CAFFE_ROOT}/build/tools)

# casemanagerserver
export FLASK_APP=api/__init__.py
export FLASK_ENV=development
export CELERY_BROKER_URL=redis://localhost:6379/0

