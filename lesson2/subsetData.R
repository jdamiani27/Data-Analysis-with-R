statesInfo <- read.csv('stateData.csv')

stateSubset <- subset(statesInfo, state.region == 1)

stateSubsetBracket <- statesInfo[statesInfo$state.region == 1,]
