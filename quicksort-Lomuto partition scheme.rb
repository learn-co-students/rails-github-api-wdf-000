def quicksort(arr, lo, hi)
    if lo < hi
        pivot = partition(arr, lo, hi)
        quicksort(arr,lo,pivot - 1)
        quicksort(arr,pivot + 1,hi)
    end
    
end

def partition(arr, lo, hi)
    pivot = arr[hi]
    i = lo
    (lo..hi - 1).to_a.each do |j|
        if arr[j] <= pivot
            temp = arr[i]
            arr[i] = arr[j]
            arr[j] = temp
            
            i += 1
        end
    end
    
    temp = arr[i]
    arr[i] = arr[hi]
    arr[hi] = temp
    
    return i
end


arr = [155,43,56,3,6,3]

quicksort(arr, 0, 5)
arr