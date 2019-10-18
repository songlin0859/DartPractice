# Bug总结
## 1、空指针(NullPointerException)除了直接使用导致空指针异常，一些操作可能会隐含空指针
### 1.1、比如使用android.widget.ArrayAdapter<T>,当传入的 **objects** 中某一项为空时 且 object 不是CharSequence或其子类，会导致空指针
```

	public @NonNull View getView(int position, @Nullable View convertView,
            @NonNull ViewGroup parent) {
        return createViewFromResource(mInflater, position, convertView, parent, mResource);
    }

	private @NonNull View createViewFromResource(@NonNull LayoutInflater inflater, int position,
            @Nullable View convertView, @NonNull ViewGroup parent, int resource) {
        final View view;
        final TextView text;

        if (convertView == null) {
            view = inflater.inflate(resource, parent, false);
        } else {
            view = convertView;
        }

        try {
            if (mFieldId == 0) {
                //  If no custom field is assigned, assume the whole resource is a TextView
                text = (TextView) view;
            } else {
                //  Otherwise, find the TextView field within the layout
                text = view.findViewById(mFieldId);

                if (text == null) {
                    throw new RuntimeException("Failed to find view with ID "
                            + mContext.getResources().getResourceName(mFieldId)
                            + " in item layout");
                }
            }
        } catch (ClassCastException e) {
            Log.e("ArrayAdapter", "You must supply a resource ID for a TextView");
            throw new IllegalStateException(
                    "ArrayAdapter requires the resource ID to be a TextView", e);
        }

        final T item = getItem(position);
        if (item instanceof CharSequence) {
            text.setText((CharSequence) item);
        } else {
            text.setText(item.toString()); //<==================
        }

        return view;
    }
```
### 1.2、隐含操作导致空指针 比如int float 的包装类型拆箱 Switch中传入的String内容等
```

	public class JavaDemo {
	    public static void main(String[] args){
	        Integer aInt=null;
	        //System.out.println(aInt==3);
	//Exception in thread "main" java.lang.NullPointerException at main.java.JavaDemo.main(JavaDemo.java:7)
	        System.out.println(3==aInt);//这两行都会导致空指针 
	    }
	}
	
	public class JavaDemo {
	    public static void main(String[] args){
	        String caseStr = null ;
	//Exception in thread "main" java.lang.NullPointerException at main.java.JavaDemo.main(JavaDemo.java:7)
	        switch (caseStr){
	            case "Hello":break;
	            case "World":break;
	            default:break;
	        }
	    }
	}
```

