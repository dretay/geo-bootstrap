#
# BUILD BOOTSWATCH SWATCH
#

OUTPUT_PATH = swatch

lessc:
	lessc swatchmaker.less > ${OUTPUT_PATH}/bootstrap.css

bootswatch:
	recess --compile swatchmaker.less > ${OUTPUT_PATH}/bootstrap.css
	recess --compress swatchmaker.less > ${OUTPUT_PATH}/bootstrap.min.css

bootstrap:
	-test -d bootstrap && rm -r bootstrap
	mkdir -p bootstrap/
	curl --location -o latest_bootstrap.tar.gz https://github.com/twitter/bootstrap/tarball/master
	mkdir -p bootstrap-unpack/
	tar -xvzf latest_bootstrap.tar.gz -C bootstrap-unpack/
	mv bootstrap-unpack/*/* bootstrap/
	rm -r bootstrap-unpack/
	rm latest_bootstrap.tar.gz

default:
	-test -f ${OUTPUT_PATH}/variables.less && rm ${OUTPUT_PATH}/variables.less
	-test -f ${OUTPUT_PATH}/bootswatch.less && rm ${OUTPUT_PATH}/bootswatch.less
	curl --location -o ${OUTPUT_PATH}/variables.less https://raw.github.com/twitter/bootstrap/master/less/variables.less
	curl --location -o ${OUTPUT_PATH}/bootswatch.less https://raw.github.com/thomaspark/bootswatch/gh-pages/swatchmaker/swatch/bootswatch.less
	make bootswatch

watcher:
	ruby watcher.rb

server:
	open http://localhost:8000/test/test.html
	python -m SimpleHTTPServer

.PHONY: bootswatch bootstrap default watcher server

