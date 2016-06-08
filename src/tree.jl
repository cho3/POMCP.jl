abstract BeliefNode{S,A,O,B}

type ActNode{S,A,O,B}
    label::A # for keeping track of which action this corresponds to
    N::Int64
    V::Float64
    parent::BeliefNode
    children::Dict{O,BeliefNode{S,A,O,B}} # maps observations to ObsNodes

    #ActNode() = new()
    #ActNode(l,N::Int64,V::Float64,p::BeliefNode,c) = new(l,N,V,p,c)

end
#ActNode(l,N::Int64,V::Float64,p::BeliefNode,c) = ActNode(l,N,V,p,c)

# XXX might be faster if I know the exact belief type and obs type -> should parameterize
type ObsNodeDPW{S,A,O,Belief} <: BeliefNode{S,A,O,Belief}
    label::Tuple{O,S,Real}
    N::Int64
    B::Belief # belief/state distribution
    parent::ActNode{S,A,O,Belief}
    children::Dict{A,ActNode{S,A,O,Belief}}

    #ObsNode() = new()
end

type ObsNode{S,A,O,Belief} <: BeliefNode{S,A,O,Belief}
    label::O
    N::Int64
    B::Belief # belief/state distribution
    parent::ActNode{S,A,O,Belief}
    children::Dict{A,ActNode{S,A,O,Belief}}

    #ObsNode() = new()
end
#ObsNode(l,N,B,p,c) = new(l,N,B,p,c)

type RootNode{S,A,O,Belief,RootBelief} <: BeliefNode{S,A,O,Belief}
    N::Int64
    B::RootBelief # belief/state distribution
    children::Dict{A,ActNode{S,A,O,Belief}}
end

"""
    init_V(problem::POMDPs.POMDP, h::BeliefNode, action)

Return the initial value (V) associated with a new action node when it is created. This can be used in concert with `init_N` to incorporate prior experience into the solver.
"""
function init_V(problem::POMDPs.POMDP, h::BeliefNode, action)
    return 0.0
end

"""
    init_N(problem::POMDPs.POMDP, h::BeliefNode, action)

Return the initial number of queries (N) associated with a new action node when it is created.
"""
function init_N(problem::POMDPs.POMDP, h::BeliefNode, action)
    return 0
end
