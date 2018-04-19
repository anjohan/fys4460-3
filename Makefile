MAKEFLAGS += --silent
all:
	@mkdir -p tmp
	@mkdir -p build
	@cd build; cmake ..; make
	make report.pdf
report.pdf: report.tex sources.bib tmp/verification.txt
	latexmk -pdflua -shell-escape report
tmp/verification.txt: build/verification
	./build/verification > tmp/verification.txt
debug:
	@mkdir -p debug_folder
	@cd debug_folder; cmake -DCMAKE_BUILD_TYPE=Debug ..; make
clean:
	rm -rf build debug debug_folder
	latexmk -c
	rm -rf __pycache__ pythontex-files-report *.pytxcode *.auxlock *.run.xml data *.bbl report.pdf
