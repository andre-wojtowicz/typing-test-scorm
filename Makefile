deps:
	@echo \* Installing dependencies...
	@echo \* ...done

site:
	@echo \* Preparing website files...
	@echo \* ...done

scorm:
	@echo \* Creating SCORM ZIP file...
	rm -rf dist
	mkdir dist
	cp -r imsmanifest.xml materials dist
	sed -i "s/Last edit: .../Last edit: $(shell date '+%Y-%m-%d %H:%M')/" dist/imsmanifest.xml
	cp -r src/* dist/materials
	cd dist/materials && sed -i -e 's~</head>~<script src="js/scorm.js" type="text/javascript"></script></head>~' -e 's~<body>~<body onload="ScormProcessInitialize();" onbeforeunload="ScormProcessTerminate();" onunload="ScormProcessTerminate();">~' index.html
	cd dist && \
	zip "typing-test-scorm-$(shell date '+%Y_%m_%d-%H_%M').zip" -r .
	@echo ------------------------------------------
	@echo \* SCORM ZIP file created:
	@ls ./dist/*.zip

clean:
	@echo \* Removing website files and SCORM build directory...
	rm -rf dist
	@echo \*...done
