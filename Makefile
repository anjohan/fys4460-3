MAKEFLAGS += --silent
all:
	@mkdir -p tmp
	@mkdir -p build
	@cd build; cmake ..; make
	make report.pdf
report.pdf: report.tex sources.bib tmp/verification.txt tmp/P_100_64.dat tmp/c_P.dat tmp/d_a.dat tmp/f_p.dat tmp/f_p_1.dat
	latexmk -pdflua -shell-escape report
tmp/f_p.dat tmp/f_p_1.dat: build/f
	./build/f
tmp/d_a.dat: src/d.py
	python src/d.py
tmp/c_P.dat: build/c
	./build/c
tmp/P_100_64.dat: build/b
	./build/b
tmp/verification.txt: build/verification
	./build/verification > tmp/verification.txt
debug:
	@mkdir -p debug_folder
	@cd debug_folder; cmake -DCMAKE_BUILD_TYPE=Debug ..; make
clean:
	latexmk -c
	rm -rf __pycache__ pythontex-files-report *.pytxcode *.auxlock *.run.xml data *.bbl report.pdf tmp/report-figure*
clean-all:
	make clean
	rm -rf build debug debug_folder tmp
