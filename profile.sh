###############################################################################
#                                                                             #
#         Mac/Linux compatible .profile                                       #
#                                                                             #
#         Author: Samuel John                                                 #
#         License: Open Source MIT License                                    #
#                                                                             #
###############################################################################

#----- Get the aliases and functions (for uberspace compatibility)
#if [ -r ~/.profile ]; then . ~/.profile; fi
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac
