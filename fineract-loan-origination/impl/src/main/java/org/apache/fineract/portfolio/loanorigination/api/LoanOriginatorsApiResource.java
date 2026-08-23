/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.apache.fineract.portfolio.loanorigination.api;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.DELETE;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import org.apache.fineract.commands.domain.CommandWrapper;
import org.apache.fineract.commands.service.CommandWrapperBuilder;
import org.apache.fineract.commands.service.PortfolioCommandSourceWritePlatformService;
import org.apache.fineract.infrastructure.core.data.CommandProcessingResult;
import org.apache.fineract.infrastructure.security.service.PlatformSecurityContext;
import org.apache.fineract.portfolio.loanaccount.exception.LoanNotFoundException;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanExistencePort;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanReadPlatformServiceCommon;
import org.apache.fineract.portfolio.loanorigination.data.LoanOriginatorMappingResponse;
import org.apache.fineract.portfolio.loanorigination.data.LoanOriginatorsResponse;
import org.apache.fineract.portfolio.loanorigination.service.LoanOriginatorReadPlatformService;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Component;

@Path("/v1/loans")
@Component
@ConditionalOnProperty(value = "fineract.module.loan-origination.enabled", havingValue = "true")
@Tag(name = "Loan Originators", description = "Fetch loan originator details for a specific loan")
public class LoanOriginatorsApiResource {
    private static final String LOAN_RESOURCE_NAME = "LOAN";
    private final PlatformSecurityContext context;
    private final LoanExistencePort loanExistencePort;
    private final LoanReadPlatformServiceCommon loanReadPlatformService;
    private final LoanOriginatorReadPlatformService loanOriginatorReadPlatformService;
    private final PortfolioCommandSourceWritePlatformService commandsSourceWritePlatformService;

    @GET
    @Path("{loanId}/originators")
    @Produces({MediaType.APPLICATION_JSON})
    @Operation(summary = "Retrieve originators for a loan by loan ID", description = "Retrieves all originators attached to a specific loan. Requires READ_LOAN permission.")
    @ApiResponse(responseCode = "200", description = "OK - Returns wrapped list of originators (may be empty)", content = @Content(schema = @Schema(implementation = LoanOriginatorsResponse.class)))
    @ApiResponse(responseCode = "403", description = "Insufficient permissions")
    @ApiResponse(responseCode = "404", description = "Loan not found")
    public LoanOriginatorsResponse retrieveOriginatorsByLoanId(@PathParam("loanId") @Parameter(description = "loanId") final Long loanId) {
        this.context.authenticatedUser().validateHasReadPermission(LOAN_RESOURCE_NAME);
        if (!this.loanExistencePort.existsById(loanId)) {
            throw new LoanNotFoundException(loanId);
        }
        return LoanOriginatorsResponse.of(this.loanOriginatorReadPlatformService.retrieveByLoanId(loanId));
    }

    @GET
    @Path("external-id/{loanExternalId}/originators")
    @Produces({MediaType.APPLICATION_JSON})
    @Operation(summary = "Retrieve originators for a loan by loan external ID", description = "Retrieves all originators attached to a specific loan using loan external ID. Requires READ_LOAN permission.")
    @ApiResponse(responseCode = "200", description = "OK - Returns wrapped list of originators (may be empty)", content = @Content(schema = @Schema(implementation = LoanOriginatorsResponse.class)))
    @ApiResponse(responseCode = "403", description = "Insufficient permissions")
    @ApiResponse(responseCode = "404", description = "Loan not found")
    public LoanOriginatorsResponse retrieveOriginatorsByLoanExternalId(@PathParam("loanExternalId") @Parameter(description = "loanExternalId") final String loanExternalId) {
        this.context.authenticatedUser().validateHasReadPermission(LOAN_RESOURCE_NAME);
        final Long loanId = this.loanReadPlatformService.getLoanIdByLoanExternalId(loanExternalId);
        return LoanOriginatorsResponse.of(this.loanOriginatorReadPlatformService.retrieveByLoanId(loanId));
    }

    @POST
    @Path("{loanId}/originators/{originatorId}")
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    @Operation(summary = "Attach originator to loan by IDs", description = "Attaches an originator to a loan. Loan must be in \'Submitted and Pending Approval\' status. Requires ATTACH_LOAN_ORIGINATOR permission.")
    @ApiResponse(responseCode = "200", description = "OK - Originator attached", content = @Content(schema = @Schema(implementation = LoanOriginatorMappingResponse.class)))
    @ApiResponse(responseCode = "403", description = "Loan not in correct status, originator not ACTIVE, duplicate mapping, or insufficient permissions")
    @ApiResponse(responseCode = "404", description = "Loan or originator not found")
    public LoanOriginatorMappingResponse attachOriginatorToLoan(@PathParam("loanId") @Parameter(description = "loanId") final Long loanId, @PathParam("originatorId") @Parameter(description = "originatorId") final Long originatorId) {
        final CommandWrapper commandRequest = new CommandWrapperBuilder().attachLoanOriginator(loanId, originatorId).build();
        final CommandProcessingResult result = this.commandsSourceWritePlatformService.logCommandSource(commandRequest);
        return buildMappingResponse(result);
    }

