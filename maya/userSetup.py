import os
import sys
import pymel.core as pm

#  tomcommandport
try:
    pm.commandPort(name=":7005", sourceType="python")
    print 'commandport to atom open...'
except:
    print 'could not open port to atom'

if not pm.about(batch=1): #gui mode only
    # import some python modules
    # pm.evalDeferred("import zhcg_polytools")
    pm.evalDeferred("import marvolo_maya")
    pm.evalDeferred("import cosmos")

# append path where GitPython lives
sys.path.append("/usr/lib/python2.7/site-packages/")

print "marvolo userSetup finish"
