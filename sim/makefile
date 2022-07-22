VCS_VERDI1 = /opt/Synopsys/verdi/R-2020.12-SP1/share/PLI/VCS/LINUX64/novas.tab
VCS_VERDI2 = /opt/Synopsys/verdi/R-2020.12-SP1/share/PLI/VCS/LINUX64/pli.a
VCSDEF =  -cpp g++ -cc gcc -LDFLAGS -no-pie -LDFLAGS -Wl,--no-as-needed -CFLAGS -fPIE

SAVECOV = 0 #save cov data
VERB = UVM_HIGH #{}
TESTNAME = apbm_func_test

#+init_psram
projectpath=$(pwd)
my_define=case_default
SEED = `data "+%m%d%H%M%S"`

ifeq ($(SAVECOV),1)
	CM_NAME = $(TESTNAME)_$(SEED)
else
	CM_NAME = $(my_define)
endif

filist = ../sim_cfg/filelist
dir_incdir =  +incdir+../agent \
	+incdir+../env \
	+incdir+../tb
	
#../../RTL/timescale.v

all: clean precomp elab sim
restart: precomp elab
recomp: precomp elab
resim: precomp elab sim

#step 1 : compile
VCOMP= vlogan -full64  -kdb +v2k -sverilog ${dir_incdir} -l vlogan.log

precomp:
	$(VCOMP) -f ${filist}
#+nospecify +notimingcheck +libext+.v -l vlogan.log

#step 2 : elaborates
elab:
	vcs -full64 -timescale=1ns/10ps \
	-kdb -lca -Mupdate +lint=TFIPC-L +lint=PCWM  \
	+nospecify +notimingcheck +notice \
	-cm line+cond+tgl+fsm+branch+assert \
	-cm_hier ../sim_cfg/cm.cfg -cm_assert_hier ../sim_cfg/cm_ass.cfg \
	-debug_access+all tb_top -o simv \
	-LDFLAGS -rdynamic -P ${VCS_VERDI1} ${VCS_VERDI2} -l run.log \
	+UVM_VERDI_TRACE="UVM_AWARE+RAL+HIER+COMPWAVE" +UVM_TR_RECORD +UVM_LOG_RECORD

#-fgp -partcomp -fastpartcomp=j1
#-debug_access+all
#+tc=$case_name 
#-cm line+cond+tgl+fsm+branch -cm_dir ./coverage 
#-cm_hier ./cm.cfg
#+UVM_VERDI_TRACE="UVM_AWARE+RAL+HIER+COMPWAVE" +UVM_TR_RECORD +UVM_LOG_RECORD

#step 3 : simulate
sim:
	./simv +${my_define} +ntb_random_seed=$(SEED) +UVM_TESTNAME=$(TESTNAME)  \
	-cm line+cond+tgl+fsm+branch+assert -cm_name ${CM_NAME}  \
	uvm_Debug -l sim.log

#-fgp=num_threads:3,diag:ruse,dynamictoggle
#+UVM_VERDI_TRACE="UVM_AWARE+RAL+TLM+TLM2+IMP+HIER+COMPWAVE" +UVM_TR_RECORD
#+fsdb+region
#+UVM_VERBOSITY=${VERB}

simg:
	./simv -gui -l sim.log uvm_Debug \
	+${my_define} +ntb_random_seed=$(SEED) +UVM_TESTNAME=$(TESTNAME)

dvecov:
	dve -covdir simv.vdb &

verdicov:
	verdi -cov -covdir simv.vdb &

SIM_DATA = `data +%s`

data:
	echo $(SIM_DATA)

simregr:
	@echo $(SIM_DATA)
	sh ../sim_cfg/regr.sh ../sim_cfg/testlist > sim_regr.log
	@echo $(SIM_DATA)

urg:
	urg -full64 -dir ./simv.vdb -format both
	firefox urgReport/dashboard.html

urghvp:
	urg -full64 -dir ./simv.vdb -format both -plan ../tb/plan.hvp
	firefox urgReport/dashboard.html

#step 4 : view
verdi:
	verdi -nologo +v2k -sverilog  \
	-elab ./simv.daidir/kdb.elab++ \
	-ssf verilog.fsdb & 
		
clean:
	@echo "Cleaning up ..."
		@rm -rf csrc DVEfiles simv simv.daidir ucli.key VCS*
		@rm -rf *.log *.vpd *.ddc *.svf *SDF *Synth *Netlist* *.fsdb
		@rm -rf alib-52 64 work.lib++ vhdlanLog urgReport
		@rm -rf AN.DB novas.* simv.cst  vc_hdrs.h

cleanall:clean
	@echo "Cleaning up ..."
	@rm -rf simv.vdb verdi* .fsm.sch.verilog.xml