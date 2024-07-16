using CairoMakie
using JSON, CSV
using DataFrames, Statistics

fullhl = ["cloudflare" ,"vercel" ,"github" , "netlify","render"];
hostinglist = [ "cloudflare" ];


CairoMakie.activate!(type = "svg")
list = [];
i= 1
for folder in fullhl
    # readdir("data/$folder")
    b = Dict("target" => folder, "index" => i) 
    global i= i+1
    for file in readdir("data/$folder")
        print("data/$folder/$file \n")  
        data = JSON.parsefile("data/$folder/$file");
        merge!(data, b)
        push!(list,data)
        # DataFrame(JSON.parsefile("data/$folder/$file"))   
        # JSON.parsefile("data/$folder/$file") # full path

    end
end

maxtime = 500

origdf = DataFrame(list)

df = filter(row -> row.time_total < maxtime, origdf)

# CSV.write("data.csv", df)
category_labels =  fullhl #readdir("data")
colors = Makie.wong_colors()
palette= colors[indexin(category_labels, unique(category_labels))]


rainclouds(df.index, df.time_total;
    axis = (; ylabel = "Providers", xlabel = "Total Time (ms)", title = "", yticks = (1:5, fullhl), limits = (0,maxtime,nothing, nothing)),
    orientation = :horizontal,
    plot_boxplots = true, cloud_width=0.5, clouds=hist, hist_bins=100 
  #  ,color = palette
    )

## Mean stats


for provider in fullhl
    time = mean(filter(row -> row.target == provider, df).time_total)
    print("$provider time: $time\n")
end