    @POST
    @Path("{loanId}/originators/external-id/{originatorExternalId}")
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    @Operation(summary = "Attach originator to loan by loan ID and originator external ID")
    @ApiResponse(responseCode = "200", description = "OK", content = @Content(schema = @Schema(implementation = LoanOriginatorMappingResponse.class)))
    @ApiResponse(responseCode = "403", description = "Loan not in correct status, originator not ACTIVE, duplicate mapping")
    @ApiResponse(responseCode = "404", description = "Loan or originator not found")
    public LoanOriginatorMappingResponse attachOriginatorToLoanByOriginatorExternalId(@PathParam("loanId") @Parameter(description = "loanId") final Long loanId, @PathParam("originatorExternalId") @Parameter(description = "originatorExternalId") final String originatorExternalId) {
        final Long originatorId = this.loanOriginatorReadPlatformService.resolveIdByExternalId(originatorExternalId);
        final CommandWrapper commandRequest = new CommandWrapperBuilder().attachLoanOriginator(loanId, originatorId).build();
        final CommandProcessingResult result = this.commandsSourceWritePlatformService.logCommandSource(commandRequest);
        return buildMappingResponse(result);
    }

    @POST
    @Path("external-id/{loanExternalId}/originators/{originatorId}")
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    @Operation(summary = "Attach originator to loan by loan external ID and originator ID")
    @ApiResponse(responseCode = "200", description = "OK", content = @Content(schema = @Schema(implementation = LoanOriginatorMappingResponse.class)))
    @ApiResponse(responseCode = "403", description = "Loan not in correct status, originator not ACTIVE, duplicate mapping")
    @ApiResponse(responseCode = "404", description = "Loan or originator not found")
    public LoanOriginatorMappingResponse attachOriginatorToLoanByLoanExternalId(@PathParam("loanExternalId") @Parameter(description = "loanExternalId") final String loanExternalId, @PathParam("originatorId") @Parameter(description = "originatorId") final Long originatorId) {
        final Long loanId = this.loanReadPlatformService.getLoanIdByLoanExternalId(loanExternalId);
        final CommandWrapper commandRequest = new CommandWrapperBuilder().attachLoanOriginator(loanId, originatorId).build();
        final CommandProcessingResult result = this.commandsSourceWritePlatformService.logCommandSource(commandRequest);
        return buildMappingResponse(result);
    }

    @POST
    @Path("external-id/{loanExternalId}/originators/external-id/{originatorExternalId}")
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    @Operation(summary = "Attach originator to loan by external IDs")
    @ApiResponse(responseCode = "200", description = "OK", content = @Content(schema = @Schema(implementation = LoanOriginatorMappingResponse.class)))
    @ApiResponse(responseCode = "403", description = "Loan not in correct status, originator not ACTIVE, duplicate mapping")
    @ApiResponse(responseCode = "404", description = "Loan or originator not found")
    public LoanOriginatorMappingResponse attachOriginatorToLoanByExternalIds(@PathParam("loanExternalId") @Parameter(description = "loanExternalId") final String loanExternalId, @PathParam("originatorExternalId") @Parameter(description = "originatorExternalId") final String originatorExternalId) {
        final Long loanId = this.loanReadPlatformService.getLoanIdByLoanExternalId(loanExternalId);
        final Long originatorId = this.loanOriginatorReadPlatformService.resolveIdByExternalId(originatorExternalId);
        final CommandWrapper commandRequest = new CommandWrapperBuilder().attachLoanOriginator(loanId, originatorId).build();
        final CommandProcessingResult result = this.commandsSourceWritePlatformService.logCommandSource(commandRequest);
        return buildMappingResponse(result);
    }

    @DELETE
    @Path("{loanId}/originators/{originatorId}")
    @Produces({MediaType.APPLICATION_JSON})
    @Operation(summary = "Detach originator from loan by IDs", description = "Detaches an originator from a loan. Loan must be in \'Submitted and Pending Approval\' status. Requires DETACH_LOAN_ORIGINATOR permission.")
    @ApiResponse(responseCode = "200", description = "OK - Originator detached", content = @Content(schema = @Schema(implementation = LoanOriginatorMappingResponse.class)))
    @ApiResponse(responseCode = "403", description = "Loan not in correct status or insufficient permissions")
    @ApiResponse(responseCode = "404", description = "Loan, originator, or mapping not found")
    public LoanOriginatorMappingResponse detachOriginatorFromLoan(@PathParam("loanId") @Parameter(description = "loanId") final Long loanId, @PathParam("originatorId") @Parameter(description = "originatorId") final Long originatorId) {
        final CommandWrapper commandRequest = new CommandWrapperBuilder().detachLoanOriginator(loanId, originatorId).build();
        final CommandProcessingResult result = this.commandsSourceWritePlatformService.logCommandSource(commandRequest);
        return buildMappingResponse(result);
    }

