--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 红炎之骑士  (ID: 36569343)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level 4
-- ATK 1400 | DEF 1200
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：这张卡已在怪兽区域存在的状态，这张卡以外的炎属性怪兽被破坏送去自己墓地的场合发动。从卡组把1只炎属性怪兽送去墓地。
-- ②：这张卡被破坏送去墓地的场合发动。从卡组把1只炎属性怪兽送去墓地。
--[[ __CARD_HEADER_END__ ]]

--紅炎の騎士
function c36569343.initial_effect(c)
	--send to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(36569343,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,36569343)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c36569343.tgcon1)
	e1:SetTarget(c36569343.tgtg)
	e1:SetOperation(c36569343.tgop1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(36569343,0))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCountLimit(1,36569343)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c36569343.tgcon2)
	e2:SetTarget(c36569343.tgtg)
	e2:SetOperation(c36569343.tgop2)
	c:RegisterEffect(e2)
end
function c36569343.cfilter(c,tp)
	return c:IsControler(tp) and c:IsReason(REASON_DESTROY) and c:IsAttribute(ATTRIBUTE_FIRE)
end
function c36569343.tgcon1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c36569343.cfilter,1,nil,tp)
end
function c36569343.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c36569343.tgop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c36569343.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c36569343.tgcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY)
end
function c36569343.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAttribute(ATTRIBUTE_FIRE) and c:IsAbleToGrave()
end
function c36569343.tgop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c36569343.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
