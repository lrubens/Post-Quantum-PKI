# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/rubensl/Post-Quantum-PKI

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/rubensl/Post-Quantum-PKI

# Include any dependencies generated for this target.
include CMakeFiles/round5_engine.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/round5_engine.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/round5_engine.dir/flags.make

CMakeFiles/round5_engine.dir/round5_engine.c.o: CMakeFiles/round5_engine.dir/flags.make
CMakeFiles/round5_engine.dir/round5_engine.c.o: round5_engine.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/rubensl/Post-Quantum-PKI/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/round5_engine.dir/round5_engine.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/round5_engine.dir/round5_engine.c.o   -c /home/rubensl/Post-Quantum-PKI/round5_engine.c

CMakeFiles/round5_engine.dir/round5_engine.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/round5_engine.dir/round5_engine.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/rubensl/Post-Quantum-PKI/round5_engine.c > CMakeFiles/round5_engine.dir/round5_engine.c.i

CMakeFiles/round5_engine.dir/round5_engine.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/round5_engine.dir/round5_engine.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/rubensl/Post-Quantum-PKI/round5_engine.c -o CMakeFiles/round5_engine.dir/round5_engine.c.s

CMakeFiles/round5_engine.dir/round5_engine.c.o.requires:

.PHONY : CMakeFiles/round5_engine.dir/round5_engine.c.o.requires

CMakeFiles/round5_engine.dir/round5_engine.c.o.provides: CMakeFiles/round5_engine.dir/round5_engine.c.o.requires
	$(MAKE) -f CMakeFiles/round5_engine.dir/build.make CMakeFiles/round5_engine.dir/round5_engine.c.o.provides.build
.PHONY : CMakeFiles/round5_engine.dir/round5_engine.c.o.provides

CMakeFiles/round5_engine.dir/round5_engine.c.o.provides.build: CMakeFiles/round5_engine.dir/round5_engine.c.o


CMakeFiles/round5_engine.dir/meths/round5_meth.c.o: CMakeFiles/round5_engine.dir/flags.make
CMakeFiles/round5_engine.dir/meths/round5_meth.c.o: meths/round5_meth.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/rubensl/Post-Quantum-PKI/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/round5_engine.dir/meths/round5_meth.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/round5_engine.dir/meths/round5_meth.c.o   -c /home/rubensl/Post-Quantum-PKI/meths/round5_meth.c

CMakeFiles/round5_engine.dir/meths/round5_meth.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/round5_engine.dir/meths/round5_meth.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/rubensl/Post-Quantum-PKI/meths/round5_meth.c > CMakeFiles/round5_engine.dir/meths/round5_meth.c.i

CMakeFiles/round5_engine.dir/meths/round5_meth.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/round5_engine.dir/meths/round5_meth.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/rubensl/Post-Quantum-PKI/meths/round5_meth.c -o CMakeFiles/round5_engine.dir/meths/round5_meth.c.s

CMakeFiles/round5_engine.dir/meths/round5_meth.c.o.requires:

.PHONY : CMakeFiles/round5_engine.dir/meths/round5_meth.c.o.requires

CMakeFiles/round5_engine.dir/meths/round5_meth.c.o.provides: CMakeFiles/round5_engine.dir/meths/round5_meth.c.o.requires
	$(MAKE) -f CMakeFiles/round5_engine.dir/build.make CMakeFiles/round5_engine.dir/meths/round5_meth.c.o.provides.build
.PHONY : CMakeFiles/round5_engine.dir/meths/round5_meth.c.o.provides

CMakeFiles/round5_engine.dir/meths/round5_meth.c.o.provides.build: CMakeFiles/round5_engine.dir/meths/round5_meth.c.o


CMakeFiles/round5_engine.dir/meths/asn1_meth.c.o: CMakeFiles/round5_engine.dir/flags.make
CMakeFiles/round5_engine.dir/meths/asn1_meth.c.o: meths/asn1_meth.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/rubensl/Post-Quantum-PKI/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/round5_engine.dir/meths/asn1_meth.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/round5_engine.dir/meths/asn1_meth.c.o   -c /home/rubensl/Post-Quantum-PKI/meths/asn1_meth.c

CMakeFiles/round5_engine.dir/meths/asn1_meth.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/round5_engine.dir/meths/asn1_meth.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/rubensl/Post-Quantum-PKI/meths/asn1_meth.c > CMakeFiles/round5_engine.dir/meths/asn1_meth.c.i

