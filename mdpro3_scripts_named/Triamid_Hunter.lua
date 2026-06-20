--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 三形金字塔的猎人  (ID: 95923441)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 3
-- ATK 1400 | DEF 1100
-- Setcode: 226
--
-- Effect Text:
-- ①：场地魔法卡表侧表示存在的场合，自己在通常召唤外加上只有1次，自己主要阶段可以把1只岩石族怪兽召唤。
-- ②：对方回合1次，以自己场上1张「三形金字塔」场地魔法卡为对象才能发动。那张卡送去墓地，从卡组把和那张卡卡名不同的1张「三形金字塔」场地魔法卡发动。
--[[ __CARD_HEADER_END__ ]]

--トラミッド・ハンター
function c95923441.initial_effect(c)
	--extra summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95923441,1))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetCondition(c95923441.sumcon)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_ROCK))
	c:RegisterEffect(e1)
	--field
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(95923441,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCondition(c95923441.condition)
	e2:SetTarget(c95923441.target)
	e2:SetOperation(c95923441.operation)
	c:RegisterEffect(e2)
end
function c95923441.sumcon(e)
	return Duel.IsExistingMatchingCard(Card.IsFaceup,0,LOCATION_FZONE,LOCATION_FZONE,1,nil)
end
function c95923441.filter(c,tp,code)
	return c:IsType(TYPE_FIELD) and c:IsSetCard(0xe2) and c:GetActivateEffect():IsActivatable(tp,true,true) and not c:IsCode(code)
end
function c95923441.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c95923441.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=Duel.GetFieldCard(tp,LOCATION_FZONE,0)
	if chkc then return false end
	if chk==0 then return tc and tc:IsFaceup() and tc:IsSetCard(0xe2) and tc:IsAbleToGrave() and tc:IsCanBeEffectTarget(e)
		and Duel.IsExistingMatchingCard(c95923441.filter,tp,LOCATION_DECK,0,1,nil,tp,tc:GetCode()) end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,tc,1,0,0)
end
function c95923441.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoGrave(tc,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
		local g=Duel.SelectMatchingCard(tp,c95923441.filter,tp,LOCATION_DECK,0,1,1,nil,tp,tc:GetCode())
		if g:GetCount()>0 then
			local tc=g:GetFirst()
			Duel.MoveToField(tc,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
			local te=tc:GetActivateEffect()
			te:UseCountLimit(tp,1,true)
			local tep=tc:GetControler()
			local cost=te:GetCost()
			if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
			Duel.RaiseEvent(tc,4179255,te,0,tp,tp,Duel.GetCurrentChain())
		end
	end
end
