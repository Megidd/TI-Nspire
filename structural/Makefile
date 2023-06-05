# This will loop through all *.lua files in the directory and
# create corresponding *.tns files using the luna command.
build:
	for file in *.lua; do \
		luna "$$file" "$${file%%.lua}.tns"; \
	done

clean:
	$(RM) *.tns

.PHONY: clean build