CMakeFiles/round5_engine.dir/meths/asn1_meth.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/round5_engine.dir/meths/asn1_meth.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/rubensl/Post-Quantum-PKI/meths/asn1_meth.c -o CMakeFiles/round5_engine.dir/meths/asn1_meth.c.s

CMakeFiles/round5_engine.dir/meths/asn1_meth.c.o.requires:

.PHONY : CMakeFiles/round5_engine.dir/meths/asn1_meth.c.o.requires

CMakeFiles/round5_engine.dir/meths/asn1_meth.c.o.provides: CMakeFiles/round5_engine.dir/meths/asn1_meth.c.o.requires
	$(MAKE) -f CMakeFiles/round5_engine.dir/build.make CMakeFiles/round5_engine.dir/meths/asn1_meth.c.o.provides.build
.PHONY : CMakeFiles/round5_engine.dir/meths/asn1_meth.c.o.provides

CMakeFiles/round5_engine.dir/meths/asn1_meth.c.o.provides.build: CMakeFiles/round5_engine.dir/meths/asn1_meth.c.o


CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.o: CMakeFiles/round5_engine.dir/flags.make
CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.o: meths/dilithium_meth.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/rubensl/Post-Quantum-PKI/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.o   -c /home/rubensl/Post-Quantum-PKI/meths/dilithium_meth.c

CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/rubensl/Post-Quantum-PKI/meths/dilithium_meth.c > CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.i

CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/rubensl/Post-Quantum-PKI/meths/dilithium_meth.c -o CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.s

CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.o.requires:

.PHONY : CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.o.requires

CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.o.provides: CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.o.requires
	$(MAKE) -f CMakeFiles/round5_engine.dir/build.make CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.o.provides.build
.PHONY : CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.o.provides

CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.o.provides.build: CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.o


CMakeFiles/round5_engine.dir/ossl/objects.c.o: CMakeFiles/round5_engine.dir/flags.make
CMakeFiles/round5_engine.dir/ossl/objects.c.o: ossl/objects.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/rubensl/Post-Quantum-PKI/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building C object CMakeFiles/round5_engine.dir/ossl/objects.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/round5_engine.dir/ossl/objects.c.o   -c /home/rubensl/Post-Quantum-PKI/ossl/objects.c

CMakeFiles/round5_engine.dir/ossl/objects.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/round5_engine.dir/ossl/objects.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/rubensl/Post-Quantum-PKI/ossl/objects.c > CMakeFiles/round5_engine.dir/ossl/objects.c.i

CMakeFiles/round5_engine.dir/ossl/objects.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/round5_engine.dir/ossl/objects.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/rubensl/Post-Quantum-PKI/ossl/objects.c -o CMakeFiles/round5_engine.dir/ossl/objects.c.s

CMakeFiles/round5_engine.dir/ossl/objects.c.o.requires:

.PHONY : CMakeFiles/round5_engine.dir/ossl/objects.c.o.requires

CMakeFiles/round5_engine.dir/ossl/objects.c.o.provides: CMakeFiles/round5_engine.dir/ossl/objects.c.o.requires
	$(MAKE) -f CMakeFiles/round5_engine.dir/build.make CMakeFiles/round5_engine.dir/ossl/objects.c.o.provides.build
.PHONY : CMakeFiles/round5_engine.dir/ossl/objects.c.o.provides

CMakeFiles/round5_engine.dir/ossl/objects.c.o.provides.build: CMakeFiles/round5_engine.dir/ossl/objects.c.o


CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.o: CMakeFiles/round5_engine.dir/flags.make
CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.o: ossl/ossl_compat.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/rubensl/Post-Quantum-PKI/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building C object CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.o   -c /home/rubensl/Post-Quantum-PKI/ossl/ossl_compat.c

CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/rubensl/Post-Quantum-PKI/ossl/ossl_compat.c > CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.i

CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/rubensl/Post-Quantum-PKI/ossl/ossl_compat.c -o CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.s

CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.o.requires:

.PHONY : CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.o.requires

CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.o.provides: CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.o.requires
	$(MAKE) -f CMakeFiles/round5_engine.dir/build.make CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.o.provides.build
.PHONY : CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.o.provides

CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.o.provides.build: CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.o


CMakeFiles/round5_engine.dir/keypair.c.o: CMakeFiles/round5_engine.dir/flags.make
CMakeFiles/round5_engine.dir/keypair.c.o: keypair.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/rubensl/Post-Quantum-PKI/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building C object CMakeFiles/round5_engine.dir/keypair.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/round5_engine.dir/keypair.c.o   -c /home/rubensl/Post-Quantum-PKI/keypair.c

