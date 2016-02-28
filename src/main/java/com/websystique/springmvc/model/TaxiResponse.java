package com.websystique.springmvc.model;

public class TaxiResponse {

	Integer count;
	Boolean next;
	Boolean previous;
	Object results;

	public TaxiResponse() {

	}

	public TaxiResponse(Integer count, Boolean next, Boolean previous, Object results) {
		this.count = count;
		this.next = next;
		this.previous = previous;
		this.results = results;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public Boolean getNext() {
		return next;
	}

	public void setNext(Boolean next) {
		this.next = next;
	}

	public Boolean getPrevious() {
		return previous;
	}

	public void setPrevious(Boolean previous) {
		this.previous = previous;
	}

	public Object getResults() {
		return results;
	}

	public void setResults(Object results) {
		this.results = results;
	}

}
