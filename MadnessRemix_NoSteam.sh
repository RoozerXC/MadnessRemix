#!/bin/bash

# 64-bit operating systems
	if ["$(uname -m)"="x86_64"]; then
		../../Amnesia_NOSTEAM.bin.x86_64 "custom_stories/MadnessRemix/config/main_init.cfg"

# 32-bit operating systems
	else
		../../Amnesia_NOSTEAM.bin.x86 "custom_stories/MadnessRemix/config/main_init.cfg"
	fi