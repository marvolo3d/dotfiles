from tnt_nuke import menu, utils, renderman

menu.create() # create tnt menu

import cryptomatte_utilities
cryptomatte_utilities.setup_cryptomatte_ui()

toolbar = nuke.toolbar("Nodes")
toolbar.addCommand( "Peregrine/pgBokeh", "nuke.createNode('pgBokeh')", icon="pgBokeh.png")
