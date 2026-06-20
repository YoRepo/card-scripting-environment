--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 半龙女仆·天风龙女  (ID: 15848542)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Dragon
-- Level 8
-- ATK 2700 | DEF 1700
-- Setcode: 307
--
-- Effect Text:
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：把这张卡从手卡丢弃，以场上1只表侧表示怪兽为对象才能发动。这个回合，双方不能把那只表侧表示怪兽的场上发动的效果发动。
-- ②：只要自己场上有融合怪兽存在，这张卡不会被效果破坏。
-- ③：自己·对方的战斗阶段结束时才能发动。这张卡回到手卡，从手卡把1只3星「半龙女仆」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ドラゴンメイド・ルフト
function c15848542.initial_effect(c)
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(15848542,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,15848542)
	e1:SetCost(c15848542.actcost)
	e1:SetTarget(c15848542.acttg)
	e1:SetOperation(c15848542.actop)
	c:RegisterEffect(e1)
	--indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c15848542.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(15848542,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,15848543)
	e3:SetTarget(c15848542.sptg)
	e3:SetOperation(c15848542.spop)
	c:RegisterEffect(e3)
end
function c15848542.actcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c15848542.actfilter(c)
	return c:IsFaceup() and (c:IsType(TYPE_EFFECT) or bit.band(c:GetOriginalType(),TYPE_EFFECT)==TYPE_EFFECT)
end
function c15848542.acttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c15848542.actfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c15848542.actfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c15848542.actfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c15848542.actop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1,true)
	end
end
function c15848542.indfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION)
end
function c15848542.indcon(e)
	return Duel.IsExistingMatchingCard(c15848542.indfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c15848542.spfilter(c,e,tp)
	return c:IsSetCard(0x133) and c:IsLevel(3) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c15848542.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToHand()
		and Duel.GetMZoneCount(tp,c)>0
		and Duel.IsExistingMatchingCard(c15848542.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c15848542.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SendtoHand(c,nil,REASON_EFFECT)~=0
		and c:IsLocation(LOCATION_HAND) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c15848542.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
