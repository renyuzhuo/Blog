#!/usr/bin/python
# -*- coding: UTF-8 -*-
import commands
import os

result= commands.getstatusoutput('lsb_release -r')
if (result[1] == "Release:	16.04"):
    print '16'
elif (result[1] == "Release:	14.04"):
    print '14'