    @DELETE
    @Path("{loanId}/originators/external-id/{originatorExternalId}")
    @Produces({MediaType.APPLICATION_JSON})
    @Operation(summary = "Detach originator from loan by loan ID and originator external ID")
    @ApiResponse(responseCode = "200", description = "OK", content = @Content(schema = @Schema(implementation = LoanOriginatorMappingResponse.class)))
    @ApiResponse(responseCode = "403", description = "Loan not in correct status")
    @ApiResponse(responseCode = "404", description = "Loan, originator, or mapping not found")
    public LoanOriginatorMappingResponse detachOriginatorFromLoanByOriginatorExternalId(@PathParam("loanId") @Parameter(description = "loanId") final Long loanId, @PathParam("originatorExternalId") @Parameter(description = "originatorExternalId") final String originatorExternalId) {
        final Long originatorId = this.loanOriginatorReadPlatformService.resolveIdByExternalId(originatorExternalId);
        final CommandWrapper commandRequest = new CommandWrapperBuilder().detachLoanOriginator(loanId, originatorId).build();
        final CommandProcessingResult result = this.commandsSourceWritePlatformService.logCommandSource(commandRequest);
        return buildMappingResponse(result);
    }

    @DELETE
    @Path("external-id/{loanExternalId}/originators/{originatorId}")
    @Produces({MediaType.APPLICATION_JSON})
    @Operation(summary = "Detach originator from loan by loan external ID and originator ID")
    @ApiResponse(responseCode = "200", description = "OK", content = @Content(schema = @Schema(implementation = LoanOriginatorMappingResponse.class)))
    @ApiResponse(responseCode = "403", description = "Loan not in correct status")
    @ApiResponse(responseCode = "404", description = "Loan, originator, or mapping not found")
    public LoanOriginatorMappingResponse detachOriginatorFromLoanByLoanExternalId(@PathParam("loanExternalId") @Parameter(description = "loanExternalId") final String loanExternalId, @PathParam("originatorId") @Parameter(description = "originatorId") final Long originatorId) {
        final Long loanId = this.loanReadPlatformService.getLoanIdByLoanExternalId(loanExternalId);
        final CommandWrapper commandRequest = new CommandWrapperBuilder().detachLoanOriginator(loanId, originatorId).build();
        final CommandProcessingResult result = this.commandsSourceWritePlatformService.logCommandSource(commandRequest);
        return buildMappingResponse(result);
    }

    @DELETE
    @Path("external-id/{loanExternalId}/originators/external-id/{originatorExternalId}")
    @Produces({MediaType.APPLICATION_JSON})
    @Operation(summary = "Detach originator from loan by external IDs")
    @ApiResponse(responseCode = "200", description = "OK", content = @Content(schema = @Schema(implementation = LoanOriginatorMappingResponse.class)))
    @ApiResponse(responseCode = "403", description = "Loan not in correct status")
    @ApiResponse(responseCode = "404", description = "Loan, originator, or mapping not found")
    public LoanOriginatorMappingResponse detachOriginatorFromLoanByExternalIds(@PathParam("loanExternalId") @Parameter(description = "loanExternalId") final String loanExternalId, @PathParam("originatorExternalId") @Parameter(description = "originatorExternalId") final String originatorExternalId) {
        final Long loanId = this.loanReadPlatformService.getLoanIdByLoanExternalId(loanExternalId);
        final Long originatorId = this.loanOriginatorReadPlatformService.resolveIdByExternalId(originatorExternalId);
        final CommandWrapper commandRequest = new CommandWrapperBuilder().detachLoanOriginator(loanId, originatorId).build();
        final CommandProcessingResult result = this.commandsSourceWritePlatformService.logCommandSource(commandRequest);
        return buildMappingResponse(result);
    }

    private LoanOriginatorMappingResponse buildMappingResponse(final CommandProcessingResult result) {
        return LoanOriginatorMappingResponse.of(result.getResourceId(), result.getResourceExternalId() != null ? result.getResourceExternalId().getValue() : null, result.getSubResourceId(), result.getSubResourceExternalId() != null ? result.getSubResourceExternalId().getValue() : null);
    }

    @java.lang.SuppressWarnings("all")
        public LoanOriginatorsApiResource(final PlatformSecurityContext context, final LoanExistencePort loanExistencePort, final LoanReadPlatformServiceCommon loanReadPlatformService, final LoanOriginatorReadPlatformService loanOriginatorReadPlatformService, final PortfolioCommandSourceWritePlatformService commandsSourceWritePlatformService) {
        this.context = context;
        this.loanExistencePort = loanExistencePort;
        this.loanReadPlatformService = loanReadPlatformService;
        this.loanOriginatorReadPlatformService = loanOriginatorReadPlatformService;
        this.commandsSourceWritePlatformService = commandsSourceWritePlatformService;
    }
}
