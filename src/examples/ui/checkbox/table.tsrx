import { useState } from "octane"

import { Checkbox } from "@/components/ui/checkbox.tsrx"
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table.tsrx"

const tableData = [
  {
    id: "1",
    name: "Sarah Chen",
    email: "sarah.chen@example.com",
    role: "Admin",
  },
  {
    id: "2",
    name: "Marcus Rodriguez",
    email: "marcus.rodriguez@example.com",
    role: "User",
  },
  {
    id: "3",
    name: "Priya Patel",
    email: "priya.patel@example.com",
    role: "User",
  },
  {
    id: "4",
    name: "David Kim",
    email: "david.kim@example.com",
    role: "Editor",
  },
]

export default function CheckboxTableDemo() @{
  const [selectedRows, setSelectedRows] = useState<Set<string>>(new Set(["1"]))

  const selectAll = selectedRows.size === tableData.length

  const handleSelectAll = (checked: boolean) => {
    if (checked) {
      setSelectedRows(new Set(tableData.map((row) => row.id)))
    } else {
      setSelectedRows(new Set())
    }
  }

  const handleSelectRow = (id: string, checked: boolean) => {
    const newSelected = new Set(selectedRows)
    if (checked) {
      newSelected.add(id)
    } else {
      newSelected.delete(id)
    }
    setSelectedRows(newSelected)
  }

  <Table>
    <TableHeader>
      <TableRow>
        <TableHead class="w-8">
          <Checkbox
            id="select-all-checkbox"
            name="select-all-checkbox"
            checked={selectAll}
            onCheckedChange={handleSelectAll}
          />
        </TableHead>
        <TableHead>Name</TableHead>
        <TableHead>Email</TableHead>
        <TableHead>Role</TableHead>
      </TableRow>
    </TableHeader>
    <TableBody>
      @for (const row of tableData; key row.id) {
        <TableRow
          data-state={selectedRows.has(row.id) ? "selected" : undefined}
        >
          <TableCell>
            <Checkbox
              id={`row-${row.id}-checkbox`}
              name={`row-${row.id}-checkbox`}
              checked={selectedRows.has(row.id)}
              onCheckedChange={(checked: boolean) =>
                handleSelectRow(row.id, checked === true)
              }
            />
          </TableCell>
          <TableCell class="font-heading">{row.name as string}</TableCell>
          <TableCell>{row.email as string}</TableCell>
          <TableCell>{row.role as string}</TableCell>
        </TableRow>
      }
    </TableBody>
  </Table>
}
