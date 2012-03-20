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
		graph << [:ResourceAllocation, RDFS.subClassOf, :Allocation] 
		graph << [:ResourcePartAllocation, RDFS.subClassOf, :Allocation] 

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
		graph << [:hasVariable, RDF.type, RDFS.Property] 
		graph << [:hasVariable, RDFS.subPropertyOf, :hasType] 
		graph << [:hasVariable, RDFS.range, :Variable]

		# property hasMeta
		graph << [:hasMeta, RDF.type, RDFS.Property] 
		graph << [:hasMeta, RDFS.range, :Meta]
		graph << [:hasMeta, RDFS.domain, :Corpus]
		graph << [:hasMeta, RDFS.domain, :Design]
		graph << [:hasMeta, RDFS.domain, :Resource]
		graph << [:hasMeta, RDFS.domain, :ResourcePart] # TODO sure?
		graph << [:hasMeta, RDFS.domain, :DesignComponent]

                # property metaEntry
		graph << [:metaEntry, RDF.type, RDFS.Property] 
		graph << [:metaEntry, RDFS.domain, :Meta] 
		graph << [:metaEntry, RDFS.range, RDFS.Literal] # TODO string

                # property metaEntryKeys
		graph << [:metaEntryKeys, RDF.type, RDFS.Property] 
		graph << [:metaEntryKeys, RDFS.domain, :Meta]
		graph << [:metaEntryKeys, RDFS.range, RDFS.Literal] # TODO string

		# property title
		graph << [:hasTitle, RDF.type, RDF.Property]
		graph << [:hasTitle, RDFS.range, RDFS.Literal] # TODO string
		graph << [:hasTitle, RDFS.domain, :Corpus]
		graph << [:hasTitle, RDFS.domain, :Design]
		graph << [:hasTitle, RDFS.domain, :Resource]
		graph << [:hasTitle, RDFS.domain, :ResourcePart]
		graph << [:hasTitle, RDFS.domain, :Participant]
		graph << [:hasTitle, RDFS.domain, :DesignComponent]
		graph << [:hasTitle, RDFS.domain, :Variable]
		graph << [:hasTitle, RDFS.domain, :Trial]

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
=begin		graph << [:creatorData, RDF.type, RDF.Property]
		graph << [:creatorData, RDFS.domain, :Design]
		graph << [:creatorData, RDFS.range, RDFS.Literal] # TODO no idea

		# property productionStatus # TODO not in corpus-1.0.pdf
		graph << [:productionStatus, RDF.type, RDF.Property]
		graph << [:productionStatus, RDFS.domain, :Design]
		graph << [:productionStatus, RDFS.range, RDFS.Literal] # TODO no idea
=end

		# property description
		graph << [:description, RDF.type, RDF.Property]
		graph << [:description, RDFS.domain, :Design]
		graph << [:description, RDFS.domain, :Resource]
		graph << [:description, RDFS.domain, :DesignComponent]
		graph << [:description, RDFS.domain, :Corpus]
		graph << [:description, RDFS.domain, :ResourcePart] # TODO sure?
		graph << [:description, RDFS.range, RDFS.Literal] # TODO no idea

		# property required
		graph << [:required, RDF.type, RDF.Property]
		graph << [:required, RDFS.range, RDFS.Literal] # TODO boolean
		graph << [:required, RDFS.domain, :DesignComponent] 

		# property participant
		graph << [:participant, RDF.type, RDF.Property]
		graph << [:participant, RDFS.range, :Participant] 
		graph << [:participant, RDFS.domain, :DesignComponent] 

		# property mediaType
		graph << [:mediaType, RDF.type, RDF.Property]
		graph << [:mediaType, RDFS.domain, :Resource] 
		graph << [:mediaType, RDFS.domain, :DesignComponent] 
		graph << [:mediaType, RDFS.range, :MediaType]

		# property type
		graph << [:participantType, RDF.type, RDF.Property]
		graph << [:participantType, RDFS.domain, :Participant] 
		graph << [:participantType, RDFS.range, :ParticipantValue]

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
