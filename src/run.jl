using CairoMakie
using JSON, CSV
using DataFrames, Statistics
using Colors


# folders = readdir("data")
Folders = []

fullhl = ["cloudflare" ,"vercel" ,"github" , "netlify","render"];
hostinglist = [ "cloudflare" ];


CairoMakie.activate!(type = "svg")
list = [];
i= 1
for folder in fullhl
    # readdir("data/$folder")
    push!(Folders,titlecase(folder))
    b = Dict("target" => titlecase(folder), "index" => i) 
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

for provider in Folders
    time = mean(filter(row -> row.target == provider, df).time_total)
    print("$provider time: $time\n")
end


set_theme!(theme_minimal())

# CSV.write("data.csv", df)
category_labels =  fullhl #readdir("data")
colors = Makie.wong_colors()
palette= colors[indexin(category_labels, unique(category_labels))]

palette = distinguishable_colors(5)

rainclouds(df.target, df.time_total;
    axis = (; ylabel = "", xlabel = "Total Time (ms)", title = "", yticks = (1:5, Folders), limits = (0,maxtime,nothing, nothing)),
    orientation = :horizontal,
    gap=0.05,
    plot_boxplots = true, cloud_width=0.5, clouds=hist, hist_bins=100 
    
    # , color = palette
   )

## Mean stats


