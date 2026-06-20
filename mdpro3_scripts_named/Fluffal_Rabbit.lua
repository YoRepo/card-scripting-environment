--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 毛绒动物·兔子  (ID: 38124994)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fairy
-- Level 1
-- ATK 300 | DEF 1200
-- Setcode: 169
--
-- Effect Text:
-- 「毛绒动物·兔子」的效果1回合只能使用1次。
-- ①：这张卡成为融合召唤的素材送去墓地的场合，以自己墓地1只「锋利小鬼·剪刀」或者1只「毛绒动物·兔子」以外的「毛绒动物」怪兽为对象才能发动。那只怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ファーニマル・ラビット
function c38124994.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(38124994,1))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCountLimit(1,38124994)
	e1:SetCondition(c38124994.condition)
	e1:SetTarget(c38124994.target)
	e1:SetOperation(c38124994.operation)
	c:RegisterEffect(e1)
end
function c38124994.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and r==REASON_FUSION and not c:IsReason(REASON_RETURN)
end
function c38124994.filter(c)
	return (c:IsCode(30068120) or (c:IsSetCard(0xa9) and c:IsType(TYPE_MONSTER) and not c:IsCode(38124994)))
		and c:IsAbleToHand()
end
function c38124994.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c38124994.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c38124994.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c38124994.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c38124994.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
