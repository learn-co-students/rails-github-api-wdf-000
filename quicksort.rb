require 'benchmark'

def array_sort(unsorted_arr, flag=false, count=0)
	
	if flag
		return unsorted_arr
	else
		count -= 1
		index_arr = Array.new(10) {[]}
		nil_flag = true
		
		unsorted_arr.each do |n|
			n_s = n.to_s[count]
				
			if n_s && n_s.to_i
				nil_flag = false
				index_arr[n.to_s[count].to_i] << n
			else
				index_arr[0] << n
			end
		end
		
		unless nil_flag
			unsorted_arr = []
			index_arr.each_with_object(unsorted_arr) do |n_a, obj|
				n_a.each {|n| obj << n }
			end
		end
		
		array_sort(unsorted_arr, nil_flag, count)
	end
end

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


arr = 1000000.times.map{ 20 + Random.rand(1000) } 

Benchmark.bmbm do |x|
  x.report("radix_sort") { sorted_arr = array_sort(arr) }
  x.report("qucik_sort") { 
  	quicksort(arr, 0, arr.length - 1) 
  	sorted_arr = arr
  }
end