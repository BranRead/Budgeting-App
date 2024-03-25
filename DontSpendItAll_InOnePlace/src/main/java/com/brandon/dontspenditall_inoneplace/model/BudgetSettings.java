package com.brandon.dontspenditall_inoneplace.model;

public class BudgetSettings {
    private int id;
    private int needs;
    private int wants;
    private int savings;

    public BudgetSettings() {
    }

    public BudgetSettings(int id, int needs, int wants, int savings) {
        this.id = id;
        this.needs = needs;
        this.wants = wants;
        this.savings = savings;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNeeds() {
        return needs;
    }

    public void setNeeds(int needs) {
        this.needs = needs;
    }

    public int getWants() {
        return wants;
    }

    public void setWants(int wants) {
        this.wants = wants;
    }

    public int getSavings() {
        return savings;
    }

    public void setSavings(int savings) {
        this.savings = savings;
    }
}