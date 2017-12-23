import nuke
import os
import sys

pathToLib = os.environ['LIBRARY']

sys.path.append(pathToLib + '/nuke/scripts')
sys.path.append(pathToLib + '/nuke/scripts/third_party')

os.environ['NUKE_GIZMO_PATH'] = pathToLib + '/nuke/gizmos'

gizPath = os.environ['NUKE_GIZMO_PATH']
gizDirs = [gizPath + '/{0}'.format(d) for d in os.listdir(gizPath)]

for d in gizDirs:
     nuke.pluginAddPath(d)

print "\n PLUGIN PATH: {0} \n".format(nuke.pluginPath())

import cryptomatte_utilities
cryptomatte_utilities.setup_cryptomatte()

if nuke.NUKE_VERSION_STRING != "11.1v1":
    nuke.load("pgBokeh")