CMakeFiles/round5_engine.dir/keypair.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/round5_engine.dir/keypair.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/rubensl/Post-Quantum-PKI/keypair.c > CMakeFiles/round5_engine.dir/keypair.c.i

CMakeFiles/round5_engine.dir/keypair.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/round5_engine.dir/keypair.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/rubensl/Post-Quantum-PKI/keypair.c -o CMakeFiles/round5_engine.dir/keypair.c.s

CMakeFiles/round5_engine.dir/keypair.c.o.requires:

.PHONY : CMakeFiles/round5_engine.dir/keypair.c.o.requires

CMakeFiles/round5_engine.dir/keypair.c.o.provides: CMakeFiles/round5_engine.dir/keypair.c.o.requires
	$(MAKE) -f CMakeFiles/round5_engine.dir/build.make CMakeFiles/round5_engine.dir/keypair.c.o.provides.build
.PHONY : CMakeFiles/round5_engine.dir/keypair.c.o.provides

CMakeFiles/round5_engine.dir/keypair.c.o.provides.build: CMakeFiles/round5_engine.dir/keypair.c.o


# Object files for target round5_engine
round5_engine_OBJECTS = \
"CMakeFiles/round5_engine.dir/round5_engine.c.o" \
"CMakeFiles/round5_engine.dir/meths/round5_meth.c.o" \
"CMakeFiles/round5_engine.dir/meths/asn1_meth.c.o" \
"CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.o" \
"CMakeFiles/round5_engine.dir/ossl/objects.c.o" \
"CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.o" \
"CMakeFiles/round5_engine.dir/keypair.c.o"

# External object files for target round5_engine
round5_engine_EXTERNAL_OBJECTS =

libround5_engine.so: CMakeFiles/round5_engine.dir/round5_engine.c.o
libround5_engine.so: CMakeFiles/round5_engine.dir/meths/round5_meth.c.o
libround5_engine.so: CMakeFiles/round5_engine.dir/meths/asn1_meth.c.o
libround5_engine.so: CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.o
libround5_engine.so: CMakeFiles/round5_engine.dir/ossl/objects.c.o
libround5_engine.so: CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.o
libround5_engine.so: CMakeFiles/round5_engine.dir/keypair.c.o
libround5_engine.so: CMakeFiles/round5_engine.dir/build.make
libround5_engine.so: libround5.a
libround5_engine.so: /usr/lib/x86_64-linux-gnu/libcrypto.so
libround5_engine.so: CMakeFiles/round5_engine.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/rubensl/Post-Quantum-PKI/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Linking C shared library libround5_engine.so"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/round5_engine.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/round5_engine.dir/build: libround5_engine.so

.PHONY : CMakeFiles/round5_engine.dir/build

CMakeFiles/round5_engine.dir/requires: CMakeFiles/round5_engine.dir/round5_engine.c.o.requires
CMakeFiles/round5_engine.dir/requires: CMakeFiles/round5_engine.dir/meths/round5_meth.c.o.requires
CMakeFiles/round5_engine.dir/requires: CMakeFiles/round5_engine.dir/meths/asn1_meth.c.o.requires
CMakeFiles/round5_engine.dir/requires: CMakeFiles/round5_engine.dir/meths/dilithium_meth.c.o.requires
CMakeFiles/round5_engine.dir/requires: CMakeFiles/round5_engine.dir/ossl/objects.c.o.requires
CMakeFiles/round5_engine.dir/requires: CMakeFiles/round5_engine.dir/ossl/ossl_compat.c.o.requires
CMakeFiles/round5_engine.dir/requires: CMakeFiles/round5_engine.dir/keypair.c.o.requires

.PHONY : CMakeFiles/round5_engine.dir/requires

CMakeFiles/round5_engine.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/round5_engine.dir/cmake_clean.cmake
.PHONY : CMakeFiles/round5_engine.dir/clean

CMakeFiles/round5_engine.dir/depend:
	cd /home/rubensl/Post-Quantum-PKI && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/rubensl/Post-Quantum-PKI /home/rubensl/Post-Quantum-PKI /home/rubensl/Post-Quantum-PKI /home/rubensl/Post-Quantum-PKI /home/rubensl/Post-Quantum-PKI/CMakeFiles/round5_engine.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/round5_engine.dir/depend

