--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 深渊之兽 阿鲁伯  (ID: 45005708)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Dragon
-- Level 4
-- ATK 1800 | DEF 0
-- Setcode: 392
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡的卡名只要在场上·墓地存在当作「阿不思的落胤」使用。
-- ②：这张卡召唤·特殊召唤的场合，可以丢弃1张手卡，以对方的场上·墓地1只龙族怪兽为对象，从以下效果选择1个发动。
-- ●这张卡送去墓地，作为对象的场上的怪兽的控制权直到结束阶段得到。
-- ●这张卡送去墓地，作为对象的墓地的怪兽在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--深淵の獣アルベル
function c45005708.initial_effect(c)
	--change name
	aux.EnableChangeCode(c,68468459,LOCATION_MZONE+LOCATION_GRAVE)
	--control or special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,45005708)
	e1:SetCost(c45005708.cost)
	e1:SetTarget(c45005708.tg)
	e1:SetOperation(c45005708.op)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c45005708.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c45005708.filter1(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON) and c:IsControlerCanBeChanged()
end
function c45005708.filter2(c,e,tp)
	return c:IsRace(RACE_DRAGON) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c45005708.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then
		if e:GetLabel()==0 then
			return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c45005708.filter1(chkc)
		else
			return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c45005708.filter2(chkc,e,tp)
		end
	end
	local c=e:GetHandler()
	local b1=Duel.IsExistingTarget(c45005708.filter1,tp,0,LOCATION_MZONE,1,nil)
	local b2=Duel.IsExistingTarget(c45005708.filter2,tp,0,LOCATION_GRAVE,1,nil,e,tp) and Duel.GetMZoneCount(tp,c)>0
	if chk==0 then return c:IsAbleToGrave() and (b1 or b2) end
	local op=0
	if b1 and b2 then
		op=Duel.SelectOption(tp,aux.Stringid(45005708,0),aux.Stringid(45005708,1))
	elseif b1 then
		op=Duel.SelectOption(tp,aux.Stringid(45005708,0))
	else
		op=Duel.SelectOption(tp,aux.Stringid(45005708,1))+1
	end
	e:SetLabel(op)
	if op==0 then
		e:SetCategory(CATEGORY_CONTROL)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
		local g=Duel.SelectTarget(tp,c45005708.filter1,tp,0,LOCATION_MZONE,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
	else
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectTarget(tp,c45005708.filter2,tp,0,LOCATION_GRAVE,1,1,nil,e,tp)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,c,1,0,0)
end
function c45005708.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or Duel.SendtoGrave(c,REASON_EFFECT)==0 then return end
	if c:GetLocation()~=LOCATION_GRAVE or not tc:IsRelateToEffect(e) then return end
	if e:GetLabel()==0 then
		Duel.GetControl(tc,tp,PHASE_END,1)
	else
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
