$(function () {    
    $('#operation_is_income').change(function () {
      var p = $('#operation_is_income').val();        
      $.ajaxSetup({ cache: false });
      $.get('<%= operation_select_categories_path(@operation) -%>', {is_income: p});        
    });
    $('#datetimepicker1').datetimepicker();
    $('#datetimepicker2').datetimepicker();
});