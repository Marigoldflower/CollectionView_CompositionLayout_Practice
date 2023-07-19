# CollectionView_CompositionLayout_Practice
<br>

## CollectionViewLayout의 종류

------------

CollectionView에는 두 가지 종류가 있다. 

### 1. UICollectionViewFlowLayout

이 CollectionViewLayout은 셀을 현재 행에서 채워나가되, 화면의 공간이 부족해지면 새로운 행을 생성해서 셀들을 추가하는 방식이다. 


<img width="650" alt="스크린샷 2023-07-05 오후 5 54 50" src="https://github.com/Marigoldflower/CollectionView_CompositionLayout_Practice/assets/100112897/7a9b5f4a-8c47-48f8-bbaf-bb9903addb2d"> 

<br>

위의 그림처럼 스크롤의 방향에 따라 최대한 많은 셀들을 배치한 후, 화면에 다 채우지 못하면 다음 행으로 넘어가 셀들을 추가한다. 

또한 CollectionViewFlowLayout은 두 가지 방법으로 컬렉션 뷰 셀의 width와 height를 정해줄 수 있다.

1) itemSize

<img width="650" alt="스크린샷 2023-07-12 오후 9 02 33" src="https://github.com/Marigoldflower/CollectionView_CompositionLayout_Practice/assets/100112897/4d211056-ebf3-4b6d-b677-32f9361441fe">


2) UICollectionViewDelegateFlowLayout를 준수하여 메소드를 구현

<img width="650" alt="스크린샷 2023-07-12 오후 9 07 19" src="https://github.com/Marigoldflower/CollectionView_CompositionLayout_Practice/assets/100112897/8653bee6-76e4-4930-ae13-4c029a2727dc">


CollectionViewFlowLayout은 모든 셀에 대하여 width값과 height값을 정해주는 것으로, 
<br>
어떤 특정 셀의 width값과 height값만 다르게 지정하는 것은 불가능하다.
<br>
(물론 width: 10 * Int.random(in: 5...10) , height: 10 * Int.random(in: 5...10) 이런 방식으로 각 셀의 크기를 다르게 해 줄 수는 있긴 하다.)


가장 전통적인 방식의 레이아웃으로 애플은 웬만하면 이 레이아웃 사용하기를 권장하고 있다.

<br>

### 📌 CollectionViewFlowLayout의 문제점 

현대적인 앱의 레이아웃은 정말 복잡하다. 각 레이아웃의 크기나 모양이 전부 다 다르며 일정하지 않다. 
<br>
앱 스토어 레이아웃과 같은 레이아웃을 보면 레이아웃의 구성이 전부 다 다른 것을 확인할 수 있다. 

<img width="650" alt="스크린샷 2023-07-12 오후 9 07 19" src="https://github.com/Marigoldflower/CollectionView_CompositionLayout_Practice/assets/100112897/d2fe9407-a264-4063-835e-dbcf14b6b55b">
<br>


<br>

CompositionalFlowLayout은 이와 같은 레이아웃을 구성하기에 좋은 선택지는 아니다. 


<br>

### 2. UICollectionViewCompositionalLayout

CollectionViewFlowLayout이 갖는 문제점을 해결하고자, iOS 13때 개발된 레이아웃이 바로 CollectionViewCompositionalLayout이다.
<br>
위에서 앱 스토어 에시를 다뤘듯이, 이 레이아웃은 복잡한 섹션을 구성하기에 적합한 레이아웃 방식이다. 


![CompositionalLayoutExample](https://github.com/Marigoldflower/CollectionView_CompositionLayout_Practice/assets/100112897/5eebf48e-8822-43db-b209-39414180084f)


<br>

위와 같은 복잡한 레이아웃을 구성하기 위해서 CollectionViewCompositionalLayout은 다음과 같이 구성되어 있다. 
<br>

#### 1. item: 컬렉션 뷰를 이룰 때 쓰이는 한 개의 구성요소.
<br>
UICollectionViewCompositionalLayout에서 Item의 크기를 정하는 방법은 세 가지이며
<br>
Item을 생성할 때에는 **NSCollectionLayoutItem(layoutSize:)** 메소드를 사용한다.
<br>
layoutSize에는 각각의 Item의 크기를 정해줄 수 있는 NSCollectionLayoutSize(widthDimension:heightDimension:) 메소드가 들어가면 된다.

<br>
<br>

##### 1-1) .absolute:

NSCollectionLayoutSize(widthDimension: .absolute(10), heightDimension: .absolute(10))
<br>
이런 방식으로 사용하며 고정 크기를 의미한다.
<br>
즉, 우리가 원래 사용하듯이 width 10, height 10을 의미하는 것임.

##### 1-2) .estimated:

NSCollectionLayoutSize(widthDimension: .estimated(10), heightDimension: .estimated(10))
<br>
이런 방식으로 사용하며 대략적인 크기를 의미한다.
<br>
예를 들어 width를 일단 10으로 정해놓았지만 상황에 따라서 컴파일러가 크기를 약간 조절할 수 있다는 의미다.	

##### 1-3) .fractional:


NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(0.7))
<br>
이런 방식으로 사용하며 비율로 크기를 조정한다.
<br>
0 에서 1까지의 비율이 있는데 "1은 Item을 꽉 채우는 것을 의미한다." ⭐️
<br>
좀 더 쉽게 설명하자면 fractionalWidth(1)은 Item의 가로 부분을 꽉 채우겠다는 의미이고
<br>
fractionalHeight(1)은 Item의 세로 부분을 꽉 채우겠다는 의미이다.
<br.
예를 들어 fractionalWidth(0.5)는
<br>
"Item 반은 이미지 화면이 나오지만 반은 흰 공백 화면으로 나오는 것을 의미한다."
<br>
fractionalWidth(0.3)은 "Item의 30%만 이미지 화면이 나오고 70%는 흰 공백 화면으로 나오는 것을 의미한다."
	

