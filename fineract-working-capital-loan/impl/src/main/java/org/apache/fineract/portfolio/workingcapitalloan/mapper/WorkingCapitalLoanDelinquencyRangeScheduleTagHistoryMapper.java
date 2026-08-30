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

package org.apache.fineract.portfolio.workingcapitalloan.mapper;

import java.util.List;
import org.apache.fineract.infrastructure.core.config.MapstructMapperConfig;
import org.apache.fineract.portfolio.delinquency.data.DelinquencyRangeData;
import org.apache.fineract.portfolio.loanaccount.moduleapi.DelinquencyCatalogPort;
import org.apache.fineract.portfolio.workingcapitalloan.data.WorkingCapitalLoanDelinquencyTagHistoryData;
import org.apache.fineract.portfolio.workingcapitalloan.data.WorkingCapitalLoanRangeScheduleDelinquencyData;
import org.apache.fineract.portfolio.workingcapitalloan.domain.WorkingCapitalLoanDelinquencyRangeScheduleTagHistory;
import org.mapstruct.AfterMapping;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.springframework.beans.factory.annotation.Autowired;

@Mapper(config = MapstructMapperConfig.class)
public abstract class WorkingCapitalLoanDelinquencyRangeScheduleTagHistoryMapper {

    @Autowired
    protected DelinquencyCatalogPort delinquencyCatalogPort;

    @Mapping(target = "loanId", source = "source.loan.id")
    @Mapping(target = "delinquencyRange", ignore = true)
    @Mapping(target = "delinquentDays", ignore = true)
    @Mapping(target = "rangeId", source = "source.rangeSchedule.id")
    @Mapping(target = "periodNumber", source = "source.rangeSchedule.periodNumber")
    @Mapping(target = "delinquentAmount", source = "source.rangeSchedule.delinquentAmount")
    public abstract WorkingCapitalLoanDelinquencyTagHistoryData map(WorkingCapitalLoanDelinquencyRangeScheduleTagHistory source);

    public abstract List<WorkingCapitalLoanDelinquencyTagHistoryData> map(List<WorkingCapitalLoanDelinquencyRangeScheduleTagHistory> sources);

    @AfterMapping
    protected void calculateTotal(WorkingCapitalLoanDelinquencyRangeScheduleTagHistory source,
            @MappingTarget WorkingCapitalLoanDelinquencyTagHistoryData target) {
        final DelinquencyRangeData range = delinquencyCatalogPort.retrieveRange(source.getDelinquencyRangeId());
        target.setDelinquencyRange(range);
        final Integer minimumAgeDays = range != null && range.getMinimumAgeDays() != null ? range.getMinimumAgeDays() : 0;
        target.setDelinquentDays(source.getRangeSchedule().getDelinquentDays() - minimumAgeDays + 1);
    }

    @Mapping(target = "rangeId", source = "delinquencyRangeId")
    @Mapping(target = "classification", ignore = true)
    @Mapping(target = "minimumAgeDays", ignore = true)
    @Mapping(target = "maximumAgeDays", ignore = true)
    @Mapping(target = "delinquentAmount", source = "outstandingAmount")
    public abstract WorkingCapitalLoanRangeScheduleDelinquencyData mapForCollectionData(
            WorkingCapitalLoanDelinquencyRangeScheduleTagHistory source);

    @AfterMapping
    protected void fillRangeFields(WorkingCapitalLoanDelinquencyRangeScheduleTagHistory source,
            @MappingTarget WorkingCapitalLoanRangeScheduleDelinquencyData target) {
        final DelinquencyRangeData range = delinquencyCatalogPort.retrieveRange(source.getDelinquencyRangeId());
        if (range != null) {
            target.setClassification(range.getClassification());
            target.setMinimumAgeDays(range.getMinimumAgeDays());
            target.setMaximumAgeDays(range.getMaximumAgeDays());
        }
    }

}
