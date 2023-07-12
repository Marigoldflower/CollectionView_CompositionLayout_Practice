# CollectionView_CompositionLayout_Practice
<br>

### CollectionViewLayout의 종류

------------

CollectionView에는 두 가지 종류가 있다. 

#### 1. UICollectionViewFlowLayout

이 CollectionViewLayout은 셀을 현재 행에서 채워나가되, 화면의 공간이 부족해지면 새로운 행을 생성해서 셀들을 추가하는 방식이다. 


<img width="650" alt="스크린샷 2023-07-05 오후 5 54 50" src="https://github.com/Marigoldflower/CollectionView_CompositionLayout_Practice/assets/100112897/7a9b5f4a-8c47-48f8-bbaf-bb9903addb2d"> 

<br>

위의 그림처럼 스크롤의 방향에 따라 최대한 많은 셀들을 배치한 후, 화면에 다 채우지 못하면 다음 행으로 넘어가 셀들을 추가한다. 





#### 2. UICollectionViewCompositionalLayout



### TableView 사용의 단점  

------------

하지만 셀을 "재사용"하는 것은 TableView의 단점이기도 하다.  
우선 사용했던 셀을 다음 줄에서도, 그 다음 줄에서도, 10번째 줄에서도 계속 똑같이 사용하기 때문에  
각각의 셀의 구성이나 형태를 다르게 만들고자 할 때에는 TableView를 사용해서는 안 된다.

그림을 통해 자세히 알아보자.  

<img width="373" alt="스크린샷 2023-07-05 오후 5 54 50" src="https://github.com/Marigoldflower/ScrollView_TableView_Difference_Practice/assets/100112897/30ec76e7-1fc2-4afc-b79d-dcde7cd9a108">      
  
이미지, 두꺼운 폰트, 작은 글씨체의 셀이 계속 반복되는 것을 확인할 수 있다.  
TableView는 사용했던 셀을 다시 재사용하기 때문에 셀의 형태와 구성은 동일하다.  

반면에 다음과 같은 그림을 보자.

<img width="373" alt="스크린샷 2023-07-05 오후 7 17 00" src="https://github.com/Marigoldflower/ScrollView_TableView_Difference_Practice/assets/100112897/63609605-030b-4092-8340-ed3a3e831ec9">



위의 날씨 앱을 보면 각각의 구성요소가 모두 형태가 다른 것을 확인할 수 있다.  
첫 번째 영역은 날씨 Label만 존재하고, 세 번째 영역은 여러 날씨 데이터를 가로로 스크롤하여 확인할 수 있게끔 되어있으며  
네 번째 영역은 여러 날씨 데이터를 세로로 스크롤하여 확인할 수 있다.  
따라서 위와 같은 날씨 앱은 셀을 재활용하는 방식을 채택한 것이 아닌 각각의 객체들이 서로 다른 형태를 띄도록 만들어준 것이다.  
이 때 사용되는 방법이 바로 ScrollView와 StackView의 조합을 이용하는 것이다. 



### ScrollView와 StackView의 조합

------------


ScrollView와 StackView를 조합하여 TableView와 같이 세로로 스크롤하게 만들되,  
셀을 재활용하여 반복되는 셀을 사용하는 것이 아닌 각 객체의 구성요소가 서로 다르게끔 만들어줄 수 있다.  
방법은 다음과 같다.  

1. 먼저 스택 뷰에 올릴 뷰들을 생성한다.

<img width="639" alt="스크린샷 2023-07-05 오후 6 47 20" src="https://github.com/Marigoldflower/ScrollView_TableView_Difference_Practice/assets/100112897/f0fdcc6f-1093-456d-88c7-e29be14bf32b">  

2. 스택 뷰를 올린다.
   
<img width="639" alt="스크린샷 2023-07-05 오후 6 48 53" src="https://github.com/Marigoldflower/ScrollView_TableView_Difference_Practice/assets/100112897/5b9bb79f-f838-40cf-828c-b940c614eb29">  

3. 스크롤 뷰 생성

<img width="639" alt="스크린샷 2023-07-05 오후 6 48 53" src="https://github.com/Marigoldflower/ScrollView_TableView_Difference_Practice/assets/100112897/3a92661b-a047-4bfb-ba2e-996efa8deb73">

4. 제약 걸기.  

<img width="639" alt="스크린샷 2023-07-05 오후 6 48 53" src="https://github.com/Marigoldflower/ScrollView_TableView_Difference_Practice/assets/100112897/94c6882c-e4f2-40e8-b482-c2bb84c75f35">  

5. 그 후 아까 만들어 놓았던 UIView들을 스택 뷰에 차례대로 채워 넣으면 된다.

<img width="639" alt="스크린샷 2023-07-05 오후 6 56 42" src="https://github.com/Marigoldflower/ScrollView_TableView_Difference_Practice/assets/100112897/8015f73d-600a-4e5b-86c1-cfd2d305f67b">


## 결과물 
------------
<img src="https://github.com/Marigoldflower/ScrollView_TableView_Difference_Practice/assets/100112897/959641c2-a59c-4b62-ba77-748aa99358ad" width="400" height="800"/>      


정리하자면 **재사용셀을 사용해야 하거나** **받아야할 데이터가 너무 많을 때**엔 **TableView를 사용**하고  
**재사용셀을 사용하지 않고 서로 다른 여러 객체들을 띄워야 할 때**에는 **ScrollView + StackView 조합을 사용**하면 된다. 


------------

## 출처 

- [https://soojin.ro/blog/uitableview-hype](https://soojin.ro/blog/uitableview-hype)



