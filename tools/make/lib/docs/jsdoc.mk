
# VARIABLES #

# Define the command for removing files and directories:
DELETE_CMD ?= -rm -rf

# Define the command for recursively creating directories:
RECURSIVE_MKDIR ?= mkdir -p

# Define the path of the JSDoc executable:
JSDOC ?= $(BIN)/jsdoc

# Define the path to the JSDoc configuration file:
JSDOC_CONF ?= $(CONFIG_DIR)/jsdoc.conf.json

# Define the path to JSDoc type definitions:
JSDOC_TYPEDEF ?= $(TOOLS_DIR)/docs/jsdoc/typedefs/*.js

# Define the path to the JSDoc JSON template:
JSDOC_JSON_TEMPLATE ?= $(TOOLS_DIR)/docs/jsdoc/templates/json

# Define the output directory for JSDoc:
JSDOC_OUT ?= $(DOCS_DIR)/jsdoc

# Define the output directory for JSDoc JSON:
JSDOC_JSON_OUT ?= $(JSDOC_OUT)/json

# Define the output filepath for JSDoc JSON:
JSDOC_JSON_PATH ?= $(JSDOC_JSON_OUT)/jsdoc.json

# Define the path to the JSDoc HTML template:
JSDOC_HTML_TEMPLATE ?= $(TOOLS_DIR)/docs/jsdoc/templates/html

# Define the output directory for JSDoc HTML documentation:
JSDOC_HTML_OUT ?= $(JSDOC_OUT)/static

# Define the output filepath for HTML documentation:
JSDOC_HTML_PATH ?= $(JSDOC_HTML_OUT)/index.html

# Define command-line options to be used when invoking the JSDoc executable to generate HTML documentation:
JSDOC_HTML_FLAGS ?= --template $(JSDOC_HTML_TEMPLATE) \
		--configure $(JSDOC_CONF) \
		--encoding utf8 \
		--destination $(JSDOC_HTML_OUT) \
		--verbose

# Define command-line options to be used when invoking the JSDoc executable to generate JSDoc JSON:
JSDOC_JSON_FLAGS ?= --template $(JSDOC_JSON_TEMPLATE) \
		--configure $(JSDOC_CONF) \
		--encoding utf8 \
		--destination console


# TARGETS #

# Generate JSDoc HTML documentation.
#
# This target generates source HTML documentation from [JSDoc][1]-style comments using [JSDoc][1].
#
# To install JSDoc:
#     $ npm install jsdoc
#
# [1]: http://usejsdoc.org/

jsdoc-html: node_modules
	$(DELETE_CMD) $(JSDOC_HTML_OUT)
	$(RECURSIVE_MKDIR) $(JSDOC_HTML_OUT)
	$(JSDOC) $(JSDOC_HTML_FLAGS) $(JSDOC_TYPEDEF) $(SOURCES)


# Generate JSDoc JSON.
#
# This target generates JSDoc JSON from [JSDoc][1]-style comments.
#
# To install JSDoc:
#     $ npm install jsdoc
#
# [1]: http://usejsdoc.org/

jsdoc-json: node_modules
	$(DELETE_CMD) $(JSDOC_JSON_PATH)
	$(RECURSIVE_MKDIR) $(JSDOC_JSON_OUT)
	$(JSDOC) $(JSDOC_JSON_FLAGS) $(JSDOC_TYPEDEF) $(SOURCES) > $(JSDOC_JSON_PATH)


# View HTML documentation.
#
# This target opens JSDoc HTML documentation in a local web browser.

view-jsdoc-html:
	$(OPEN) $(JSDOC_HTML_PATH)


# Remove a JSDoc output directory.
#
# This target cleans up a JSDoc output directory by removing it entirely.

clean-jsdoc:
	$(DELETE_CMD) $(JSDOC_OUT)


# Rebuild JSDoc HTML documentation.
#
# This target removes any current documentation and regenerates source HTML documentation from [JSDoc][1]-style comments.
#
# To install JSDoc:
#     $ npm install jsdoc
#
# [1]: http://usejsdoc.org/

rebuild-jsdoc-html:
	@$(MAKE) -f $(THIS_FILE) clean-jsdoc
	@$(MAKE) -f $(THIS_FILE) jsdoc-html


.PHONY: jsdoc-html jsdoc-json view-jsdoc-html rebuild-jsdoc-html clean-jsdoc

