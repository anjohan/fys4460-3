program c
    use utilities
    use clusterlabelling

    implicit none

    integer :: i,j,k, fileunit
    integer, parameter :: L = 256, num_probabilities = 1000, num_samples = 100
    real(kind=dp), dimension(:), allocatable :: probabilities, spanning_densities
    real(kind=dp), dimension(:), allocatable :: estimated_densities
    character(len=:), allocatable :: fmtstring, filename
    real(kind=dp) :: beta, const

    allocate(spanning_densities(num_probabilities))
    probabilities = linspace(1.000000000001d0*pc, 1.2d0*pc, num_probabilities)

    do i=1, num_probabilities
        spanning_densities(i) = spanning_density(probabilities(i), L, num_samples)
    end do

    call linfit(log10(probabilities - pc), log10(spanning_densities), beta, const)

    estimated_densities = (probabilities - pc)**beta * 10**const

    fmtstring = "(f0.6,x,f0.6,x,f0.6)"
    filename = "tmp/c_P.dat"
    open(newunit=fileunit, file=filename, status="replace")

    do i=1, num_probabilities
        write(unit=fileunit, fmt=fmtstring) probabilities(i), spanning_densities(i), &
                                            estimated_densities(i)
    end do
    close(unit=fileunit)

    open(newunit=fileunit, file="tmp/c_beta.dat", status="replace")
    write(unit=fileunit, fmt="(f0.3)") beta
    close(unit=fileunit)

end program c
