program g
    use utilities
    use clusterlabelling
    implicit none

    character(len=:), allocatable :: filename
    integer :: num_samples, i, j, fileunit, L, firstindex, lastindex, num_sizes
    real(kind=dp), dimension(:), allocatable :: cluster_number_densities, sizes

    num_samples = 1000

    do i = 4, 9
        L = 2**i
        call cluster_number_density(pc, L, num_samples, sizes, cluster_number_densities)
        num_sizes = size(sizes)

        firstindex = int(0.2*num_sizes + 0.5)
        lastindex  = int(0.8*num_sizes + 0.5)

        filename = "tmp/g_" // stringfromint(i) // ".dat"
        open(unit=fileunit, file=filename, status="replace")
        do j = 1, num_sizes
            write(unit=fileunit,fmt=*) sizes(j), cluster_number_densities(j)
        end do
        close(unit=fileunit)
    end do
end program g
