--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 毛绒动物·猫  (ID: 2729285)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fairy
-- Level 1
-- ATK 700 | DEF 300
-- Setcode: 169
--
-- Effect Text:
-- 「毛绒动物·猫」的效果1回合只能使用1次。
-- ①：这张卡成为融合召唤的素材送去墓地的场合，以自己墓地1张「融合」为对象才能发动。那张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ファーニマル・キャット
function c2729285.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2729285,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCountLimit(1,2729285)
	e1:SetCondition(c2729285.condition)
	e1:SetTarget(c2729285.target)
	e1:SetOperation(c2729285.operation)
	c:RegisterEffect(e1)
end
function c2729285.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and r==REASON_FUSION and not c:IsReason(REASON_RETURN)
end
function c2729285.filter(c)
	return c:IsCode(24094653) and c:IsAbleToHand()
end
function c2729285.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c2729285.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c2729285.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c2729285.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c2729285.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
