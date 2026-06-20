--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 圣灵兽骑 风族  (ID: 96113307)
-- Type: Monster / Effect / Link
-- Attribute: WIND
-- Race: Psychic
-- ATK 2600 | LINK
-- Setcode: 16565
--
-- Effect Text:
-- 效果怪兽3只以上
-- 这个卡名的②③的效果1回合各能使用1次。
-- ①：只要这张卡在怪兽区域存在，双方不能为让卡的效果发动而把卡解放。
-- ②：以自己的除外状态的1张「灵兽」卡为对象才能发动。那张卡回到手卡·额外卡组。那之后，可以进行手卡1只「灵兽」怪兽的召唤。
-- ③：对方回合，以自己场上1张「灵兽」卡和对方场上1张卡为对象才能发动。那些卡除外。
--[[ __CARD_HEADER_END__ ]]

--聖霊獣騎 レイラウタリ
local s,id,o=GetID()
function s.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),3)
	c:EnableReviveLimit()
	--cannot release(uncompleted)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_RELEASE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,1)
	e1:SetTarget(s.rellimit)
	c:RegisterEffect(e1)
	--tohand/extra & summon bonus
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_TOEXTRA)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id)
	e2:SetTarget(s.bstg)
	e2:SetOperation(s.bsop)
	c:RegisterEffect(e2)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e3:SetCountLimit(1,id+o)
	e3:SetCondition(s.rmcon)
	e3:SetTarget(s.rmtg)
	e3:SetOperation(s.rmop)
	c:RegisterEffect(e3)
end
function s.rellimit(e,c,tp,r)
	return r&REASON_COST~=0
end
function s.bfilter(c)
	return c:IsSetCard(0xb5) and c:IsFaceup() and c:IsAbleToHand()
end
function s.sfilter(c)
	return c:IsSetCard(0xb5) and c:IsSummonable(true,nil)
end
function s.bstg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and s.bfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.bfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
	local g=Duel.SelectTarget(tp,s.bfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	local tc=g:GetFirst()
	if tc:IsAbleToExtra() then
		Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,g,1,0,0)
	else
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	end
end
function s.bsop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetTargetsRelateToChain():GetFirst()
	if tc then
		if Duel.SendtoHand(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)>0
			and Duel.IsExistingMatchingCard(s.sfilter,tp,LOCATION_HAND,0,1,nil)
			and Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
			local sumc=Duel.SelectMatchingCard(tp,s.sfilter,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
			if sumc then Duel.Summon(tp,sumc,true,nil) end
		end
	end
end
function s.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==1-tp
end
function s.rmfilter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0xb5) and c:IsAbleToRemove()
end
function s.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(s.rmfilter,tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectTarget(tp,s.rmfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,1,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g1,g1:GetCount(),0,0)
end
function s.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetTargetsRelateToChain()
	if tg:GetCount()>0 then
		Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)
	end
end
