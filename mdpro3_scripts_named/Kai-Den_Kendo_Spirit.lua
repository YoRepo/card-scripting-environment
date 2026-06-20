--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 剑道魂 皆传  (ID: 71614230)
-- Type: Monster / Effect / Spirit / Pendulum
-- Attribute: WIND
-- Race: Warrior
-- Level 5
-- Pendulum Scales: L9 / R9
-- ATK 2400 | DEF 1000
--
-- Effect Text:
-- ←9 【灵摆】 9→
-- ①：场上有怪兽灵摆召唤的场合发动。灵摆区域的这张卡回到持有者手卡。
-- 【怪兽效果】
-- ①：这张卡召唤成功时才能发动。选自己的灵摆区域1张卡，和那张卡相同纵列的对方的卡全部送去墓地。
-- ②：这张卡召唤·反转的回合的结束阶段发动。这张卡回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--ケンドウ魂 KAI－DEN
function c71614230.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spirit return
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(c71614230.thcon)
	e1:SetTarget(c71614230.thtg)
	e1:SetOperation(c71614230.thop)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c71614230.gytg)
	e2:SetOperation(c71614230.gyop)
	c:RegisterEffect(e2)
end
function c71614230.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsSummonType,1,nil,SUMMON_TYPE_PENDULUM)
end
function c71614230.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c71614230.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SendtoHand(c,nil,REASON_EFFECT)
end
function c71614230.tgfilter(c,tp)
	return Duel.IsExistingMatchingCard(c71614230.gyfilter,tp,0,LOCATION_ONFIELD,1,nil,c:GetColumnGroup())
end
function c71614230.gyfilter(c,g)
	return g:IsContains(c)
end
function c71614230.gytg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c71614230.tgfilter,tp,LOCATION_PZONE,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,0,1-tp,LOCATION_ONFIELD)
end
function c71614230.gyop(e,tp,eg,ep,ev,re,r,rp)
	local pg=Duel.SelectMatchingCard(tp,c71614230.tgfilter,tp,LOCATION_PZONE,0,1,1,nil,tp)
	if pg:GetCount()==0 then return end
	local g=Duel.GetMatchingGroup(c71614230.gyfilter,tp,0,LOCATION_ONFIELD,nil,pg:GetFirst():GetColumnGroup())
	Duel.SendtoGrave(g,REASON_EFFECT)
end
