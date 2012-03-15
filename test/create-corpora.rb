require 'rdf'
include RDF
require 'rdf/ntriples'

RDF::Writer.open("multimodal-corpora.nt") do |writer| 
	writer << RDF::Graph.new do |graph|
		# classes
		graph << [:Corpus, RDF.type, RDFS.Class]
		graph << [:Design, RDF.type, RDFS.Class]
		graph << [:DesignComponent, RDF.type, RDFS.Class]
		graph << [:Trial, RDF.type, RDFS.Class]
		graph << [:Meta, RDF.type, RDFS.Class]
		graph << [:MetaEntry, RDF.type, RDFS.Class]
		graph << [:MetaEntryKeys, RDF.type, RDFS.Class]
		graph << [:Resource, RDF.type, RDFS.Class]
		graph << [:ResourcePart, RDF.type, RDFS.Class]
		graph << [:MediaTypes, RDF.type, RDFS.Class]
		graph << [:Participant, RDF.type, RDFS.Class]
		graph << [:ParticipantValues, RDF.type, RDFS.Class]
		graph << [:Variable, RDF.type, RDFS.Class]
		graph << [:Allocation, RDF.type, RDFS.Class]
		graph << [:ResourceAllocation, RDF.type, RDFS.Class]
		graph << [:ResourcePartAllocation, RDF.type, RDFS.Class]
		graph << [:VariableAllocation, RDF.type, RDFS.Class]
		graph << [:ComponentAllocations, RDF.type, RDFS.Class]

		# subclasses
		graph << [:MetaEntry, RDFS.subClassOf, :Meta]
		graph << [:MetaEntryKeys, RDFS.subClassOf, :Meta]
		graph << [:ResourceAllocation, RDFS.subClassOf, :Allocation] 
		graph << [:ResourcePartAllocation, RDFS.subClassOf, :ResourceAllocation] # TODO oder von Allocation?
		graph << [:ResourcePart, RDFS.subClassOf, :Resource] # TODO tatsächlich??

		# corpus properties
		graph << [:hasType, RDF.type, RDFS.Property]
		graph << [:hasType, RDFS.domain, :Corpus]
		graph << [:hasTrial, RDF.type, RDFS.Property]
		graph << [:hasTrial, RDFS.subPropertyOf, :hasType]
		graph << [:hasTrial, RDFS.range, :Trial]
		graph << [:hasDesign, RDF.type, RDFS.Property]
		graph << [:hasDesign, RDFS.subPropertyOf, :hasType]
		graph << [:hasDesign, RDFS.range, :Design]
		graph << [:hasResource, RDF.type, RDFS.Property]
		graph << [:hasResource, RDFS.subPropertyOf, :hasType]
		graph << [:hasResource, RDFS.range, :Resource]
		graph << [:hasResourceAllocation, RDF.type, RDFS.Property]
		graph << [:hasResourceAllocation, RDFS.subPropertyOf, :hasType]
		graph << [:hasResourceAllocation, RDFS.range, :ResourceAllocation]
		graph << [:hasResourcePartAllocation, RDF.type, RDFS.Property]
		graph << [:hasResourcePartAllocation, RDFS.subPropertyOf, :hasType]
		graph << [:hasResourcePartAllocation, RDFS.range, :ResourcePartAllocation]
		graph << [:hasMeta, RDF.type, RDFS.Property] # TODO abhängig von Design, DesignComponent und Resource?
		graph << [:hasMeta, RDFS.subPropertyOf, :hasType] # TODO abhängig von Design, DesignComponent und Resource?
		graph << [:hasMeta, RDFS.range, :Meta] # TODO abhängig von Design, DesignComponent und Resource?
		graph << [:hasVariable, RDF.type, RDFS.Property] # TODO without any connection
		graph << [:hasVariable, RDFS.subPropertyOf, :hasType] # TODO without any connection
		graph << [:hasVariable, RDFS.range, :Variable]# TODO without any connection

		# property title
		graph << [:hasTitle, RDF.type, RDF.Property]
		graph << [:hasTitle, RDFS.range, RDFS.Literal] # TODO string
		graph << [:hasName, RDFS.domain, :Corpus]
		graph << [:hasName, RDFS.domain, :Design]
		graph << [:hasName, RDFS.domain, :Resource]
		graph << [:hasName, RDFS.domain, :ResourcePart]
		graph << [:hasName, RDFS.domain, :Participant]
		graph << [:hasName, RDFS.domain, :DesignComponent]
		graph << [:hasName, RDFS.domain, :Variable]
		graph << [:hasName, RDFS.domain, :Trial]

		# property name
		graph << [:hasName, RDF.type, RDF.Property]
		graph << [:hasName, RDFS.range, RDFS.Literal] # TODO string
		graph << [:hasName, RDFS.domain, :Corpus]
		graph << [:hasName, RDFS.domain, :Design]
		graph << [:hasName, RDFS.domain, :Resource]
		graph << [:hasName, RDFS.domain, :ResourcePart]
		graph << [:hasName, RDFS.domain, :Participant]
		graph << [:hasName, RDFS.domain, :DesignComponent]
		graph << [:hasName, RDFS.domain, :Variable]
		graph << [:hasName, RDFS.domain, :Trial]

		# propoerty id
		graph << [:hasId, RDF.type, RDF.Property]
		graph << [:hasId, RDFS.range, RDFS.Literal] # TODO id
		graph << [:hasId, RDFS.domain, :Corpus]
		graph << [:hasId, RDFS.domain, :Participant]
		graph << [:hasId, RDFS.domain, :Variable]
		graph << [:hasId, RDFS.domain, :Design]
		graph << [:hasId, RDFS.domain, :DesignComponent]
		graph << [:hasId, RDFS.domain, :Trial]
		graph << [:hasId, RDFS.domain, :Resource]
		graph << [:hasId, RDFS.domain, :ResourcePart]

		# property designComponent
		graph << [:designComponent, RDF.type, RDF.Property]
		graph << [:designComponent, RDFS.domain, :Design]
		graph << [:designComponent, RDFS.range, :DesignComponent]

		# property creatorData # TODO not in corpus-1.0.pdf
		graph << [:creatorData, RDF.type, RDF.Property]
		graph << [:creatorData, RDFS.domain, :Design]
		graph << [:creatorData, RDFS.range, RDFS.Literal] # TODO no idea

		# property productionStatus # TODO not in corpus-1.0.pdf
		graph << [:productionStatus, RDF.type, RDF.Property]
		graph << [:productionStatus, RDFS.domain, :Design]
		graph << [:productionStatus, RDFS.range, RDFS.Literal] # TODO no idea

		# property description # TODO not in corpus-1.0.pdf
		graph << [:description, RDF.type, RDF.Property]
		graph << [:description, RDFS.domain, :Design]
		graph << [:description, RDFS.domain, :Resource]
		graph << [:description, RDFS.domain, :DesignComponent]
		graph << [:description, RDFS.range, RDFS.Literal] # TODO no idea

		# property required
		graph << [:required, RDF.type, RDF.Property]
		graph << [:required, RDFS.range, RDFS.Literal] # TODO boolean
		graph << [:required, RDFS.domain, :DesignComponent] 

		# property participant # TODO not in corpus-1.0.pdf
		graph << [:participant, RDF.type, RDF.Property]
		graph << [:participant, RDFS.range, :Participant] 
		graph << [:participant, RDFS.domain, :DesignComponent] 

		# property correspondingDesignComponent (or does this connection work over Allocations, NOT SURE)
		graph << [:correspondingDesignComponent, RDF.type, RDF.Property]
		graph << [:correspondingDesignComponent, RDFS.domain, :Trial]
		graph << [:correspondingDesignComponent, RDFS.range, :DesignComponent]

		# property mediaType
		graph << [:mediaType, RDF.type, RDF.Property]
		graph << [:mediaType, RDFS.domain, :Resource] 
		graph << [:mediaType, RDFS.domain, :DesignComponent] 
		graph << [:mediaType, RDFS.range, :MediaType]

		# property type (participantValue was type in written schema)
		graph << [:participantValue, RDF.type, RDF.Property]
		graph << [:participantValue, RDFS.domain, :Participant] 
		graph << [:participantValue, RDFS.range, :ParticipantValue]

		# property participant
		graph << [:participant, RDF.type, RDF.Property]
		graph << [:participant, RDFS.domain, :DesignComponent]
		graph << [:participant, RDFS.range, :Participant]

		# property isocat
		graph << [:isocat, RDF.type, RDF.Property]
		graph << [:isocat, RDFS.domain, :MetaEntry] 
		graph << [:isocat, RDFS.range, RDFS.URI] 

		# property uri
		graph << [:uri, RDF.type, RDF.Property]
		graph << [:uri, RDFS.domain, :Resource] 
		graph << [:uri, RDFS.range, RDFS.URI] 

		# property key
		graph << [:key, RDF.type, RDF.Property]
		graph << [:key, RDFS.range, RDFS.Literal] # TODO string
		graph << [:key, RDFS.domain, :MetaEntry] 

		# property code
		graph << [:code, RDF.type, RDF.Property]
		graph << [:code, RDFS.range, RDFS.Literal] # TODO string
		graph << [:code, RDFS.domain, :Participant] 

		# property variable
		graph << [:variable, RDF.type, RDF.Property]
		graph << [:variable, RDFS.range, :Variable]
		graph << [:variable, RDFS.domain, :VariableAllocation] #TODO fehlt in rdf.rb

		# property resource
		graph << [:resource, RDF.type, RDF.Property]
		graph << [:resource, RDFS.range, :Resource]
		graph << [:resource, RDFS.domain, :ResourceAllocation] 

		# property designComponent
		graph << [:designComponent, RDF.type, RDF.Property]
		graph << [:designComponent, RDFS.range, :DesignComponent]
		graph << [:designComponent, RDFS.domain, :Allocation] 

		# property trial
		graph << [:trial, RDF.type, RDF.Property]
		graph << [:trial, RDFS.range, :Trial]
		graph << [:trial, RDFS.domain, :Allocation] 

		# property hasResourcePart
		graph << [:hasResourcePart, RDF.type, RDF.Property]
		graph << [:hasResourcePart, RDFS.range, :ResourcePart]
		graph << [:hasResourcePart, RDFS.domain, :Resource]

		# property resourcePart
		graph << [:resourcePart, RDF.type, RDF.Property]
		graph << [:resourcePart, RDFS.range, :ResourcePart]
		graph << [:resourcePart, RDFS.domain, :ResourcePartAllocation]

		# property serialNumber
		graph << [:serialNumber, RDF.type, RDF.Property]
		graph << [:serialNumber, RDFS.range, RDFS.Literal] # TODO unsigned int
		graph << [:serialNumber, RDFS.domain, :Trial]

		# property design
		graph << [:design, RDF.type, RDF.Property]
		graph << [:design, RDFS.range, :Design]
		graph << [:design, RDFS.domain, :Trial]

		# property internalLocation
		graph << [:internalLocation, RDF.type, RDF.Property]
		graph << [:internalLocation, RDFS.domain, :ResourcePart] 
		graph << [:internalLocation, RDFS.range, RDFS.Literal] # TODO string
	end
end
