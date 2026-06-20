--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 闪刀术式-剪斗交刃  (ID: 46271408)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 277
--
-- Effect Text:
-- ①：自己的主要怪兽区域没有怪兽存在的场合，以自己墓地1只4星「闪刀姬」怪兽为对象才能发动。那只怪兽加入手卡。自己墓地有魔法卡3张以上存在的场合，也能不加入手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--閃刀術式－シザーズクロス
function c46271408.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_ACTION+CATEGORY_GRAVE_SPSUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c46271408.condition)
	e1:SetTarget(c46271408.target)
	e1:SetOperation(c46271408.activate)
	c:RegisterEffect(e1)
end
function c46271408.cfilter(c)
	return c:GetSequence()<5
end
function c46271408.thfilter(c,e,tp,spchk)
	return c:IsSetCard(0x1115) and c:IsLevel(4) and (c:IsAbleToHand() or (spchk and c:IsCanBeSpecialSummoned(e,0,tp,false,false)))
end
function c46271408.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c46271408.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c46271408.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local spchk=Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_SPELL)>=3
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c46271408.thfilter(chkc,e,tp,spchk) end
	if chk==0 then return Duel.IsExistingTarget(c46271408.thfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,spchk) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c46271408.thfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,spchk)
end
function c46271408.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if aux.NecroValleyNegateCheck(tc) then return end
		if Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_SPELL)>=3
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and tc:IsCanBeSpecialSummoned(e,0,tp,false,false)
			and Duel.SelectOption(tp,1190,1152)==1 then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		else
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
		end
	end
end
