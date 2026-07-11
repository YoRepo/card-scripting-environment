--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Wall of Illusion  (ID: 13945283)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 4
-- ATK 1000 | DEF 1850
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is attacked by a monster, after damage calculation: Return that monster to the hand.
--[[ __CARD_HEADER_END__ ]]

--幻影の壁
function c13945283.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13945283,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c13945283.condition)
	e1:SetTarget(c13945283.target)
	e1:SetOperation(c13945283.operation)
	c:RegisterEffect(e1)
end
function c13945283.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==e:GetHandler() and not Duel.GetAttacker():IsStatus(STATUS_BATTLE_DESTROYED)
end
function c13945283.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,Duel.GetAttacker(),1,0,0)
end
function c13945283.operation(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if not a:IsRelateToBattle() then return end
	Duel.SendtoHand(a,nil,REASON_EFFECT)
end