### 1.3、比较字符串或者类相等时，确保调用equals方法的对象不为null 和常量比较时使用常量的equals方法(之前空闲货位没有库存后台返回null 导致有问题)；
```

	private static final String IS_TRUE = "1";
	//是否是批次货品 推荐用以下方式
    if (IS_TRUE.equals(goods.getIsBatch())) {
	}
	//不推荐使用下面的方式
	if (goods.getIsBatch().equals(IS_TRUE)) {
	}
	//没有常量类型参与的 使用前先判空 比如下面比较skuId是否相等，不要相信后台传的数据一定有skuId
	skuId!=null && skuId.equals(goodsBean.getSkuId())
```
### 1.4、Fragment中获取Activity Activity已经被销毁
```
	
	//com.example.distribution.fragment.wave.AllWaveFragment#initAdapterListener
	DialogUtil.confirm(getActivity(), 
	Util.getString(R.string.dis_cannot_use_bluetooth_pickup_tips), true, new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                if (dataBean.getWaveStatus() == 1) {
                                    editTextDialog.show();
                                } else {
                                    activityIntent(GsonUtil.gsonString(dataBean));
                                }
                            }
                        });
```
### 1.5、判断接口返回的是否有数据 要通过 datas!=null && datas.size()>0 判断，不能用datas.isEmpty()
```

	private void getUserDetail(String userName) {
        model.getUserDetail(userName, new DFHttpCallBack<UserDetailBean>(getView().getActivity(), false) {
            @Override
            public void onSuccess(UserDetailBean response) {
                if (response.getCode() == DFResponse.STATUS_SUCCESS) {
					//判断是否有返回内容 避免使用.isEmpty()
                    if (!response.getResult().getData().isEmpty()) {
                        DFCacheHelper.setRealName(response.getResult().getData().get(0).getRealName());
                    }
                    if (TextUtils.isEmpty(DFCacheHelper.getStore())) {
                        goSelectStore();
                    } else {
                        Intent intent = new Intent(getView().getActivity(), MainActivity.class);
                        getView().getActivity().startActivity(intent);
                    }
                    ActivityStack.getActivity().finishAll();
                } else {
                    PrintUtil.toastMakeText(response.getMsg() + response.getResult().getContextId());
                }
            }

            @Override
            public void onError(String msg) {
                super.onError(msg);
                Util.playFail();
                PrintUtil.toastMakeText(msg);
            }
        });
    }
	
```
### 1.6、对于可能被释放或者置空的对象，使用的时候要判空（最近突然出现很多的 显示进度条 报空指针）
```

	java.lang.NullPointerException !!! 最近报了很多个
	Attempt to invoke interface method 'void com.example.distribution.view.HaveListView.showProgress(boolean)' on a null object reference
	解析原始
	1 com.example.distribution.presenter.inventory.NoListInventoryPresenter$12.onComplete(NoListInventoryPresenter.java:1131)
	2 df.jky.pda.net.i.DFHttpCallBack.onFailure(DFHttpCallBack.java:208)
	//产生原因=== 网络请求或者完成时 页面返回了或者销毁了 showProgress方法所在的对象被置空 导致空指针发生
	
	@Override
    protected void onDestroy() {
        if (presenter != null) {
            presenter.onDestroy();
        }
        super.onDestroy();
        isDestroy = true;
        if (presenter != null) {
			//这里...	
            presenter.detach();
        }
    }

	public void dettach() {
        if (getView() != null) {
            return;
        }
        getView().showProgress(false);
            getView().showProgress(false);
        }
        vRef = null;
    }

	public V getView() {
        return vRef;
    }
	
```
## 2、IndexOutOfBoundsException 下标越界
### 2.1、接口获取数据 如果返回的是列表 就算是成功状态【返回200】 ，获取列表中的元素也要先判断列表的size
```
	
	private void getUserDetail(String userName) {
        model.getUserDetail(userName, new DFHttpCallBack<UserDetailBean>(getView().getActivity(), false) {
            @Override
            public void onSuccess(UserDetailBean response) {
                if (response.getCode() == DFResponse.STATUS_SUCCESS) {
					//判断是否有返回内容 避免使用.isEmpty()
                    if (!response.getResult().getData().isEmpty()) {
						//不报空指针也可能会报数组越界
                        DFCacheHelper.setRealName(response.getResult().getData().get(0).getRealName());
                    }
                    ...
                } else {
                    ...
                }
            }

            ...
        });
    }	


	//或者这样直接get(0)
	response.getResult().getData().get(0)

```

### 2.2、onItemClick 列表点击时（可能是放了很久、有些放了一天没用 或者是数据和列表上的数据没有同步）导致获取列表item对应的内容时出错（难复现）
```
	
	java.lang.IndexOutOfBoundsException
	Index: 1, Size: 0
	com.example.distribution.fragment.wave.ToBeSortedFragment$1.onItemClick(ToBeSortedFragment.java:127)

```

