<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  response.setContentType("text/html; charset=utf-8");
  response.setCharacterEncoding("utf-8");
  request.setCharacterEncoding("utf-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
// Graphiq is a working title 

html,
body {
  height: 100%;
  margin: 0; padding: 0;
}
body {
    background: #1b1e23;
    color: white;
    font-family: sans-serif;
}

p {
font-size: 0.75em;
  margin-bottom: 2em;
}

h1, h2 {
  font-size: 1.5rem;
  text-align: center;
}

* {
  box-sizing: border-box;
}

.row {
    margin-top: 2em;
}


.light {
    background: white;
  padding: 2em 0;
  margin-top: 2em;
  .row {
    margin: 0;
  }
}

.col {
    padding: 1em;
}

.fifty {
    width: 50%;
}

// Graphiq starts

.graphiq {
  width: 100%;
  position: relative;
  display: flex;
  
  &__graph-layout {
    flex: 1;
    overflow-x: hidden;
  }

  &__graph-values {
    font-size: 0.75em;
    padding-right: 5px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    padding-bottom: 1.25em;
    text-align: right;
    font-weight: bold;
  }

  &__line {
    fill: none;
    stroke-miterlimit: 10;
   // display: none;
  }

  &__graph-key {
    display: flex;
    justify-content: space-between;
    .key {
      font-size: 0.75em;
      text-align: center;
      display: block;
  
    }
  }

  &__y-division {
    fill: none;
    stroke-miterlimit: 10;
    z-index: -1;
    transition: 0.25s ease-in;
  }
  &__graph-dot {
    transition: stroke-width ease-in-out 0.2s;
    transform-origin: 50% 50%;
   // display: none;
  }

  &__value-dialog {
    display: block;
    position: absolute;
    background: transparent;
    font-size: 0.75em;
    line-height: 0;
    padding: 0.66em 0.33em;
    font-weight: bold;
    animation: float 0.3s ease-out forwards;
  }

}
@keyframes float {
  0% {
    opacity: 0;
    transform: translateY(20px);
  }
  100% {
    opacity: 1;
    transform: translateY();
  }
}


</style>
</head>

<jsp:include page="common.jsp"></jsp:include>

<body>
  <!--헤더-->
  <jsp:include page="header.jsp"></jsp:include>
  <div class="wrap0">
    <section>
    <div class="container">
  <div class="row">
    <div class="col">
      <h1>Responsive, customisable vector line graph generator</h1>
<h2>(5 examples)</h2>
    </div>
  </div>
    <div class="row">
        <div class="col s-12 m-6">
            <p>How many songs I listened to</p>
            <div class="graph-songs"></div>
        </div>
        <div class="col s-12 m-6">
                <p>How many coffees consumed</p>
            <div class="graph-coffees"></div>
        </div>
    </div>
      <div class="row">
        <div class="col s-12 m-4">
                <p>Times my cat shouted at me</p>
            <div class="graph-cats"></div>
    </div>
        <div class="col s-12 m-8">
                <p>Hours on Reddit</p>
            <div class="graph-hours"></div>
  </div>
  </div>
  </div>


  <div class="light">
<div class="container-fluid">
    <div class="row">
        <div class="col">
            <div class="graph-feature"></div>
        </div>
    </div>
  </div>
</div>

    
    
    
    </section>
  </div>
  <!--풋터-->
  <jsp:include page="footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
//For example on how to intiate graphs, or if you want to mess around with the data / style of these graphs, check the bottom of this panel.

(function ($) {

    $.fn.graphiq = function (options) {

        // Default options
        var settings = $.extend({
            data: {},
            colorLine: "#d3a2ef",
            colorDot: "#c3ecf7",
            colorXGrid: "#7f7f7f",
            colorYGrid: "#7f7f7f",
            colorLabels: "#FFFFFF",
            colorUnits: "#FFFFFF",
            colorRange: "#FFFFFF",
            colorFill: "#533c68",
            colorDotStroke: "#FFFFFF",
            dotStrokeWeight: 0,
            fillOpacity: 0.25,
            rangeOpacity: 0.5,
            dotRadius: 3,
            lineWeight: 2,
            yLines: true,
            dots: true,
            xLines: true,
            xLineCount: 5,
            fill: true,
            height: 100,
            fluidParent: null
        }, options);

        var values = [];
        var entryDivision;
        var dataRange = settings.height + settings.dotRadius;
        var parent = this;
        var maxVal;
        var scaleFactor = settings.height / 100;
        var pathPoints = "";
        for (var key in settings.data) {
            values.push(settings.data[key]);
        }

        parent.append(
            '<div class="graphiq__graph-values"></div><div class="graphiq__graph-layout"><svg class="graphiq__graph" viewBox="0 0 960 '+ (settings.height + 10) +'" shape-rendering="geometricPrecision"><path fill="'+ settings.colorFill +'" style="opacity: '+ settings.fillOpacity +'" class="graphiq__fill-path" d="" stroke-width="0" stroke="#000" fill="cyan"/></svg><div class="graphiq__graph-key"></div></div>'
        );
            if (settings.fluidParent) {
                this.closest(".col").css("overflow", "auto");
            }
        parent.addClass('graphiq');

        var graph = this.find(".graphiq__graph");

        // Get data from table
        for (var key in settings.data) {
            this.find(".graphiq__graph-key").append('<div class="key" style="color: ' + settings.colorLabels + '">' + key + "</div>");
        }

        maxVal = Math.max.apply(Math, values);


        this.find('.graphiq__graph-values').append('<span style="color: ' + settings.colorRange + '; opacity: ' + settings.rangeOpacity + '">' + maxVal + '</span><span style="color: ' + settings.colorRange + '; opacity: ' + settings.rangeOpacity + '" >0</span>');



        // Set even spacing in the graph depending on amount of data

        var width = parent.find(".graphiq__graph-layout").width();
        
        if (settings.xLines) {
            unitLines(width, maxVal);
        }

        layoutGraph(width, true);

        $(window).on("resize", function () {
            pathPoints = "";
            width = parent.find(".graphiq__graph-layout").width();
            layoutGraph(width, false);
        });

       // buildFillPath();
   
        function percentageOf(max, current) {
            return (current / max * 100) * scaleFactor;
        }

        function layoutGraph(width, initial) {
            graph.attr({
                viewBox: "0 0 " + width + " " + (settings.height + 10),
                width: width
            });
            entryDivision = width / (values.length - 1);
            getCoordinates(initial, entryDivision);
        }

        function getCoordinates(initial, entryDivision) {


            for (i = 0; i < values.length; i++) {
           
                var offset;
       
                if (i == 0) {
                    offset = (settings.dotRadius + (settings.dotStrokeWeight)) + 1;
                } 
            
                 else if (i == values.length - 1) {
                    offset = ((settings.dotRadius + (settings.dotStrokeWeight )) * -1) - 1;
                } else {
                    offset = 0;
                }
           
                var lineOffset = i == values.length - 2 ? (settings.dotRadius + (settings.dotStrokeWeight)) / 2 : 0;

                let nextI = i + 1;
                let xAxis = (entryDivision * i) + offset;
                let xAxis2 = entryDivision * nextI;
                
                console.log(offset);
           

                let yAxis = dataRange - percentageOf(maxVal, values[i]);

                let yAxis2 = dataRange - percentageOf(maxVal, values[nextI]);

                if (i == values.length - 1) {
                    yAxis2 = yAxis;
                    xAxis2 = xAxis;
                }

              pathPoints += " L " + xAxis + " " + yAxis;
             

                if (i == values.length - 1 && settings.fill) {
                    buildFillPath(pathPoints);
                }

                if (initial) {

                    if (settings.yLines) {

                    $(document.createElementNS("http://www.w3.org/2000/svg", "line"))
                        .attr({
                            class: "graphiq__y-division",
                            x1: xAxis,
                            y1: yAxis,
                            x2: xAxis,
                            y2: settings.height + 5,
                            stroke: settings.colorYGrid,
                            "stroke-dasharray": "5 6",
                            "stroke-width": 1
                        })
                        .prependTo(graph);

                    }

                    // Draw the line
                    

                    $(document.createElementNS("http://www.w3.org/2000/svg", "line"))
                        .attr({
                            class: "graphiq__line",
                            x1: xAxis ,
                            y1: yAxis,
                            x2: xAxis2 - lineOffset,
                            y2: yAxis2 + (settings.dotStrokeWeight / 2),
                            stroke: settings.colorLine,
                            "stroke-width": settings.lineWeight,
                            "vector-effect": "non-scaling-stroke"
                        }).appendTo(graph);

                    // Draw the circle

               
                    $(document.createElementNS("http://www.w3.org/2000/svg", "circle"))
                        .attr({
                            class: "graphiq__graph-dot",
                            cx: xAxis,
                            cy: yAxis + (settings.dotStrokeWeight / 2),
                            r: settings.dots ? settings.dotRadius : 0,
                            fill: settings.colorDot,
                            stroke: settings.colorDotStroke,
                            "stroke-width": settings.dotStrokeWeight,
                            "data-value": values[i],
                            "vector-effect": "non-scaling-stroke"
                        })
                        .appendTo(graph);
                    

                    // Resize instead of draw, used in resize
                } else {

                    parent.find(".graphiq__graph-dot")
                        .eq(i)
                        .attr({
                            cx: xAxis,
                        });
                    parent.find(".graphiq__line")
                        .eq(i)
                        .attr({
                            x1: xAxis,
                            x2: xAxis2 - lineOffset,
                        });
                    parent.find(".graphiq__y-division")
                        .eq(values.length - i - 1)
                        .attr({
                            x1: xAxis,
                            x2: xAxis
                        });
                    parent.find(".graphiq__x-line").each(function () {
                        $(this).attr({
                            x2: width
                        });
                    });
                }
            }
        }

        function buildFillPath(pathPoints) {
          
          parent.find('.graphiq__fill-path').attr("d", "M  " + (4 + settings.dotStrokeWeight) + " " + (settings.height + 5 + settings.dotStrokeWeight) + pathPoints +  " L " + (width - settings.dotRadius - settings.dotStrokeWeight) + " " + (settings.height + 5 + settings.dotStrokeWeight))
        }

        function unitLines(width, maxVal) {
            // Draw the max line

            var iteration = 100 / (settings.xLineCount - 1);


                for (i=0; i < settings.xLineCount; i++) {

                        $(document.createElementNS("http://www.w3.org/2000/svg", "line"))
                        .attr({
                            class: "graphiq__x-line",
                            y1: iteration * i + (settings.dotRadius + settings.dotStrokeWeight),
                            x2: width,
                            y2: iteration * i +  (settings.dotRadius + settings.dotStrokeWeight),
                            stroke: settings.colorXGrid,
                            // "stroke-dasharray": "5 6",
                            "stroke-width": 1
                        })
                        .prependTo(graph);

                }
 
        }

        parent.hover(function () {
        
            $(this).find('.graphiq__graph-dot').each(function (index) {
                $('body').append('<span style="color: '+ settings.colorUnits +'" class="graphiq__value-dialog value-' + index + '">' + $(this).attr("data-value") + '</span>');
                $('.value-' + index).css({
                    top: $(this).position().top - 20,
                    left: $(this).position().left - ($('.value-' + index).outerWidth() / 2) + 3
                })
            })
        }, function () {
            $('.graphiq__value-dialog').remove();
        })

    };

}(jQuery));

// Initiate graphs

  var songs = {
  "Mon" : 80,
  "Tues": 40,
  "Wed" : 60,
  "Thu" : 80,
  "Fri": 40,
  "Sat" : 60,

   };

var coffees = {
  "Mon" : 3,
  "Tues": 2,
  "Wed" : 3,
  "Thu" : 2,
  "Fri" : 1.5,
  "Sat" : 1,
  "Sun" : 2
   };

var cats = {
    "10/12" : 1,
    "10/13" : 4,
    "10/14" : 15,
    "10/15" : 27,
    "10/16" : 48,
    "10/17" : 34,
    "10/18" : 12,
}

var reddit = {
    "10/12" : 3.5,
    "10/13" : 2.3,
    "10/14" : 2,
    "10/15" : 1.5,
    "10/16" : 3,
    "10/17" : 4,
    "10/18" : 7,
}

var feature = {
    "1am" : 20,
    "2am" : 15,
    "3am" : 26,
    "4am" : 23,
    "5am" : 36,
    "6am" : 48,
    "7am" : 89,
    "8am" : 109,
    "9am" : 140,
    "10am" : 162,
    "11am" : 173,
    "12pm" : 201
}


$('.graph-songs').graphiq({
    data: songs,
    fluidParent: ".col",
    height: 100,
    xLineCount: 5,
    dotRadius: 4,
    yLines: true,
    xLines: true,
    dots: true,
    fillOpacity: 0.5,
    fill: true,
    colorUnits: "#c3ecf7"
  });

  $('.graph-coffees').graphiq({
    data: coffees,
    fluidParent: ".col",
    height: 100,
    xLineCount: 3,
    dotRadius: 5,
    yLines: true,
    xLines: true,
    dots: true,
    colorLine: "#d3d1b1",
    colorDot: "#726d60",
    colorXGrid: "#634e1b",
    colorUnits: "#d3d1b1",
    colorFill: "#3a2f23",
    dotStrokeWeight: 3,

  });

    $('.graph-cats').graphiq({
    data: cats,
    fluidParent: ".col",
    yLines: false,
    xLines: false,
    dots: false,
    colorLine: "#efede5",
    colorLabels: "#efede5",
    fill: false
  });

      $('.graph-hours').graphiq({
    data: reddit,
    fluidParent: ".col",
    height: 100,
    xLineCount: 2,
    dotRadius: 5,
    yLines: false,
    xLines: true,
    dots: true,
    colorLine: "#2F9C95",
    colorDot: "#A3F7B5",
    colorXGrid: "#788476",
    colorUnits: "#A3F7B5",
    colorFill: "#2a4151"
  });

$('.graph-feature').graphiq({
    data: feature,
    fluidParent: ".col",
    colorFill: "#0B4F6C",
  colorRange: "#0B4F6C",
  colorLabels: "#0B4F6C",
    colorLine: "#145C9E",
    fillOpacity: 0.6,
    yLines: false,
    xLineCount: 2,
    dotRadius: 2,
    colorUnits: "#8ecde2",
    lineWeight: 0,
    dots: false,
    colorDot: "#ffc744",
    colorYGrid: "#041e28",
    colorXGrid: "#eeeeee",
    height: 180
})

</script>

</html>