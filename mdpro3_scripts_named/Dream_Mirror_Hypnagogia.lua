--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 梦现之梦魔镜  (ID: 25964547)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 305
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：「圣光之梦魔镜」「黯黑之梦魔镜」各1张从手卡·卡组选出，那之内的1张在自己的场地区域，另1张在对方的场地区域各自表侧表示放置。
--[[ __CARD_HEADER_END__ ]]

--夢現の夢魔鏡
function c25964547.initial_effect(c)
	aux.AddCodeList(c,74665651,1050355)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,25964547+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c25964547.target)
	e1:SetOperation(c25964547.activate)
	c:RegisterEffect(e1)
end
function c25964547.cfilter1(c,tp)
	return c:IsCode(74665651,1050355) and c:CheckUniqueOnField(tp) and not c:IsForbidden()
		and Duel.IsExistingMatchingCard(c25964547.cfilter2,tp,LOCATION_HAND+LOCATION_DECK,0,1,c,tp,c:GetCode())
end
function c25964547.cfilter2(c,tp,code)
	return c:IsCode(74665651,1050355) and not c:IsCode(code) and c:CheckUniqueOnField(1-tp) and not c:IsForbidden()
end
function c25964547.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c25964547.cfilter1,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,tp) end
end
function c25964547.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(25964547,0))
	local g1=Duel.SelectMatchingCard(tp,c25964547.cfilter1,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,tp)
	local tc1=g1:GetFirst()
	if not tc1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(25964547,1))
	local g2=Duel.SelectMatchingCard(tp,c25964547.cfilter2,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,tp,tc1:GetCode())
	local tc2=g2:GetFirst()
	if Duel.MoveToField(tc1,tp,tp,LOCATION_FZONE,POS_FACEUP,false) then
		if Duel.MoveToField(tc2,tp,1-tp,LOCATION_FZONE,POS_FACEUP,false) then
			tc2:SetStatus(STATUS_EFFECT_ENABLED,true)
		end
		tc1:SetStatus(STATUS_EFFECT_ENABLED,true)
	end
end
