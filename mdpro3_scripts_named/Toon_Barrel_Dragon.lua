--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 卡通左轮手枪龙  (ID: 28112535)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 7
-- ATK 2600 | DEF 2200
-- Setcode: 98
--
-- Effect Text:
-- ①：这张卡在召唤·反转召唤·特殊召唤的回合不能攻击。
-- ②：自己场上有「卡通世界」存在，对方场上没有卡通怪兽存在的场合，这张卡可以直接攻击。
-- ③：1回合1次，以场上1张卡为对象才能发动。进行3次投掷硬币，那之内2次以上是表的场合，那张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--トゥーン・リボルバー・ドラゴン
function c28112535.initial_effect(c)
	aux.AddCodeList(c,15259703)
	--cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c28112535.atklimit)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--direct attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DIRECT_ATTACK)
	e4:SetCondition(c28112535.dircon)
	c:RegisterEffect(e4)
	--destroy
	local e5=Effect.CreateEffect(c)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetCategory(CATEGORY_DESTROY+CATEGORY_COIN)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetTarget(c28112535.destg)
	e5:SetOperation(c28112535.desop)
	c:RegisterEffect(e5)
end
function c28112535.atklimit(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c28112535.cfilter1(c)
	return c:IsFaceup() and c:IsCode(15259703)
end
function c28112535.cfilter2(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c28112535.dircon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(c28112535.cfilter1,tp,LOCATION_ONFIELD,0,1,nil)
		and not Duel.IsExistingMatchingCard(c28112535.cfilter2,tp,0,LOCATION_MZONE,1,nil)
end
function c28112535.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,3)
end
function c28112535.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local c1,c2,c3=Duel.TossCoin(tp,3)
		if c1+c2+c3<2 then return end
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
