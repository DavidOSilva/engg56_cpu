transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/david/Dropbox/UFBA/Semestre\ 2023.2/ENGG56\ -\ PROJETO\ DE\ CIRCUITOS\ INTEGRADOS\ DIGITAIS/TRABALHO\ FINAL/ENGG56_CPU/ULA {C:/Users/david/Dropbox/UFBA/Semestre 2023.2/ENGG56 - PROJETO DE CIRCUITOS INTEGRADOS DIGITAIS/TRABALHO FINAL/ENGG56_CPU/ULA/ula.v}

