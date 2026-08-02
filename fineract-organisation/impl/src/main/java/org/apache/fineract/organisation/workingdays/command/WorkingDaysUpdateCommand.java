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
package org.apache.fineract.organisation.workingdays.command;

import org.apache.fineract.command.core.Command;
import org.apache.fineract.organisation.workingdays.data.WorkingDaysUpdateRequest;

public class WorkingDaysUpdateCommand extends Command<WorkingDaysUpdateRequest> {
	@java.lang.SuppressWarnings("all")
		public WorkingDaysUpdateCommand() {
	}

	@java.lang.Override
	@java.lang.SuppressWarnings("all")
		public java.lang.String toString() {
		return "WorkingDaysUpdateCommand()";
	}

	@java.lang.Override
	@java.lang.SuppressWarnings("all")
		public boolean equals(final java.lang.Object o) {
		if (o == this) return true;
		if (!(o instanceof WorkingDaysUpdateCommand)) return false;
		final WorkingDaysUpdateCommand other = (WorkingDaysUpdateCommand) o;
		if (!other.canEqual((java.lang.Object) this)) return false;
		if (!super.equals(o)) return false;
		return true;
	}

	@java.lang.SuppressWarnings("all")
		protected boolean canEqual(final java.lang.Object other) {
		return other instanceof WorkingDaysUpdateCommand;
	}

	@java.lang.Override
	@java.lang.SuppressWarnings("all")
		public int hashCode() {
		final int result = super.hashCode();
		return result;
	}
}
