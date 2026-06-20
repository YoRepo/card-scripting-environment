--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 朱罗纪似鸡龙  (ID: 43332022)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Dinosaur
-- Level 2
-- ATK 1200 | DEF 0
-- Setcode: 34
--
-- Effect Text:
-- ①：这张卡被战斗破坏送去墓地的场合发动。对方可以选1张手卡丢弃让这个效果无效。没丢弃的场合，把让这张卡破坏的怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--ジュラック・ガリム
function c43332022.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(43332022,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c43332022.descon)
	e1:SetTarget(c43332022.destg)
	e1:SetOperation(c43332022.desop)
	c:RegisterEffect(e1)
end
function c43332022.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c43332022.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=e:GetHandler():GetReasonCard()
	if tc:IsRelateToBattle() and not Duel.IsExistingMatchingCard(Card.IsDiscardable,1-tp,LOCATION_HAND,0,1,nil) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
	end
end
function c43332022.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetReasonCard()
	if not tc:IsRelateToBattle() then return end
	if Duel.IsExistingMatchingCard(Card.IsDiscardable,1-tp,LOCATION_HAND,0,1,nil) and Duel.SelectYesNo(1-tp,aux.Stringid(43332022,1)) then
		Duel.DiscardHand(1-tp,Card.IsDiscardable,1,1,REASON_EFFECT+REASON_DISCARD,nil)
	else Duel.Destroy(tc,REASON_EFFECT) end
end
