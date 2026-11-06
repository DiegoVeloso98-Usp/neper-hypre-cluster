! MOOSE adapter for the Oxford plugin. The original UEXTERNALDB entry point is
! renamed at build time; no constitutive or integration routines are changed.
subroutine uexternaldb(lop, lrestart, time, dtime, kstep, kinc)
  use globalvariables, only: linc_0_all
  use userinputs, only: maxnmaterial, maxnslip, numel
  use scalability_indices, only: element_map, used_elements
  implicit none
  integer :: ranks, ios
  character(len=32) :: rank_text
  integer, intent(in) :: lop, lrestart, kstep, kinc
  real(8), intent(in) :: time(2), dtime
  real(8) :: abaqus_time(2)
  external :: oxford_uexternaldb

  if (lop == 0) then
    ranks = 1
    call get_environment_variable('CP_MPI_SIZE', rank_text, status=ios)
    if (ios == 0) read(rank_text, *, iostat=ios) ranks
    if (ios /= 0 .or. ranks < 1) error stop 'Cannot read MPI size'
    ! METIS partitions are near-balanced; leave room for imbalance/ghost use.
    numel = ceiling(1.20d0 * 1000000 / ranks) + 1024
    allocate(element_map(1000000))
    element_map = 0
    used_elements = 0
    write(*,*) 'Oxford rank-local element capacity:', numel
  endif
  abaqus_time = time
  ! MOOSE's stock adapter supplies TIME(2) = t-dt even at TIMESTEP_END.
  ! Abaqus UEXTERNALDB receives the accepted end time for LOP=2.
  if (lop == 2) abaqus_time(2) = time(1)
  call oxford_uexternaldb(lop, lrestart, abaqus_time, dtime, kstep, kinc)

  if (lop == 0) then
    ! initialize_atfirstinc stores nslip+nscrew line directions here, while
    ! this source release initially allocates only maxnslip rows. Reserve the
    ! same capacity as its local linc(maxnslip*2,3) without inflating maxnslip:
    ! maxnslip must match the explicit array strides used for the FCC vectors.
    deallocate(linc_0_all)
    allocate(linc_0_all(maxnmaterial, 2*maxnslip, 3))
    linc_0_all = 0.0d0
  end if
end subroutine uexternaldb
