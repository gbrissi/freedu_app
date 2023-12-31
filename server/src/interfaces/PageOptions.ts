import { DateRange } from "./DateRange";

export interface PageOptions {
  limit: number;
  page: number;
  tags?: string[];
  search?: string;
  dateRange?: DateRange;
}