<br>

#### 2. group: Item을 모두 합쳐놓은 구성요소. 
<br>
즉, Group은 여러 개의 Item들을 담고 있는 그릇이라고 생각하면 된다.
<br>
Group은 여러 개의 Item들을 어떤 방향으로 묶을지도 정해줘야 한다.
<br>
가로로 Item들을 묶을 때엔 .horizontal, 세로로 Item들을 묶을 때엔 .vertical을 사용한다.
<br>
Group을 생성할 때에는 두 가지 메소드로 또 나뉘게 된다. 

<br>
<br>


#### 1️⃣ NSCollectionLayoutGroup.horizontal(layoutSize:repeatingSubitem:count)

##### 1-1) layoutSize: 

Group의 전체 크기를 정해줄 수 있는 NSCollectionLayoutSize(widthDimension:heightDimension:) 메소드가 들어가면 된다.


##### 1-2) subitem: 

어떤 item이 들어갈 것인지. 보통 위에서 만들어 놓은 item을 여기에 할당한다.
<br>
한 Group 내에 몇 개의 item이 들어가는지에 따라서 subitem의 .fractional 영역을 조절해줘야 한다.


##### 1-3) count: 

몇 개의 item이 들어갈 것인지. 
<br>
예를 들어 4이라고 적으면 item 4개가 한 Group 안에 들어가게 된다.
<br>
따라서 한 Group 내에 Item 4개가 다 들어갈 수 있도록 개발자가 임의로 Item들의 .fractional 영역을 조절해줘야 한다.
<br>
(layoustSize:repeatingSubitem:count:) 파라미터를 보통 사용하는 경우는 똑같은 Item들이 반복되어 나열되어야 할 때이다.

	
#### 2️⃣ NSCollectionLayoutGroup.horizontal(layoutSize:subitems:)

##### 2-1) layoutSize: Group의 전체 크기를 정해줄 수 있는 NSCollectionLayoutSize(widthDimension:heightDimension:) 메소드가 들어가면 된다.


##### 2-2) subitems: 어떤 item이 들어갈 것인지. 이건 똑같다.
<br>
다만 subitems 파라미터를 보통 사용하는 경우는 
<br>
Group 내에 또다른 Group을 커스텀하여 넣고 싶을 때 사용한다.

	
⭐️⭐️ 이 두 메소드를 사용할 때 주의할 점 ⭐️⭐️
"item들이 몇 개 들어가냐에 따라서 개발자가 ⭐️item⭐️의 .fractionalWidth를 조절해줘야 한다."
예를 들어 Group 내에 item을 두 개를 넣는다고 가정하면 
"item"의 .fractionalWidth는 반드시 0.5여야 한다. (0.5 + 0.5)로 Group을 채워야 하기 때문.
만일 Group 내에 item을 4개 넣는다고 가정하면 
"item"의 .fractionalWidth는 반드시 0.25여야 한다. (0.25 * 4)로 Group을 채워야 하기 때문.



UICollectionViewCompositionalLayout에서 Group의 크기를 정하는 방법은 역시 세 가지이며
layoutSize에는 NSCollectionLayoutSize(widthDimension:heightDimension:) 
메소드가 들어가면 된다.

	1-1) .absolute
	NSCollectionLayoutSize(widthDimension: .absolute(10), heightDimension: .absolute(10))
	이런 방식으로 사용하며 고정 크기를 의미한다.
	즉, 우리가 원래 사용하듯이 width 10, height 10을 의미하는 것임.

	1-2) .estimated
	NSCollectionLayoutSize(widthDimension: .estimated(10), heightDimension: .estimated(10))
	이런 방식으로 사용하며 대략적인 크기를 의미한다.
	예를 들어 width를 일단 10으로 정해놓았지만 상황에 따라서 컴파일러가 크기를 약간 조절할 수 있다는 의미다.	

	1-3) .fractional
	NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(0.7))
	이런 방식으로 사용하며 비율로 크기를 조정한다.
	0 에서 1까지의 비율이 있는데 "1은 Group이 화면을 꽉 채우는 것을 의미한다." ⭐️
	예를 들어 fractionalWidth(1)은 Group의 가로를 꽉 채우는 것을 의미하며
	fractionalWidth(0.3)은
		"Group의 30%는 채우고 70%는 다른 Group으로 채우겠다는 의미이다."

 
3. section




## TableView 사용의 단점  

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



## ScrollView와 StackView의 조합

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

- CompositionalLayout GIF 출처: [https://demian-develop.tistory.com/22?category=908651](https://demian-develop.tistory.com/22?category=908651)
- [https://singularis7.tistory.com/104](https://singularis7.tistory.com/104)



