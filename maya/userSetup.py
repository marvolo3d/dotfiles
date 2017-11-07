import os
import sys
import pymel.core as pm

# # sublime commandport
# try:
#     pm.commandPort(n=":7002", stp='python')
#     print 'commandport to sublime open...'
# except:
#     print 'could not open port to sublime'

if not pm.about(batch=1): #gui mode only
    # append python path
    marvolo_maya_path = '{0}/maya/scripts'.format(os.environ['LIBRARY'])
    sys.path.append(marvolo_maya_path)

    # import some python modules
    # pm.evalDeferred("import zhcg_polytools")
    pm.evalDeferred("import marvolo_maya")
    pm.evalDeferred("import cosmos")

    print "marvolo userSetup finish"
