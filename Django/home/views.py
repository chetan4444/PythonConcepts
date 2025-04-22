from django.shortcuts import render, HttpResponse

# Create your views here.

def index(request):
    #To Send variable
    context = {
        "variable1": "This is variable.",
        "variable2": "This is 2nd variable"
    }
    return render(request, 'index.html', context)
    #return HttpResponse("This is home page.")

def about(request):
    return HttpResponse("This is about page.")

def contact(request):
    return HttpResponse("This is contact page.")

def services(request):
    return HttpResponse("This is services page.")