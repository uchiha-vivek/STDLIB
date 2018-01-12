#/
# @license Apache-2.0
#
# Copyright 2017 The Stdlib Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#/

# DEPENDENCIES #

ifeq ($(DEPS_CEPHES_DIST), netlib)
	include $(TOOLS_MAKE_LIB_DIR)/deps/cephes_netlib.mk
else
ifeq ($(DEPS_CEPHES_DIST), cephes-2.8)
	include $(TOOLS_MAKE_LIB_DIR)/deps/cephes_2_8.mk
else
ifeq ($(DEPS_CEPHES_DIST), moshier)
	include $(TOOLS_MAKE_LIB_DIR)/deps/cephes_moshier.mk
endif
endif
endif


# TARGETS #

# Install Cephes.
#
# This target installs Cephes.

install-deps-cephes: deps-download-cephes deps-verify-cephes deps-extract-cephes deps-test-cephes

.PHONY: install-deps-cephes


# Clean Cephes.
#
# This target removes a Cephes distribution (but does not remove downloaded Cephes libraries if they exist).

clean-deps-cephes: clean-deps-cephes-tests
	$(QUIET) $(DELETE) $(DELETE_FLAGS) $(DEPS_CEPHES_BUILD_OUT)

.PHONY: clean-deps-cephes


# Clean tests.
#
# This targets remove installation tests.

clean-deps-cephes-tests:
	$(QUIET) $(DELETE) $(DELETE_FLAGS) $(DEPS_CEPHES_TEST_OUT)

.PHONY: clean-deps-cephes-tests

