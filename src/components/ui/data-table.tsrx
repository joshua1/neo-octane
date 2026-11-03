import {
  columnFilteringFeature,
  columnVisibilityFeature,
  createColumnHelper,
  createFilteredRowModel,
  createPaginatedRowModel,
  createSortedRowModel,
  filterFn_includesString,
  rowPaginationFeature,
  rowSelectionFeature,
  rowSortingFeature,
  sortFn_alphanumeric,
  sortFn_text,
  tableFeatures,
  useTable,
  type ColumnFiltersState,
  type ColumnVisibilityState,
  type RowSelectionState,
  type SortingState,
} from "@octanejs/tanstack-table"
import { ArrowUpDown, ChevronDown, MoreHorizontal } from "@octanejs/lucide"

import { useState } from "octane"

import { Button } from "@/components/ui/button.tsrx"
import { Checkbox } from "@/components/ui/checkbox.tsrx"
import {
  DropdownMenu,
  DropdownMenuCheckboxItem,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu.tsrx"
import { Input } from "@/components/ui/input.tsrx"
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table.tsrx"

const data: Payment[] = [
  {
    id: "m5gr84i9",
    amount: 316,
    status: "success",
    email: "ken99@yahoo.com",
  },
  {
    id: "3u1reuv4",
    amount: 242,
    status: "success",
    email: "Abe45@gmail.com",
  },
  {
    id: "derv1ws0",
    amount: 837,
    status: "processing",
    email: "Monserrat44@gmail.com",
  },
  {
    id: "5kma53ae",
    amount: 874,
    status: "success",
    email: "Silas22@gmail.com",
  },
  {
    id: "bhqecj4p",
    amount: 721,
    status: "failed",
    email: "carmella@hotmail.com",
  },
]

export type Payment = {
  id: string
  amount: number
  status: "pending" | "processing" | "success" | "failed"
  email: string
}

// TanStack Table v9 is modular: only the features listed here are bundled.
const features = tableFeatures({
  columnFilteringFeature,
  columnVisibilityFeature,
  rowPaginationFeature,
  rowSelectionFeature,
  rowSortingFeature,
  filteredRowModel: createFilteredRowModel(),
  paginatedRowModel: createPaginatedRowModel(),
  sortedRowModel: createSortedRowModel(),
  filterFns: { includesString: filterFn_includesString },
  sortFns: { alphanumeric: sortFn_alphanumeric, text: sortFn_text },
})

const columnHelper = createColumnHelper<typeof features, Payment>()

export const columns = columnHelper.columns([
  columnHelper.display({
    id: "select",
    header: ({ table }) => (
      <Checkbox
        class="data-checked:bg-secondary-background data-indeterminate:bg-secondary-background"
        checked={table.getIsAllPageRowsSelected()}
        indeterminate={
          table.getIsSomePageRowsSelected() && !table.getIsAllPageRowsSelected()
        }
        onCheckedChange={(value) => table.toggleAllPageRowsSelected(!!value)}
        aria-label="Select all"
      />
    ),
    cell: ({ row }) => (
      <Checkbox
        class="data-checked:bg-secondary-background data-indeterminate:bg-secondary-background"
        checked={row.getIsSelected()}
        onCheckedChange={(value) => row.toggleSelected(!!value)}
        aria-label="Select row"
      />
    ),
    enableSorting: false,
    enableHiding: false,
  }),
  columnHelper.accessor("status", {
    header: "Status",
    cell: ({ row }) => (
      <div class="capitalize">{row.getValue("status") as string}</div>
    ),
  }),
  columnHelper.accessor("email", {
    header: ({ column }) => {
      return (
        <Button
          variant="noShadow"
          class="bg-secondary-background text-foreground"
          size="sm"
          onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
        >
          Email
          <ArrowUpDown />
        </Button>
      )
    },
    cell: ({ row }) => (
      <div class="lowercase">{row.getValue("email") as string}</div>
    ),
  }),
  columnHelper.accessor("amount", {
    header: () => <div class="text-right">Amount</div>,
    cell: ({ row }) => {
      const amount = parseFloat(row.getValue("amount"))

      // Format the amount as a dollar amount
      const formatted = new Intl.NumberFormat("en-US", {
        style: "currency",
        currency: "USD",
      }).format(amount)

      return <div class="text-right font-base">{formatted}</div>
    },
  }),
  columnHelper.display({
    id: "actions",
    enableHiding: false,
    cell: ({ row }) => {
      const payment = row.original

      return (
        <DropdownMenu>
          <DropdownMenuTrigger
            render={
              <Button
                variant="noShadow"
                class="size-8 bg-secondary-background p-0 text-foreground"
              />
            }
          >
            <span class="sr-only">Open menu</span>
            <MoreHorizontal />
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end">
            <DropdownMenuLabel>Actions</DropdownMenuLabel>
            <DropdownMenuItem
              onClick={() => navigator.clipboard.writeText(payment.id)}
            >
              Copy payment ID
            </DropdownMenuItem>
            <DropdownMenuSeparator />
            <DropdownMenuItem>View customer</DropdownMenuItem>
            <DropdownMenuItem>View payment details</DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      )
    },
  }),
])

export default function DataTableDemo() @{
  const [sorting, setSorting] = useState<SortingState>([])
  const [columnFilters, setColumnFilters] = useState<ColumnFiltersState>([])
  const [columnVisibility, setColumnVisibility] =
    useState<ColumnVisibilityState>({})
  const [rowSelection, setRowSelection] = useState<RowSelectionState>({})

  const table = useTable({
    features,
    data,
    columns,
    onSortingChange: setSorting,
    onColumnFiltersChange: setColumnFilters,
    onColumnVisibilityChange: setColumnVisibility,
    onRowSelectionChange: setRowSelection,
    state: {
      sorting,
      columnFilters,
      columnVisibility,
      rowSelection,
    },
  })

  const hideableColumns = table
    .getAllColumns()
    .filter((column) => column.getCanHide())
  const rows = table.getRowModel().rows

  <div class="w-full font-base text-foreground">
    <div class="flex items-center py-4">
      <Input
        placeholder="Filter emails..."
        value={(table.getColumn("email")?.getFilterValue() as string) ?? ""}
        onInput={(event: InputEvent) =>
          table
            .getColumn("email")
            ?.setFilterValue((event.currentTarget as HTMLInputElement).value)
        }
        class="max-w-sm"
      />
      <DropdownMenu>
        <DropdownMenuTrigger
          render={
            <Button
              variant="noShadow"
              class="ml-auto bg-secondary-background text-foreground"
            />
          }
        >
          Columns <ChevronDown />
        </DropdownMenuTrigger>
        <DropdownMenuContent align="end">
          @for (const column of hideableColumns; key column.id) {
            <DropdownMenuCheckboxItem
              class="capitalize"
              checked={column.getIsVisible()}
              onCheckedChange={(value: boolean) =>
                column.toggleVisibility(!!value)
              }
            >
              {column.id as string}
            </DropdownMenuCheckboxItem>
          }
        </DropdownMenuContent>
      </DropdownMenu>
    </div>
    <div>
      <Table>
        <TableHeader class="font-heading">
          @for (
            const headerGroup of table.getHeaderGroups();
            key headerGroup.id
          ) {
            <TableRow class="bg-background text-foreground">
              @for (const header of headerGroup.headers; key header.id) {
                <TableHead class="text-foreground">
                  @if (!header.isPlaceholder) {
                    <table.FlexRender header={header} />
                  }
                </TableHead>
              }
            </TableRow>
          }
        </TableHeader>
        <TableBody>
          @if (rows?.length) {
            @for (const row of rows; key row.id) {
              <TableRow
                class="bg-background text-foreground data-[state=selected]:bg-main data-[state=selected]:text-main-foreground"
                data-state={row.getIsSelected() && "selected"}
              >
                @for (const cell of row.getVisibleCells(); key cell.id) {
                  <TableCell class="px-4 py-2">
                    <table.FlexRender cell={cell} />
                  </TableCell>
                }
              </TableRow>
            }
          } @else {
            <TableRow>
              <TableCell colSpan={columns.length} class="h-24 text-center">
                No results.
              </TableCell>
            </TableRow>
          }
        </TableBody>
      </Table>
    </div>
    <div class="flex items-center justify-end space-x-2 py-4">
      <div class="text-foreground flex-1 text-sm">
        {String(table.getFilteredSelectedRowModel().rows.length) +
          " of " +
          String(table.getFilteredRowModel().rows.length) +
          " row(s) selected."}
      </div>
      <div class="space-x-2">
        <Button
          variant="noShadow"
          class="bg-secondary-background text-foreground"
          size="sm"
          onClick={() => table.previousPage()}
          disabled={!table.getCanPreviousPage()}
        >
          Previous
        </Button>
        <Button
          variant="noShadow"
          class="bg-secondary-background text-foreground"
          size="sm"
          onClick={() => table.nextPage()}
          disabled={!table.getCanNextPage()}
        >
          Next
        </Button>
      </div>
    </div>
  </div>
}
