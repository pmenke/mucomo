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
		graph << [:ResourcePartAllocation, RDFS.subClassOf, :ResourceAllocation]
		graph << [:ResourcePart, RDFS.subClassOf, :Resource]

		# corpus properties
		graph << [:hasType, RDF.type, RDFS.Property]
		graph << [:hasType, RDFS.domain, :Corpus]
		graph << [:hasTrial, RDF.type, RDFS.Property]
		graph << [:hasTrial, RDFS.subPropertyOf, :hasType]
		graph << [:hasTrial, RDFS.range, :Trial]
		graph << [:hasDesign, RDF.type, RDFS.Property]
		graph << [:hasDesign, RDFS.subPropertyOf, :hasType]
		graph << [:hasDesign, RDFS.range, :Design]
		graph << [:hasParticipant, RDF.type, RDFS.Property]
		graph << [:hasParticipant, RDFS.subPropertyOf, :hasType]
		graph << [:hasParticipant, RDFS.range, :Participant]
		graph << [:hasResource, RDF.type, RDFS.Property]
		graph << [:hasResource, RDFS.subPropertyOf, :hasType]
		graph << [:hasResource, RDFS.range, :Resource]
		graph << [:hasMeta, RDF.type, RDFS.Property]
		graph << [:hasMeta, RDFS.subPropertyOf, :hasType]
		graph << [:hasMeta, RDFS.range, :Meta]
		graph << [:hasVariable, RDF.type, RDFS.Property]
		graph << [:hasVariable, RDFS.subPropertyOf, :hasType]
		graph << [:hasVariable, RDFS.range, :Variable]	

		# property name
		graph << [:name, RDF.type, RDF.Property]
		graph << [:name, RDFS.range, RDFS.Literal] # TODO string
		graph << [:name, RDFS.domain, :Corpus]
		graph << [:name, RDFS.domain, :Design]
		graph << [:name, RDFS.domain, :Resource]
		graph << [:name, RDFS.domain, :ResourcePart]
		graph << [:name, RDFS.domain, :Participant]
		graph << [:name, RDFS.domain, :DesignComponent]
		graph << [:name, RDFS.domain, :Variable]
		graph << [:name, RDFS.domain, :Trial]

		# propoerty id
		graph << [:id, RDF.type, RDF.Property]
		graph << [:id, RDFS.range, RDFS.Literal] # TODO id
		graph << [:id, RDFS.domain, :Corpus]
		graph << [:id, RDFS.domain, :Participant]
		graph << [:id, RDFS.domain, :Variable]
		graph << [:id, RDFS.domain, :Design]
		graph << [:id, RDFS.domain, :DesignComponent]
		graph << [:id, RDFS.domain, :Trial]
		graph << [:id, RDFS.domain, :Resource]
		graph << [:id, RDFS.domain, :ResourcePart]

		# property isDesignComponentOf
		graph << [:isDesignComponentOf, RDF.type, RDF.Property]
		graph << [:isDesignComponentOf, RDFS.domain, :DesignComponent]
		graph << [:isDesignComponentOf, RDFS.range, :Design]

		# property required
		graph << [:required, RDF.type, RDF.Property]
		graph << [:required, RDFS.range, RDFS.Literal] # TODO boolean
		graph << [:required, RDFS.domain, :DesignComponent]

		# property correspondingDesignComponent (or does this connection work over Allocations, NOT SURE)
		graph << [:correspondingDesignComponent, RDF.type, RDF.Property]
		graph << [:correspondingDesignComponent, RDFS.domain, :Trial]
		graph << [:correspondingDesignComponent, RDFS.range, :DesignComponent]

		# property mediaType
		graph << [:mediaType, RDF.type, RDF.Property]
		graph << [:mediaType, RDFS.domain, :Resource]
		graph << [:mediaType, RDFS.domain, :DesignComponent]
		graph << [:mediaType, RDFS.range, :MediaType]

		# property type (better participantValue)
		graph << [:type, RDF.type, RDF.Property]
		graph << [:type, RDFS.domain, :Participant]
		graph << [:type, RDFS.range, :ParticipantValue]

		# property participant
		graph << [:participant, RDF.type, RDF.Property]
		graph << [:participant, RDFS.domain, :DesignComponent]
		graph << [:participant, RDFS.range, :Participant]

		# property isocat
		graph << [:isocat, RDF.type, RDF.Property]
		graph << [:isocat, RDFS.domain, :MetaEntry]
		graph << [:isocat, RDFS.range, RDFS.URI] # TODO

		# property uri
		graph << [:uri, RDF.type, RDF.Property]
		graph << [:uri, RDFS.domain, :Resource]
		graph << [:uri, RDFS.range, RDFS.URI] # TODO

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
		graph << [:variable, RDFS.domain, :VariableAllocation]

		# property resource
		graph << [:resource, RDF.type, RDF.Property]
		graph << [:resource, RDFS.range, :Resource]
		graph << [:resource, RDFS.domain, :ResourceAllocation]

		# property component
		graph << [:component, RDF.type, RDF.Property]
		graph << [:component, RDFS.range, :DesignComponent]
		graph << [:component, RDFS.domain, :Allocation]

		# property trial
		graph << [:trial, RDF.type, RDF.Property]
		graph << [:trial, RDFS.range, :Trial]
		graph << [:trial, RDFS.domain, :Allocation]

		# property resourcepart
		graph << [:resourcepart, RDF.type, RDF.Property]
		graph << [:resourcepart, RDFS.range, :ResourcePart]
		graph << [:resourcepart, RDFS.domain, :ResourcePartAllocation]

		# property serialNumber
		graph << [:serialNumber, RDF.type, RDF.Property]
		graph << [:serialNumber, RDFS.range, RDFS.Literal] # TODO unsigned int
		graph << [:serialNumber, RDFS.domain, :Trial]

		# property design
		graph << [:design, RDF.type, RDF.Property]
		graph << [:design, RDFS.range, :Design]
		graph << [:design, RDFS.domain, :Trial]

		# property internallocation
		graph << [:internallocation, RDF.type, RDF.Property]
		graph << [:internallocation, RDFS.domain, :ResourcePart]
		graph << [:internallocation, RDFS.range, RDFS.Literal] # TODO string
	end
end