### 2.3、字符串截取等操作
```

	int index = ip.indexOf("/");
	//注意 index 可能为 -1 
    if (index>0){
        ip = ip.substring(0,index);
    }
	

	/* @param      beginIndex   the beginning index, inclusive.
     * @param      endIndex     the ending index, exclusive.
     * @return     the specified substring.
     * @exception  IndexOutOfBoundsException  if the
     *             {@code beginIndex} is negative, or
     *             {@code endIndex} is larger than the length of
     *             this {@code String} object, or
     *             {@code beginIndex} is larger than
     *             {@code endIndex}.
     */
    public String substring(int beginIndex, int endIndex) {
        if (beginIndex < 0) {
            throw new StringIndexOutOfBoundsException(this, beginIndex);
        }
        if (endIndex > length()) {
            throw new StringIndexOutOfBoundsException(this, endIndex);
        }
        int subLen = endIndex - beginIndex;
        if (subLen < 0) {
            throw new StringIndexOutOfBoundsException(subLen);
        }

        return ((beginIndex == 0) && (endIndex == length())) ? this
                : fastSubstring(beginIndex, subLen);
    }
	
```
## 3、NumberFormatException 
```

	//解析数字推荐使用自己封装好的NumberUtil的解析方法
	df.jky.pda.util.NumberUtil.parseFloat(java.lang.String)
    df.jky.pda.util.NumberUtil.parseFloat(java.lang.String, float)
    df.jky.pda.util.NumberUtil.parseDouble(java.lang.String)
    df.jky.pda.util.NumberUtil.parseDouble(java.lang.String, double)
    df.jky.pda.util.NumberUtil.parseInt(java.lang.String)
    df.jky.pda.util.NumberUtil.parseInt(java.lang.String, int)
	//或者自己try catch住解析的代码
	try{
		double count= Double.parse(countStr); 
	}catch(Exception){
		//异常操作或者提示
	}

	
	//避免直接使用Integer/Long/Float/Double直接parse 或者 valueOf方法 可能货抛出异常
	/* @param   s   the string to be parsed.
     * @return  a {@code Float} object holding the value
     *          represented by the {@code String} argument.
     * @throws  NumberFormatException  if the string does not contain a
     *          parsable number.
     */
    public static Float valueOf(String s) throws NumberFormatException {
        return new Float(parseFloat(s));
    }

	/**
     * Returns a new {@code float} initialized to the value
     * represented by the specified {@code String}, as performed
     * by the {@code valueOf} method of class {@code Float}.
     *
     * @param  s the string to be parsed.
     * @return the {@code float} value represented by the string
     *         argument.
     * @throws NullPointerException  if the string is null
     * @throws NumberFormatException if the string does not contain a
     *               parsable {@code float}.
     * @see    java.lang.Float#valueOf(String)
     * @since 1.2
     */
    public static float parseFloat(String s) throws NumberFormatException {
        return FloatingDecimal.parseFloat(s);
    }


	//解析之前对字符串最好做trim操作
	#32202 java.lang.NumberFormatException
	For input string: " 3"
	df.jky.pda.presenter.SpeechPresenter$onClick$2.itemClick(SpeechPresenter.kt:82)
	
```

## 4、 java.lang.IllegalArgumentException
```

	//报错
	# main(2)
	java.lang.IllegalStateException
	View android.widget.LinearLayout{e5d77aa V.E...... ......ID 0,0-640,131} has already been added to the window manager.
	解析原始
	1 android.view.WindowManagerGlobal.addView(WindowManagerGlobal.java:328)
	2 android.view.WindowManagerImpl.addView(WindowManagerImpl.java:93)
	3 android.widget.Toast$TN.handleShow(Toast.java:496)
	4 android.widget.Toast$TN$1.handleMessage(Toast.java:400)
	5 android.os.Handler.dispatchMessage(Handler.java:106)
	6 android.os.Looper.loop(Looper.java:164)
	7 android.app.ActivityThread.main(ActivityThread.java:6523)
	8 java.lang.reflect.Method.invoke(Native Method)
	9 com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:438)
	10 com.android.internal.os.ZygoteInit.main(ZygoteInit.java:857)

	//调用流程
	util.PrintUtil#toastMakeText(java.lang.String)
		... -> android.widget.Toast.TN#handleShow
		//可能是mView.getParent()返回null 导致mWM.removeView(mView);没有执行到
		if (mView.getParent() != null) {
            if (localLOGV) Log.v(TAG, "REMOVE! " + mView + " in " + this);
            mWM.removeView(mView);
        }
        if (localLOGV) Log.v(TAG, "ADD! " + mView + " in " + this);
        // Since the notification manager service cancels the token right
        // after it notifies us to cancel the toast there is an inherent
        // race and we may attempt to add a window after the token has been
        // invalidated. Let us hedge against that.
        try {
            mWM.addView(mView, mParams);
            trySendAccessibilityEvent();
        } catch (WindowManager.BadTokenException e) {
            /* ignore */
        }
			->
			@Override
		    public void addView(@NonNull View view, @NonNull ViewGroup.LayoutParams params) {
		        applyDefaultToken(params);
		        mGlobal.addView(view, params, mContext.getDisplay(), mParentWindow);
		    }
				->android.view.WindowManagerGlobal#addView
				public void addView(View view, ViewGroup.LayoutParams params,Display display, Window parentWindow) {
		        	...
		            int index = findViewLocked(view, false);
		            if (index >= 0) {
		                if (mDyingViews.contains(view)) {
		                    // Don't wait for MSG_DIE to make it's way through root's queue.
		                    mRoots.get(index).doDie();
		                } else {
							//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		                    throw new IllegalStateException("View " + view
		                            + " has already been added to the window manager.");
		                }
		                // The previous removeView() had not completed executing. Now it has.
		            }
		            ...
		    }
```
